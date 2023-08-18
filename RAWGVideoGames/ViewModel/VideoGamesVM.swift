//
//  VideoGamesVM.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import Foundation

protocol VideoGamesVMProtocol {
    func fetchVideoGamesList(completion: @escaping (Result<VideoGamesModel, Error>) -> Void)
    func fetchDetailVideoGames(id: Int, completion: @escaping(Result<VideoGameResults, Error>) -> Void)
    func fetchSearchResultGames(query: String, completion: @escaping(Result<VideoGamesModel, Error>) -> Void)
    func fetchPaginationGames(completion: @escaping (Result<VideoGamesModel, Error>) -> Void)
}

class VideoGamesVM: VideoGamesVMProtocol {
    private let useCase: VideoGamesUseCaseProtocol
    var pagination: Int = 0
    
    init(useCase: VideoGamesUseCaseProtocol = VideoGamesUseCase()) {
        self.useCase = useCase
    }
    
    func fetchVideoGamesList(completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
        useCase.fetchVideoGamesList { results in
            completion(results)
        }
    }
    
    func fetchDetailVideoGames(id: Int, completion: @escaping(Result<VideoGameResults, Error>) -> Void){
        useCase.fetchDetailVideoGames(id: id) { results in
            completion(results)
        }
    }
    
    func fetchSearchResultGames(query: String, completion: @escaping(Result<VideoGamesModel, Error>) -> Void) {
        useCase.fetchSearchResultGames(query: query) { results in
            completion(results)
        }
    }
    
    func fetchPaginationGames(completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
        useCase.fetchPaginationGames(page: pagination, limit: 5) { results in
            completion(results)
        }
    }
}
