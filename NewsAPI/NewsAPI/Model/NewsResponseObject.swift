//
//  NewsResponseObject.swift
//  NewsAPI
//
//  Created by Katerina on 12/12/2023.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponceObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}

