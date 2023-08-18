//
//  RAWGVideoGamesTests.swift
//  RAWGVideoGamesTests
//
//  Created by Phincon on 17/08/23.
//

import XCTest
@testable import RAWGVideoGames

final class RAWGVideoGamesTests: XCTestCase {
    
    var sut: VideoGamesVM!
    
    func test_fetch_video_games_list_success() {
        sut = VideoGamesVM(useCase: FakeMenuRemote())
        sut.fetchVideoGamesList { results in
            switch results {
            case .success(let videoGames):
                XCTAssertEqual(videoGames.seo_title, "All Games")
            default:
                break
            }
        }
    }
    
    func test_detail_video_games(){
        sut = VideoGamesVM(useCase: FakeMenuRemote())
        sut.fetchDetailVideoGames(id: 1) { results in
            switch results {
            case .success(let videoGames):
                XCTAssertEqual(videoGames.name, "Grand Theft Auto V")
            default:
                break
            }
        }
    }
    
    func test_search_result_games(){
        sut = VideoGamesVM(useCase: FakeMenuRemote())
        sut.fetchSearchResultGames(query: "GTA") { results in
            switch results {
            case .success(let videoGames):
                XCTAssertEqual(videoGames.results?.first?.name, "Grand Theft Auto V")
            default:
                break
            }
        }
    }
    
    func test_pagination_games(){
        sut = VideoGamesVM(useCase: FakeMenuRemote())
        sut.fetchPaginationGames { results in
            switch results {
            case .success(let videoGames):
                XCTAssertEqual(videoGames.seo_title, "All Games")
            default:
                break
            }
        }
    }
    
    class FakeMenuRemote: VideoGamesUseCaseProtocol {
        func fetchVideoGamesList(completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
            guard let data = VideoGamesModelFactory().successGetListVideoGAmes() else { return}
            do {
                let videoGamesList = try JSONDecoder().decode(VideoGamesModel.self, from: data)
                completion(.success(videoGamesList))
            } catch {}
        }
        
        func fetchDetailVideoGames(id: Int, completion: @escaping (Result<VideoGameResults, Error>) -> Void) {
            guard let data = VideoGamesModelFactory().seccessGetDetailVideoGames() else { return}
            do {
                let videoGamesDetail = try JSONDecoder().decode(VideoGameResults.self, from: data)
                completion(.success(videoGamesDetail))
            } catch {}
        }
        
        func fetchSearchResultGames(query: String, completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
            guard let data = VideoGamesModelFactory().successSearchMovieGames() else { return}
            do {
                let videoGamesList = try JSONDecoder().decode(VideoGamesModel.self, from: data)
                completion(.success(videoGamesList))
            } catch {}
        }
        
        func fetchPaginationGames(page: Int, limit: Int, completion: @escaping (Result<VideoGamesModel, Error>) -> Void) {
            guard let data = VideoGamesModelFactory().successGetListVideoGAmes() else { return}
            do {
                let videoGamesList = try JSONDecoder().decode(VideoGamesModel.self, from: data)
                completion(.success(videoGamesList))
            } catch {}
        }
    }

}

