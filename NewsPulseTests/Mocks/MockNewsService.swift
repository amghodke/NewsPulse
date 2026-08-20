//
//  MockNewsService.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation
@testable import NewsPulse

final class MockNewsService: NewsServiceProtocol {
    
    private let pages: [Int: [NewsArticle]]
    private let error: Error?
    
    init(
        pages: [Int: [NewsArticle]] = [:],
        error: Error? = nil
    ) {
        self.pages = pages
        self.error = error
    }
    
    func fetchTopHeadlines(
        page: Int
    ) async throws -> [NewsArticle] {
        
        if let error {
            throw error
        }
        
        return pages[page] ?? []
    }
}
