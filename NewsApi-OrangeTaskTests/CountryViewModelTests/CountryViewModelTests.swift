//
//  CountryViewModelTests.swift
//  NewsApi-OrangeTaskTests
//
//  Created by Abdallah on 2/15/22.
//

import XCTest

import XCTest
@testable import NewsApi_OrangeTask

class CountryViewModelTests: XCTestCase {
    var sut: CountryViewModel!
    override func setUp() {
        super.setUp()
        
        sut = CountryViewModel()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // fect data lma bett7t fe cell
    func testCreateCellViewModel() {
        // Given
        //country details
        let country = Country(countryName: "Egypt", countryImage: "eg", countryAppreviation: "eg")
        let cellViewModel = sut?.createCellViewModel(country: country)
        
        // Then: This is the section where you’ll assert the result you expect with a message that prints if the test fails.
        XCTAssertEqual(cellViewModel?.countryName, country.countryName)
        XCTAssertEqual(cellViewModel?.countryIamge, country.countryImage)
        XCTAssertEqual(cellViewModel?.countryAppreviation, country.countryAppreviation)
        
    }}
