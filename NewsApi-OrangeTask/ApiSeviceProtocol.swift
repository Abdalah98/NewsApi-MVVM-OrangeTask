//
//  ApiSeviceProtocol.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
import Foundation
protocol ApiServiceProtocol {
    func getNewsList(countryName:String,categoryName:String,completion: @escaping (Result<AllNews , ResoneError>) -> Void)
    func fetchAllNews(from url: URL?, complete: @escaping ((Result<AllNews , ResoneError>) -> Void))

}
