//
//  NetworkManager.swift
//  lets_ochoice
//
//  Created by homechoic on 1/18/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
   
        private let session = URLSession(configuration: .default)

        private init() {}

        func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
}
