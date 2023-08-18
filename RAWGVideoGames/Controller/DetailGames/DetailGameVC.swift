//
//  DetailGameVC.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import UIKit

class DetailGameVC: UIViewController {
    
    @IBOutlet weak var tumbnailImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var playerPlayLbl: UILabel!
    @IBOutlet weak var rateGameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    let viewModel = VideoGamesVM()
    var videoGameId: Int = 0
    var videoGames: VideoGames?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupBarButtonItem()
        callApi()
    }
}

//MARK: - CallApi and Data
extension DetailGameVC {
    func callApi(){
        if videoGames == nil {
            showLoading()
            viewModel.fetchDetailVideoGames(id: videoGameId) { [weak self] results in
                switch results {
                case .success(let videoDetail):
                    DispatchQueue.main.async {
                        self?.setupContent(data: videoDetail)
                    }
                case .failure(let failure):
                    print("errorrr: \(failure.localizedDescription)")
                }
                self?.hideLoading()
            }
        } else {
            setupContentData()
        }
    }
}

//MARK: - SetupData
extension DetailGameVC {
    func setupContent(data: VideoGameResults){
        descLbl.attributedText = data.description?.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "Arial", size: 12), csscolor: "black", lineheight: 5, csstextalign: "left")
        configData(title: data.name, release: data.released, rating: "\(data.rating ?? 0)", playerPlay: "\(data.playtime ?? 0)")
        if let detailGame = URL(string: data.background_image ?? "") {
            tumbnailImg.downloaded(from: detailGame, contentMode: .scaleAspectFill)
        }
    }
    
    func setupContentData(){
        guard let videoGames = videoGames else { return }
        descLbl.text = videoGames.desc
        configData(title: videoGames.title, release: videoGames.released, rating: videoGames.rating, playerPlay: videoGames.playerPlay)
        if let imagesData = videoGames.videoImg {
            let imageData = UIImage(data: imagesData)
            tumbnailImg.image = imageData
        }
    }
    
    func configData(title: String?, release: String?, rating: String?, playerPlay: String?){
        titleLbl.text = title
        releaseLbl.text = release
        rateGameLbl.text = rating
        playerPlayLbl.text = "\(playerPlay ?? "") played"
    }
}

extension DetailGameVC {
    func setupBarButtonItem(){
        let images = videoGames != nil ? "trash" : "heart"
        let saveBtn = UIBarButtonItem(image: UIImage(named: images), style: .plain, target: self, action: #selector(saveVideoGame))
        self.navigationItem.rightBarButtonItem  = saveBtn
    }
    
    @objc func saveVideoGame(){
        if videoGames == nil {
            saveVideoGames(with: VideoGameData(rating: rateGameLbl.text , released: releaseLbl.text, title: titleLbl.text, videoImg: tumbnailImg.image?.jpegData(compressionQuality: 1), desc: descLbl.text, play: playerPlayLbl.text))
        } else {
            guard let videoGames = videoGames else { return }
            deleteVideoGames(with: videoGames)
        }
    }
    
    func saveVideoGames(with data: VideoGameData) {
        showLoading()
        _ = CoreDataManager.sharedManager.insertVideoDetail(data: data)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            [weak self] in
            self?.hideLoading()
            self?.showAlert(title: "Success", message: "Success Saved Data", actionTitle: "Closed") {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func deleteVideoGames(with data: VideoGames){
        showLoading()
        _ = CoreDataManager.sharedManager.delete(title: data.title ?? "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            [weak self] in
            self?.hideLoading()
            self?.showAlert(title: "Success", message: "Success Delete Data", actionTitle: "Closed") {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
