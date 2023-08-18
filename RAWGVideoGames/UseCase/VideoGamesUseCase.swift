//
//  VideoGamesUseCase.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import Foundation

protocol VideoGamesUseCaseProtocol {
    func fetchVideoGamesList(completion: @escaping(Result<VideoGamesModel, Error>) -> Void)
    func fetchDetailVideoGames(id: Int,completion: @escaping(Result<VideoGameResults, Error>) -> Void)
    func fetchSearchResultGames(query: String, completion: @escaping(Result<VideoGamesModel, Error>) -> Void)
    func fetchPaginationGames(page: Int, limit: Int, completion: @escaping(Result<VideoGamesModel, Error>) -> Void)
}

class VideoGamesUseCase: VideoGamesUseCaseProtocol {
    let networkServices: NetworkServicesProtocol
    
    init(networkServices: NetworkServicesProtocol = DefaultNetworkServices()){
        self.networkServices = networkServices
    }
    
    func fetchVideoGamesList(completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
        let req = VideoGamesRequestData.getListGames
        networkServices.request(req, responseType: VideoGamesModel.self) {
            results in
            completion(results)
        }
    }
    
    func fetchDetailVideoGames(id: Int, completion: @escaping (Result<VideoGameResults, Error>) -> Void) {
        let req = VideoGamesRequestData.getDetailGames(id: id)
        networkServices.request(req, responseType: VideoGameResults.self) {
            results in
            completion(results)
        }
    }
    
    func fetchSearchResultGames(query: String, completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
        let req = VideoGamesRequestData.searchGames(query: query)
        networkServices.request(req, responseType: VideoGamesModel.self) {
            results in
            completion(results)
        }
    }
    
    func fetchPaginationGames(page: Int, limit: Int, completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
        let req = VideoGamesRequestData.paginationGames(page: page, limit: limit)
        networkServices.request(req, responseType: VideoGamesModel.self) { results in
            completion(results)
        }
    }
}
