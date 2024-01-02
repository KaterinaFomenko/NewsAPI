//
//  NewsListViewModel.swift
//  NewsAPI
//
//  Created by Katerina on 25/12/2023.
//

import Foundation

protocol NewsListViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    
    func loadData(searchText: String?)
}

class NewsListViewModel: NewsListViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    
    // Properties
    var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    var page = 0
    var searchText: String? = nil
    private var isSearchTextChanged = false
    
    //MARK: -  Methods
    func loadData(searchText: String?) {
        if self.searchText != searchText {
            page = 1
            isSearchTextChanged = true
        } else {
            page += 1
            isSearchTextChanged = false
        }
        self.searchText = searchText
    }
    
    func handleResult(_ result: Result<[ArticleResponceObject], Error>) {
        switch result {
        case.success(let articles):
            self.convertToCellViewModel(articles)
            self.loadImage()
        case.failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
                self.setupMockObjects()
            }
        }
    }
    
    // setupMockObjects()
    private func loadImage() {
        
        for (i, section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                guard let article = item as? ArticleCellViewModel else { return }
                let url = article.imageUrl
                
                ApiManager.getImageData(url: url) { [weak self] result in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
                                article.imageData = data
                            }
                            self?.reloadCell?(IndexPath(row: index, section: i))
                        case .failure(let error):
                            self?.showError?(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    func convertToCellViewModel(_ articles: [ArticleResponceObject]) {
        let viewModels = articles.map { ArticleCellViewModel(article: $0) }
        // Все артиклы засовываем в одну секцию
        if sections.isEmpty || isSearchTextChanged {
            let firstSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection]
        } else {
            sections[0].items += viewModels // все статьи
        }
    }
    
    private func setupMockObjects() {
        sections = [
            TableCollectionViewSection(items: [ ArticleCellViewModel(article: ArticleResponceObject(title: "First object title",
                                                                                                    description: "First object description in the mock object", urlToImage: "...", date: "12.12.23"))])
        ]
    }
}
