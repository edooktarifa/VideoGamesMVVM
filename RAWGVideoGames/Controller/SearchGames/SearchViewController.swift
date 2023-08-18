//
//  SearchViewController.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import UIKit

protocol SearchVideoDelegate {
    func moveToDetailVideoGame(id: Int)
}

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = VideoGamesVM()
    var query: String = ""
    
    var listMovieSearch: [VideoGameResults] = []
    var delegate: SearchVideoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func registerCollectionView(){
        collectionView.register(UINib(nibName: "SearchGamesResultCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchGamesResultCellCollectionViewCell")
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovieSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchGamesResultCellCollectionViewCell", for: indexPath) as? SearchGamesResultCellCollectionViewCell else { return UICollectionViewCell() }
        cell.titleLbl.text = listMovieSearch[indexPath.row].name
        cell.releaseLbl.text = listMovieSearch[indexPath.row].released
        cell.ratingLbl.text = "\(listMovieSearch[indexPath.row].rating ?? 0)"
        if let urlImages = URL(string: listMovieSearch[indexPath.row].background_image ?? "") {
            cell.searchImg.downloaded(from: urlImages, contentMode: .scaleAspectFill)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.000
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3) - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.moveToDetailVideoGame(id: listMovieSearch[indexPath.row].id ?? 0)
    }
}
