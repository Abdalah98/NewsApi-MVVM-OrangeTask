//
//  ApiSeviceProtocol.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
import Foundation
protocol ApiServiceProtocol {
    func getNewsList(completion: @escaping (Result<AllNews , ResoneError>) -> Void)
    func getNewsList2(completion: @escaping (Result<AllNews , ResoneError>) -> Void)
    func getNewsList3(completion: @escaping (Result<AllNews , ResoneError>) -> Void)

    
    func fetchAllNews(from url: URL?, complete: @escaping ((Result<AllNews , ResoneError>) -> Void))

}


protocol ApiServiceProtocolSearch {
    func fetchSearch(from url: URL?, complete: @escaping ((Result<AllNews , ResoneError>) -> Void))
    func searchResult(searchText:String,completion: @escaping (Result<AllNews , ResoneError>) -> Void)
}
