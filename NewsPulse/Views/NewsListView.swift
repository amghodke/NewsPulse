//
//  NewsListView.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//
import SwiftUI

struct NewsListView: View {
    
    @State private var viewModel: NewsViewModel
    
    init(viewModel: NewsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.articles.isEmpty {
                    ProgressView("Loading news...")
                    
                } else if let errorMessage = viewModel.errorMessage,
                          viewModel.articles.isEmpty {
                    errorView(message: errorMessage)
                    
                } else {
                    newsList
                }
            }
            .navigationTitle("NewsPulse")
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search news"
            )
            .task {
                if viewModel.articles.count > 0 {
                    
                }else{
                    await viewModel.fetchTopHeadlines()
                }
            }
        }
    }
    
    private var newsList: some View {
        List {
            ForEach(viewModel.filteredArticles) { article in
                
                NewsRowView(article: article)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(
                                currentArticle: article
                            )
                        }
                    }
            }
            
            if viewModel.isLoadingMore {
                HStack {
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.fetchTopHeadlines()
        }
        .scrollContentBackground(.hidden)
        .background(Color(.systemGroupedBackground))    }
    
    private func errorView(message: String) -> some View {
        ContentUnavailableView {
            Label(
                "Unable to Load News",
                systemImage: "newspaper"
            )
        } description: {
            Text(message)
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.fetchTopHeadlines()
                }
            }
        }
    }
}
