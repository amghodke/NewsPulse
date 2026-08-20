//
//  NewsArtical.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation

import Foundation

struct NewsArticle: Identifiable {
    
    let id: UUID
    let title: String
    let description: String?
    let url: URL?
    let imageURL: URL?
    let publishedAt: Date
    let sourceName: String
}

/*
struct NewsArticle: Identifiable {
    
    let id: UUID
    let title: String
    let description: String?
    let url: String
    let imageURL: String?
    let publishedAt: Date
    let sourceName: String
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String?,
        url: String,
        imageURL: String?,
        publishedAt: Date,
        sourceName: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.url = url
        self.imageURL = imageURL
        self.publishedAt = publishedAt
        self.sourceName = sourceName
    }
}
*/
