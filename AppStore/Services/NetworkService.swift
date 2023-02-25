//
//  NetworkService.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import Foundation

final class NetworkService {
    public static let shared = NetworkService()
    private init() {}
    
    public func fetchApps(completion: @escaping (Result<[ApiResult], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        let req = URLRequest(url: URL(string: urlString)!)
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            guard let data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedObj = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(.success(decodedObj.results))
            } catch let decodeErr {
                completion(.failure(decodeErr))
            }
        }.resume()
    }
}
