//
//  NewsServiceTests.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation
import Testing
@testable import NewsPulse

struct NewsServiceTests {
    
    // MARK: - Success
    
    @Test
    @MainActor
    func fetchTopHeadlinesReturnsMappedArticles() async throws {
        
        let dtoArticles = [
            makeDTO(
                title: "India wins the cricket match"
            ),
            makeDTO(
                title: "Apple announces new iPhone"
            )
        ]
        
        let response = NewsApiResponse(
            articles: dtoArticles
        )
        
        let mockClient = MockNetworkClient(
            response: response
        )
        
        let service = NewsService(
            networkClient: mockClient
        )
        
        let articles = try await service.fetchTopHeadlines(
            page: 1
        )
        
        #expect(articles.count == 2)
        
        #expect(
            articles[0].title
            == "India wins the cricket match"
        )
        
        #expect(
            articles[1].title
            == "Apple announces new iPhone"
        )
    }
    
    
    // MARK: - Empty Response
    
    @Test
    @MainActor
    func fetchTopHeadlinesReturnsEmptyArrayWhenResponseIsEmpty()
        async throws {
        
        let response = NewsApiResponse(
            articles: []
        )
        
        let mockClient = MockNetworkClient(
            response: response
        )
        
        let service = NewsService(
            networkClient: mockClient
        )
        
        let articles = try await service.fetchTopHeadlines(
            page: 1
        )
        
        #expect(articles.isEmpty)
    }
    
    
    // MARK: - Test Helpers
    
    private func makeDTO(title: String) -> NewsArticleDTO {
        
        NewsArticleDTO(
            title: title,
            description: "Test description",
            url: "https://example.com/article",
            image: nil,
            publishedAt: "2026-08-19T10:00:00Z",
            source: NewsSourceDTO(
                name: "Test Source"
            )
        )
    }
}


// MARK: - Mock Network Client

private final class MockNetworkClient: NetworkClientProtocol {
    
    private let response: NewsApiResponse
    
    init(response: NewsApiResponse) {
        self.response = response
    }
    
    func request<T: Decodable>(
        _ endpoint: NewsEndpoint
    ) async throws -> T {
        
        return response as! T
    }
}
