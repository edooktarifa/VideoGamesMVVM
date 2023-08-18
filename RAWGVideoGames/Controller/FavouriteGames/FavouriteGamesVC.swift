//
//  FavouriteGamesVC.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import UIKit

class FavouriteGamesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var videoGames: [VideoGames?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Favourite Games"
        tableView.register(UINib(nibName: "GamesCell", bundle: nil), forCellReuseIdentifier: "GamesCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllFavouriteGames()
    }
}

//MARK: - Call API
extension FavouriteGamesVC {
    func fetchAllFavouriteGames(){
        if CoreDataManager.sharedManager.fetchAllVideoGames() != nil {
            if let videoGames = CoreDataManager.sharedManager.fetchAllVideoGames() {
                self.videoGames = videoGames.reversed()
                tableView.reloadData()
            }
        }
    }
}

//MARK: - Table View DataSource & table View Delegate
extension FavouriteGamesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GamesCell", for: indexPath) as? GamesCell else { return UITableViewCell() }
        cell.deletedBtn.isHidden = false
        cell.deletedBtn.tag = indexPath.row
        cell.deletedBtn.addTarget(self, action: #selector(removeFavourite(sender:)), for: .touchUpInside)
        if let videoGames = videoGames[indexPath.row] {
            cell.setupContent(data: videoGames)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailGameVC()
        vc.videoGames = videoGames[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @objc func removeFavourite(sender: UIButton){
        showLoading()
        _ = CoreDataManager.sharedManager.delete(title: videoGames[sender.tag]?.title ?? "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            [weak self] in
            self?.videoGames.remove(at: sender.tag)
            self?.hideLoading()
            self?.tableView.reloadData()
        }
    }
}
