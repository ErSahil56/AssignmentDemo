//
//  APIManager.swift
//  PostDemo
//
//  Created by Sahil Garg on 29/04/24.
//

import Foundation

var API_URL = "https://jsonplaceholder.typicode.com/posts"

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

class APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    let url = URL(string: API_URL)
    
    func fetchData(completion: @escaping (Result<[PostModel], Error>) -> Void) {
        if let url = self.url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data else {
                    completion(.failure(DataError.invalidData))
                    return
                }
                guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                    completion(.failure(DataError.invalidResponse))
                    return
                }
                
                // JSONDecoder() converts data to model of type Array
                do {
                    let products = try JSONDecoder().decode([PostModel].self, from: data)
                    completion(.success(products))
                }
                catch {
                    completion(.failure(DataError.message(error)))
                }
            }.resume()
        }
    }
}
