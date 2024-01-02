//
//  ApiManager.swift
//  NewsAPI
//
//  Created by Katerina on 13/12/2023.
//

import Foundation

final class ApiManager {
    enum Category: String {
        case general = "general"
        case business = "business"
        case technology = "technology"
        
    }
    // MARK: - Properties
    private static let apiKey = "2338807a45644baca882dd1746537808"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path = "top-headlines" //"everything"
    
    // MARK: - Methods
    // Create url path and make request
    static func getNews(from category: Category,
                        page: Int,
                        searchText: String?,
                        completion: @escaping
                            (Result<[ArticleResponceObject], Error>) -> ()) {
        var searchParameter = ""
        if let searchText = searchText {
            searchParameter = "&q=\(searchText)"
        }
        
        let strUrl = baseUrl + path + "?category=\(category.rawValue)&language=en&page=\(page)" + searchParameter + "&apiKey=\(apiKey)"
        guard let url = URL(string: strUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            handleResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
    }
        session.resume()
    }
    
    // Handle response
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[ArticleResponceObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            // преобразует в читаемый вид
           let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            do {
                print(data)
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                
                completion(.success(model.articles))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
