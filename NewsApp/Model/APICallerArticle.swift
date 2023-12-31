//
//  APICallerArticle.swift
//  NewsApp
//
//  Created by Алексей Орловский on 23.05.2023.
//

/// MARK: - SearchResponse
struct APIResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

/// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

/// MARK: - Source
struct Source: Codable {
    let name: String?
}
