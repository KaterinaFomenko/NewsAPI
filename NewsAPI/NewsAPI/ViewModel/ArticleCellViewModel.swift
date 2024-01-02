//
//  ArticleCellViewModel.swift
//  NewsAPI
//
//  Created by Katerina on 12/12/2023.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let date: String
    let imageUrl: String
    var imageData: Data?
   
    // это data
    init(article: ArticleResponceObject) {
        title = article.title
        description = article.description
        date = article.date
        imageUrl = article.urlToImage
    }
}
 // Данные ViewModel передадим в ячейку
