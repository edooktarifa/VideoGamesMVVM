//
//  HTTP.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol DataRequest {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String] { get }
}

extension DataRequest {
    var headers: [String: String] {
        [:]
    }
    var queryItems: [String: String]{
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
}
