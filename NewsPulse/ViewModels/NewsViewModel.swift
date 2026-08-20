//
//  NewsViewModel.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//
import Foundation
import Observation

@MainActor
@Observable
final class NewsViewModel {
    
    private let newsService: NewsServiceProtocol
    
    var articles: [NewsArticle] = []
    
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    
    var errorMessage: String?
    
    var searchText: String = ""
    
    private var currentPage = 0
    private var hasMorePages = true
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    var filteredArticles: [NewsArticle] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !query.isEmpty else {
            return articles
        }
        
        return articles.filter { article in
            article.title.localizedCaseInsensitiveContains(query)
            || (article.description?
                .localizedCaseInsensitiveContains(query) ?? false)
        }
    }
    
    func fetchTopHeadlines() async {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        currentPage = 1
        hasMorePages = true
        
        defer {
            isLoading = false
        }
        
        do {
            articles = try await newsService.fetchTopHeadlines(
                page: currentPage
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loadMoreIfNeeded(currentArticle article: NewsArticle) async {
        guard article.id == articles.last?.id else {
            return
        }
        
        guard !isLoading else {
            return
        }
        
        guard !isLoadingMore else {
            return
        }
        
        guard hasMorePages else {
            return
        }
        
        await loadNextPage()
    }
    
    private func loadNextPage() async {
        guard !isLoadingMore else {
            return
        }
        
        isLoadingMore = true
        
        let nextPage = currentPage + 1
        
        defer {
            isLoadingMore = false
        }
        
        do {
            let newArticles = try await newsService.fetchTopHeadlines(
                page: nextPage
            )
            
            if newArticles.isEmpty {
                hasMorePages = false
                return
            }
            
            articles.append(contentsOf: newArticles)
            currentPage = nextPage
            
        } catch {
            // Don't replace the existing articles.
            // Pagination failure shouldn't destroy the current list.
        }
    }
}
