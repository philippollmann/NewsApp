//
//  NewsController.swift
//  News
//
//  Created by Philipp Ollmann on 14.06.21.
//

import Foundation

final class NewsController {
    
    static let shared = NewsController() //to make it singelton
    private let apiKey: String = "c3632c01fcb4455787c6bb22e9e20595"
    private let baseUrl: String = "https://newsapi.org/v2/top-headlines"
    private let session = URLSession.shared
    
    public enum NewsControllerErrors: Error {
        case failedToFetch
    }
}


extension NewsController {
    func getNews(filter: Filter, completion: @escaping (Result<[Article], Error>) -> Void){
        
        var queryItems:[URLQueryItem] = [URLQueryItem(name: "pageSize", value: "100"), URLQueryItem(name: "apiKey", value: apiKey), URLQueryItem(name: "country", value: filter.country.getCountryCode())]
        
        if let category = filter.category {
            queryItems.append(URLQueryItem(name: "category", value: category.rawValue.lowercased()))
        }
        
        if let searchTerm = filter.searchTerm {
            queryItems.append(URLQueryItem(name: "q", value: searchTerm))
        }
        
        var urlComps = URLComponents(string: baseUrl)!
        urlComps.queryItems = queryItems
        let result = urlComps.url

        //let url = URL(string: "\(baseUrl)v2/everything?q=Apple&from=2021-06-14&sortBy=popularity&apiKey=\(apiKey)")
        if let url = result {
            let taks = session.dataTask(with: url, completionHandler: {data, response, error in
                print(response?.description ?? "")
                if let data = data {
                    let jsonDecoder = JSONDecoder();
                    let response = try? jsonDecoder.decode(ServerRespone.self, from: data)
                    if let articles = response?.articles, response?.status == "ok" {
                        completion(.success(articles))
                    } else {
                        completion(.failure(NewsControllerErrors.failedToFetch))
                    }
                } else {
                    completion(.failure(NewsControllerErrors.failedToFetch))
                }
            })
            taks.resume()
        }
    }
}
