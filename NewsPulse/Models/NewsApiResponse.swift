//
//  NewsApiResponse.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//

import Foundation
struct NewsApiResponse: Decodable {
    let articles: [NewsArticleDTO]
}
