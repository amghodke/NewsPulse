//
//  NewsService.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation

protocol NewsServiceProtocol {
    
    func fetchTopHeadlines(
        page: Int
    ) async throws -> [NewsArticle]
}


final class NewsService: NewsServiceProtocol {
    
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchTopHeadlines(
        page: Int
    ) async throws -> [NewsArticle] {
        
        let response: NewsApiResponse = try await networkClient.request(
            .topHeadlines(page: page)
        )
        
        return response.articles.map {
            $0.toDomain()
        }
    }
}
