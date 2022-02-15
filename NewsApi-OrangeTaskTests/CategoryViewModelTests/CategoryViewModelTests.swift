//
//  CategoryViewModelTests.swift
//  NewsApi-OrangeTaskTests
//
//  Created by Abdallah on 2/16/22.
//

import XCTest
@testable import NewsApi_OrangeTask

class CategoryViewModelTests: XCTestCase {

    var sut: CategoryViewModel!
    override func setUp() {
        super.setUp()
        
        sut = CategoryViewModel()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // fect data lma bett7t fe cell
    func testCreateCellViewModel() {
        // Given
        //Category details
        let category = Category(categoryName: "categoryName")
        let cellViewModel = sut?.createCellViewModel(category: category)
        
        // Then: This is the section where you’ll assert the result you expect with a message that prints if the test fails.
        XCTAssertEqual(cellViewModel?.categoryName, category.categoryName)
       
    }

}
