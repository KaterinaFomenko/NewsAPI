//
//  NetworkingError.swift
//  NewsAPI
//
//  Created by Katerina on 14/12/2023.
//

import Foundation
enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
