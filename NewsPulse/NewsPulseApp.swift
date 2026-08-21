//
//  NewsPulseApp.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import SwiftUI

@main
struct NewsPulseApp: App {
    
    private let newsViewModel: NewsViewModel
    
    init() {
        
        let isUITesting = ProcessInfo.processInfo.arguments.contains(
            "UITesting"
        )
        
        let newsService: NewsServiceProtocol
        
        if isUITesting {
            newsService = MockNewsService()
        } else {
            let networkClient = NetworkClient()
            
            newsService = NewsService(
                networkClient: networkClient
            )
        }
//        newsService = MockNewsService()
        self.newsViewModel = NewsViewModel(
            newsService: newsService
        )
    }
    
    var body: some Scene {
        WindowGroup {
            NewsListView(
                viewModel: newsViewModel
            )
        }
    }
}
