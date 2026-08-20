//
//  NewsAPIConfig.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation

enum NewsAPIConfig {
    static var apiKey: String {
            guard let apiKey = Bundle.main.object(
                forInfoDictionaryKey: "GNEWS_API_KEY"
            ) as? String,
            !apiKey.isEmpty else {
                fatalError("GNEWS_API_KEY is missing.")
            }

            return apiKey
        }
    static let baseURL = "https://gnews.io/api/v4"
    
    static let country = "in"
    static let language = "en"
    static let pageSize = 10
    
//    static let apiKey = "7edd4050de98abb3241cd61c2a7a1bda"
}
