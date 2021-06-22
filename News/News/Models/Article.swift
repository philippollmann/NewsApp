//
//  Article.swift
//  News
//
//  Created by Philipp Ollmann on 14.06.21.
//

import Foundation

struct Article: Codable {
    let title: String
    let description: String?
    let content: String?
    let urlToImage: String?
    let url: String?
    let publishedAt: String?
    var date: Date? {
        let dateFormatter = ISO8601DateFormatter()
        guard let dateString = publishedAt else { return Date()}
        return dateFormatter.date(from: dateString)
    }
    
    enum RootKeys: String, CodingKey {
        case articles = "articles"
    }
    
    enum ArticleKeys: String, CodingKey {
        case title, description, urlToImage, content, url, publishedAt = "publishedAt"
    }
}

struct ServerRespone: Codable {
    let status: String
    let articles: [Article]
}
