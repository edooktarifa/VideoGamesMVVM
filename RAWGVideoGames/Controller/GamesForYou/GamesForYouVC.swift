//
//  ViewController.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import UIKit

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class GamesForYouVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    
    var searchController: UISearchController!
    var listGame: [VideoGameResults] = []
    let vm = VideoGamesVM()
    var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigation()
        setupTableView()
        setupSearchBar()
        fetchApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

//MARK: - Call Api
extension GamesForYouVC {
    func fetchApi(){
        showLoading()
        vm.fetchVideoGamesList { [weak self] results in
            switch results {
            case .success(let videoGames):
                guard let videoGamesResults = videoGames.results else { return }
                self?.listGame = videoGamesResults
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let failure):
                print("failureee: \(failure)")
            }
            self?.hideLoading()
        }
    }
    
    func searchGamesApi(query: String, controller: SearchViewController) {
        showLoading()
        vm.fetchSearchResultGames(query: query) { [weak self] results in
            switch results {
            case .success(let success):
                guard let listMovie = success.results else { return }
                DispatchQueue.main.async {
                    controller.listMovieSearch = listMovie
                    controller.collectionView.reloadData()
                    controller.delegate = self
                }
            case .failure(_):
                break
            }
            self?.hideLoading()
        }
    }
}

//MARK: - Setup UI
extension GamesForYouVC {
    
    func setupNavigation(){
        title = "Games For You"
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "GamesCell", bundle: nil), forCellReuseIdentifier: "GamesCell")
    }
    
    func setupSearchBar(){
        searchController = UISearchController(searchResultsController: SearchViewController())
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        searchBarView.addSubview(searchController.searchBar)
    }
}

//MARK: - UISearch Delegate
extension GamesForYouVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 1, !query.isEmpty, let resultsController = searchController.searchResultsController as? SearchViewController else { return }
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.searchGamesApi(query: query, controller: resultsController)
        }
    }
}

//MARK: -data source and delegate tableview
extension GamesForYouVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GamesCell", for: indexPath) as? GamesCell else { return UITableViewCell() }
        cell.setupContent(data: listGame[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailGameVC()
        vc.videoGameId = Int(listGame[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10 {
            vm.pagination += 1
            showLoading()
            vm.fetchPaginationGames { [weak self] results in
                switch results {
                case .success(let videoGames):
                    guard let videoGamesResults = videoGames.results else { return }
                    self?.listGame.append(contentsOf: videoGamesResults)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let failure):
                    print("failureee: \(failure)")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self?.hideLoading()
                }
            }
        }
    }
}

extension GamesForYouVC: SearchVideoDelegate {
    func moveToDetailVideoGame(id: Int) {
        let vc = DetailGameVC()
        vc.videoGameId = id
        navigationController?.pushViewController(vc, animated: true)
    }
}
