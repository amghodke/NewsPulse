//
//  NewsViewModelTests.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation
import Testing
@testable import NewsPulse

struct NewsViewModelTests {
    
    @Test
    @MainActor
    func searchFiltersArticlesByTitle() async {
        
        let articles = [
            makeArticle(title: "India wins the cricket match"),
            makeArticle(title: "Apple announces new iPhone"),
            makeArticle(title: "India launches new technology")
        ]
        
        let mockService = MockNewsService(
            pages: [1: articles]
        )
        
        let viewModel = NewsViewModel(
            newsService: mockService
        )
        
        await viewModel.fetchTopHeadlines()
        
        viewModel.searchText = "India"
        
        #expect(viewModel.filteredArticles.count == 2)
        
        #expect(
            viewModel.filteredArticles.allSatisfy {
                $0.title.localizedCaseInsensitiveContains("India")
            }
        )
    }
    
    @Test
    @MainActor
    func emptySearchReturnsAllArticles() async {
        
        let articles = [
            makeArticle(title: "India wins the cricket match"),
            makeArticle(title: "Apple announces new iPhone"),
            makeArticle(title: "NASA launches new mission")
        ]
        
        let mockService = MockNewsService(
            pages: [1: articles]
        )
        
        let viewModel = NewsViewModel(
            newsService: mockService
        )
        
        await viewModel.fetchTopHeadlines()
        
        viewModel.searchText = ""
        
        #expect(viewModel.filteredArticles.count == 3)
    }
    
    @Test
    @MainActor
    func paginationAppendsNewArticles() async {
        
        let page1Articles = [
            makeArticle(title: "News 1"),
            makeArticle(title: "News 2")
        ]
        
        let page2Articles = [
            makeArticle(title: "News 3"),
            makeArticle(title: "News 4")
        ]
        
        let mockService = MockNewsService(
            pages: [
                1: page1Articles,
                2: page2Articles
            ]
        )
        
        let viewModel = NewsViewModel(
            newsService: mockService
        )
        
        await viewModel.fetchTopHeadlines()
        
        #expect(viewModel.articles.count == 2)
        
        await viewModel.loadMoreIfNeeded(
            currentArticle: page1Articles[1]
        )
        
        #expect(viewModel.articles.count == 4)
        #expect(viewModel.articles[0].title == "News 1")
        #expect(viewModel.articles[1].title == "News 2")
        #expect(viewModel.articles[2].title == "News 3")
        #expect(viewModel.articles[3].title == "News 4")
    }
    
    // MARK: - Error Handling
    
    @Test
    @MainActor
    func fetchNewsSetsErrorMessageWhenServiceFails() async {
        
        let mockService = MockNewsService(
            error: TestError.networkFailure
        )
        
        let viewModel = NewsViewModel(
            newsService: mockService
        )
        
        await viewModel.fetchTopHeadlines()
        
        #expect(
            viewModel.errorMessage
            == TestError.networkFailure.localizedDescription
        )
        
        #expect(viewModel.articles.isEmpty)
        #expect(viewModel.isLoading == false)
    }
    
    
    // MARK: - Test Helpers
    
    private func makeArticle(title: String) -> NewsArticle {
        NewsArticle(
            id: UUID(),
            title: title,
            description: "Test description",
            url: nil,
            imageURL: nil,
            publishedAt: Date(),
            sourceName: "Test Source"
        )
    }
}

// MARK: - Test Error

private enum TestError: Error {
    case networkFailure
}
