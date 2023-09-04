//
//  APICallerAllNews.swift
//  NewsApp
//
//  Created by Алексей Орловский on 23.05.2023.
//

import Foundation

class APICallerAllNews {
    static let shared = APICallerAllNews()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from&sortBy=publishedAt&apiKey=661568f9076748639622adc1d4b58bf9")
        static let searchUrlString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=661568f9076748639622adc1d4b58bf9&q="
    }
    
    private init() {}
    
    public func getTopData(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    public func searchGetData(with request: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !request.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let urlString = Constants.searchUrlString + request
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

