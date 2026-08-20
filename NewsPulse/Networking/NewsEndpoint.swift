//
//  NewsEndPoint.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//
import Foundation

enum NewsEndpoint {
    
    case topHeadlines(page: Int)
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "/top-headlines"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .topHeadlines(let page):
            return [
                URLQueryItem(
                    name: "lang",
                    value: NewsAPIConfig.language
                ),
                URLQueryItem(
                    name: "country",
                    value: NewsAPIConfig.country
                ),
                URLQueryItem(
                    name: "max",
                    value: String(NewsAPIConfig.pageSize)
                ),
                URLQueryItem(
                    name: "page",
                    value: String(page)
                ),
                URLQueryItem(
                    name: "apikey",
                    value: NewsAPIConfig.apiKey
                )
            ]
        }
    }
    
    var url: URL? {
        var components = URLComponents(
            string: NewsAPIConfig.baseURL + path
        )
        
        components?.queryItems = queryItems
        
        return components?.url
    }
}
