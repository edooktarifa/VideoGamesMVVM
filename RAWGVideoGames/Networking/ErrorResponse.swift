//
//  Endpoint.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

enum ErrorResponse: String {
    case invalidEndpoint = "404"
    case invalidResponse = "505"
    case noData = "400"
    case serializationError
    
    public var description: String {
        switch self {
        case .invalidEndpoint:
            return "Ooops, there is something problem with the api"
        case .invalidResponse:
            return "Ooops, there is something problem with the response"
        case .noData:
            return "Ooops, there is something problem with the data"
        case .serializationError:
            return "Ooops, there is something problem with the serialization process"
        }
    }
}
