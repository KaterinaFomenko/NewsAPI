//
//  TechnologiViewModel.swift
//  NewsAPI
//
//  Created by Katerina on 26/12/2023.
//

import Foundation

class TechnologyViewModel: NewsListViewModel {
    
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getNews(from: .technology,
                           page: page,
                           searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
