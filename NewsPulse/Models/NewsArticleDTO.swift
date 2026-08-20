//
//  NewsArticleDTO.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation

struct NewsArticleDTO: Decodable {
    let title: String
    let description: String?
    let url: String
    let image: String?
    let publishedAt: String
    let source: NewsSourceDTO
}

struct NewsSourceDTO: Decodable {
    let name: String
}

extension NewsArticleDTO {
    
    func toDomain() -> NewsArticle {
        NewsArticle(
            id: UUID(),
            title: title,
            description: description,
            url: URL(string: url),
            imageURL: image.flatMap(URL.init),
            publishedAt: ISO8601DateFormatter().date(
                from: publishedAt
            ) ?? Date(),
            sourceName: source.name
        )
    }
}
