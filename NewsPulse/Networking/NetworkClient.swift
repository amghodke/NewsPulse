//
//  NetworkClient.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(
        _ endpoint: NewsEndpoint
    ) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(
        _ endpoint: NewsEndpoint
    ) async throws -> T {
        
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.httpError(
                statusCode: httpResponse.statusCode
            )
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
