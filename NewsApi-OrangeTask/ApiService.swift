//
//  ApiService.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
class ApiService {
    func getNewsList(countryName:String,categoryName:String) -> URL {
        return  URL(string:String(format: URLS.newsList, arguments: [countryName,categoryName]))!
    }
    
    func fetchAllNews(from url: URL?,  complete completion: @escaping ((Result<AllNews, ResoneError>) -> Void)) {
        guard let url = url else {
            completion(.failure(.invaldURL))
            
            return
        }
        print(url,"url")
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let _ = err {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard response != nil  else {
                completion(.failure(.invalidResponse))
                
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return }
            
            do {
                let objects = try JSONDecoder().decode(AllNews.self, from: data)
                // success
                completion(.success(objects))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    
}

extension ApiService : ApiServiceProtocol{
    func getNewsList(countryName: String, categoryName: String, completion: @escaping (Result<AllNews, ResoneError>) -> Void) {
        fetchAllNews(from: getNewsList(countryName: countryName, categoryName: categoryName), complete: completion)
        
    }
}

