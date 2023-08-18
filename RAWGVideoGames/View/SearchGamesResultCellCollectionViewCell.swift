//
//  SearchGamesResultCellCollectionViewCell.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import UIKit

class SearchGamesResultCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var searchImg: UIImageView!{
        didSet {
            searchImg.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
