//
//  TableCollectionViewSection.swift
//  NewsAPI
//
//  Created by Katerina on 22/12/2023.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
     var title: String?
     var items: [TableCollectionViewItemsProtocol]
}
