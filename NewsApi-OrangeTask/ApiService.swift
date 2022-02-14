//
//  ApiService.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
class ApiService {
    
     let newsList: URL? = {
        URL(string: URLS.newsList)
    }()
    let newsList2: URL? = {
       URL(string: URLS.newsList2)
   }()
    let newsList3: URL? = {
       URL(string: URLS.newsList3)
   }()
    
    func fetchAllNews(from url: URL?,  complete completion: @escaping ((Result<AllNews, ResoneError>) -> Void)) {
                guard let url = url else {
                    completion(.failure(.invaldURL))
                    
                    return
                }
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
    
    
    // search
    func fetchSearch(from url: URL?, complete completion: @escaping ((Result<AllNews, ResoneError>) -> Void)) {
                   guard let url = url else {
                       completion(.failure(.invaldURL))
                       
                       return
                   }
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
    func getNewsList2(completion: @escaping (Result<AllNews, ResoneError>) -> Void) {
        fetchAllNews(from: newsList2, complete: completion)

    }
    
    func getNewsList3(completion: @escaping (Result<AllNews, ResoneError>) -> Void) {
        fetchAllNews(from: newsList3, complete: completion)

    }
    
    func getNewsList(completion: @escaping (Result<AllNews, ResoneError>) -> Void) {
        fetchAllNews(from: newsList, complete: completion)
    }
  
}



extension ApiService :ApiServiceProtocolSearch{
   
    func searchResult(searchText: String, completion: @escaping (Result<AllNews, ResoneError>) -> Void) {
        let searchResult: URL? = URL(string:"https://newsapi.org/v2/everything?q=\(searchText)&apiKey=acea22a4e7c242ed95b6c26851d0b776")
         fetchSearch(from: searchResult, complete: completion)
    }

}
