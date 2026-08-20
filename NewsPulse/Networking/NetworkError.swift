//
//  NetworkError.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError
    case noData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
            
        case .invalidResponse:
            return "The server returned an invalid response."
            
        case .httpError(let statusCode):
            return "The server returned an error. Status code: \(statusCode)"
            
        case .decodingError:
            return "Unable to process the server response."
            
        case .noData:
            return "The server returned no data."
            
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
