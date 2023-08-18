//
//  GamesForYouCell.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import UIKit

class GamesCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var tumbnailImg: UIImageView!{
        didSet{
            tumbnailImg.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var deletedBtn: UIButton! {
        didSet {
            deletedBtn.layer.cornerRadius = 5
        }
    }
    
    func setupContent(data: Any){
        if let videoGames = data as? VideoGames? {
            setupContainData(title: videoGames?.title, released: videoGames?.released, rating: videoGames?.rating ?? "")
            if let imagesData = videoGames?.videoImg {
                let imageData = UIImage(data: imagesData)
                tumbnailImg.image = imageData
            }
        } else if let videoGameResults = data as? VideoGameResults {
            setupContainData(title: videoGameResults.name, released: "\(videoGameResults.released ?? "")", rating: "\(videoGameResults.rating ?? 0)")
            if let imageUrl = URL(string: videoGameResults.background_image ?? "") {
                tumbnailImg.downloaded(from: imageUrl, contentMode: .scaleAspectFill)
            }
        }
    }
    
    func setupContainData(title: String?, released: String?, rating: String?){
        titleLbl.text = title
        releaseLbl.text = "Released Data " + (released ?? "")
        ratingLbl.text = rating
    }
}
