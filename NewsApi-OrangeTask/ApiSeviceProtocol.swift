//
//  ApiSeviceProtocol.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
protocol ApiServiceProtocol {
    func getNewsList(countryName:String,categoryName:String,completion: @escaping (Result<News , ResoneError>) -> Void)
    func fetchAllNews(from url: URL?, complete: @escaping ((Result<News , ResoneError>) -> Void))
}
