//
//  APIServiceTests.swift
//  NewsApi-OrangeTaskTests
//
//  Created by Abdallah on 2/13/22.
//

import XCTest
@testable import NewsApi_OrangeTask

class APIServiceTests: XCTestCase {
    var sut: ApiService!
    var apiServiceMock: APIServiceMock!
    
    override func setUp() {
        super.setUp()
        sut = ApiService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    // testing News
    func test_get_New_List() {
        // Given
        let promise = XCTestExpectation(description: "Fetch News")
        var responseError: Error?
        var responseNewsList: [Article]?
        
        // When
        guard let bundle = Bundle.unitTest.path(forResource: "News", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.fetchAllNews(from: URL(fileURLWithPath: bundle)) { result in
            switch result {
            case .success(let response):
                responseNewsList = response.articles
                promise.fulfill()
            case .failure(let error):
                responseError = error
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseNewsList)
    }
}
