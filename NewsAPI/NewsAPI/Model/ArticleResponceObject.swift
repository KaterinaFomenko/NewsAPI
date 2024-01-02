//
//  ArticleResponceObject.swift
//  NewsAPI
//
//  Created by Katerina on 12/12/2023.
//

import Foundation

struct ArticleResponceObject: Codable {
    let title: String
    let description: String?
    let urlToImage: String?
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case date = "publishedAt"
    }
}
