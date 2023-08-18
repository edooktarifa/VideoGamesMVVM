//
//  VideoGamesRequest.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import Foundation

struct VideoGamesRequest: DataRequest {
    var url: String
    var method: HTTPMethod
    var headers: [String: String]?
    var queryItems: [String: String]?
}

enum VideoGamesRequestData: DataRequest {
    case getListGames
    case getDetailGames(id: Int)
    case searchGames(query: String)
    case paginationGames(page: Int, limit: Int)
    
    var url: String {
        switch self {
        case .getDetailGames(let id):
            return "\(Constants.baseUrl)/\(id)"
        default:
            return "\(Constants.baseUrl)?"
        }
    }
    
    var queryItems: [String : String] {
        switch self {
        case .getListGames, .getDetailGames(_):
            return ["key": Constants.apiKey]
        case .searchGames(let query):
            return ["key": Constants.apiKey, "search": query]
        case .paginationGames(let page, let limit):
            return ["page": "\(page)", "page_size": "\(limit)", "key": Constants.apiKey]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
