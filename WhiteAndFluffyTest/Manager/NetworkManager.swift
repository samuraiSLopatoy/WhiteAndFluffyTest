//
//  NetworkManager.swift
//  WhiteAndFluffyTest
//
//  Created by Михаил Кулагин on 01.02.2022.
//


// https://api.unsplash.com/search/photos?page=1&query=skate&client_id=EAJVw7LBAiWCYnhp2vTzEsA6z939DxHF0yMsdT15e4A

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseUrlString = "https://api.unsplash.com"
    private let accessKey = "EAJVw7LBAiWCYnhp2vTzEsA6z939DxHF0yMsdT15e4A"
    
    // MARK: Search photos
    func searchPhotos(query: String, completion: @escaping (SearchResults?) -> Void) {
        
        let urlString = "\(baseUrlString)/search/photos?page=1&per_page=20&query=\(query)&orientation=squarish&client_id=\(accessKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else { return }
            
            do {
                let photos = try JSONDecoder().decode(SearchResults.self, from: data)
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // MARK: Get a random photos
    func fetchRandomPhotos(completion: @escaping ([Photo]) -> Void) {
        
        let urlString = "\(baseUrlString)/photos/random?count=20&orientation=squarish&client_id=\(accessKey)"
    
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else { return }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
}
