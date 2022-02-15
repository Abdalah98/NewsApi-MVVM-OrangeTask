//
//  APIServiceMock.swift
//  NewsApi-OrangeTaskTests
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
@testable import NewsApi_OrangeTask
// The mock APIService(APIServiceMock) object doesn’t connect to the real server,
// it’s an object designed only for the test.
// Both APIServiceand APIServiceMock conform to APIServiceProtocol,
// so that we are able to inject different dependency in different situation.
class APIServiceMock: ApiServiceProtocol{
    
    
    
    var fetchNewsListIsCalled = false
    var fetchNewsIsCalled = false
    
    var article :News?
    
    var completeClosure: ((Result<News , ResoneError>) -> ())!
    func getNewsList(countryName: String, categoryName: String, completion: @escaping (Result<News, ResoneError>) -> Void) {
        fetchNewsListIsCalled = true
        completeClosure = completion
    }
    
    func fetchAllNews(from url: URL?, complete: @escaping ((Result<News, ResoneError>) -> Void)) {
        fetchNewsIsCalled = true
    }

    func fetchSuccess() {
        
        completeClosure(.success(article!))
    }

    func fetchFail(error: ResoneError?) {
        completeClosure(.failure(error!)!)
    }
}
