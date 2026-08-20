//
//  MockNewsService.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation

final class MockNewsService: NewsServiceProtocol {
    
    func fetchTopHeadlines(
        page: Int
    ) async throws -> [NewsArticle] {
        
        switch page {
        case 1:
            return [
                makeArticle(
                    title: "India Wins Cricket Match",
                    description: "India wins an exciting cricket match."
                ),
                makeArticle(
                    title: "Apple Announces New iPhone",
                    description: "Apple announces its latest iPhone."
                ),
                makeArticle(
                    title: "NASA Launches New Mission",
                    description: "NASA launches a new space mission."
                ),
                makeArticle(
                    title: "Technology Trends in 2026",
                    description: "The latest technology trends."
                )
            ]
            
        default:
            return []
        }
    }
    
    private func makeArticle(
        title: String,
        description: String
    ) -> NewsArticle {
        
        NewsArticle(
            id: UUID(),
            title: title,
            description: description,
            url: URL(string: "https://example.com"),
            imageURL: nil,
            publishedAt: Date(),
            sourceName: "NewsPulse Test"
        )
    }
}
