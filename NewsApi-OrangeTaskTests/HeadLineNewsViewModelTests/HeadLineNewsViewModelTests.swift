//
//  HeadLineNewsViewModelTests.swift
//  NewsApi-OrangeTaskTests
//
//  Created by Abdallah on 2/16/22.
//

import XCTest
@testable import NewsApi_OrangeTask

class HeadLineNewsViewModelTests: XCTestCase {
    
    var sut: HeadLineNewsViewModel!
    
    var apiServiceMock: APIServiceMock!
    
    override func setUp() {
        super.setUp()
        // creat an instance of the mock in ProductListViewModle
        apiServiceMock = APIServiceMock()
        // inject apiServiceMock to ProductListViewModel
        sut = HeadLineNewsViewModel(apiService: apiServiceMock)
        // test testCreateCellViewModel
        
    }
    
    override func tearDown() {
        sut = nil
        
        apiServiceMock = nil
        super.tearDown()
    }
    
    func test_error_state_when_fetching() {
        
        //Given
        var state: State? = .empty
        let promise = XCTestExpectation(description: "Loading state updated to error")
        sut.updateLoadingStatus = { [weak sut] in
            state = sut?.state
            promise.fulfill()
        }
        // Given a failed fetch with a certain failure
        let error = ResoneError.invalidResponse
        
        //when fetching
        sut.initFetchDataFavoriteCategroy()
        
        wait(for: [promise], timeout: 1.0)
        
        // Assert
        XCTAssertEqual(state, State.loading)
        
        // When finished fetching
        apiServiceMock?.fetchFail(error: error)
        XCTAssertEqual(state, State.error)
    }
    
    
    // A test method’s name always begins with test, followed by a description of what it tests.
    
    // It’s good practice to format the test into given, when and then sections
    // Given: Here, you set up any values needed.
    // In this example, today’s date and a dummy photo object are created.
    // test featch data in view model
    func test_fetch_News() {
        // When
        sut.initFetchDataFavoriteCategroy()
        
        // Then
        XCTAssert(apiServiceMock.fetchNewsListIsCalled)
    }
    
    // testing fail
    func test_fetch_News_fail() {
        // Given
        let error = ResoneError.notFound
        // When
        sut.initFetchDataFavoriteCategroy()
        apiServiceMock.fetchFail(error: error)
        // Then
        XCTAssertEqual(sut.alertMessage, error.rawValue)
    }
    
    // fect data lma bett7t fe cell
    func testCreateCellViewModel() {
        // Given
        //article details
        let article = Article( source: Source(id: "id", name: "name"), author: "author", title: "title", articleDescription: "dec", url: "url", urlToImage: "urlImage", publishedAt: "30/2022", content: "content")
        
        let cellViewModel = sut?.createCellViewModel(article: article)
        
        // Then: This is the section where you’ll assert the result you expect with a message that prints if the test fails.
        XCTAssertEqual(cellViewModel?.title, article.title)
        XCTAssertEqual(cellViewModel?.description, article.articleDescription)
        XCTAssertEqual(cellViewModel?.url, article.url)
        XCTAssertEqual(cellViewModel?.date, article.publishedAt)
        
    }
    
}
