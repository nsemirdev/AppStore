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
    
    public func fetchApps(searchTerm: String, completion: @escaping (Result<[ApiResult], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        let req = URLRequest(url: URL(string: urlString)!)
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error {
                completion(.failure(error))
                return
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
    
    public func fetchTopFree(completion: @escaping (Result<Feed, Error>) -> Void) {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/20/apps.json") else { return }
        
        let req = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedObj = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(.success(decodedObj.feed))
            } catch let decodeErr {
                completion(.failure(decodeErr))
            }
            
        }.resume()
    }
    
    public func fetchPaidApps(completion: @escaping (Result<Feed, Error>) -> Void) {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/10/apps.json") else { return }
        
        let req = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedObj = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(.success(decodedObj.feed))
            } catch let decodeErr {
                completion(.failure(decodeErr))
            }
        }.resume()
    }
    
    public func fetchSocialApps(completion: @escaping (Result<[SocialApp], Error>) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        let req = URLRequest(url: URL(string: urlString)!)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedObj = try JSONDecoder().decode([SocialApp].self, from: data)
                completion(.success(decodedObj))
            } catch let decodeErr {
                completion(.failure(decodeErr))
            }
        }.resume()
    }
    
    public func fetchByAppID(appId: String, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        let req = URLRequest(url: URL(string: urlString)!)
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedObj = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(.success(decodedObj))
            } catch let decodeErr {
                completion(.failure(decodeErr))
            }
        }.resume()
    }
}
