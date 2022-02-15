//
//  Bundle+unitTests.swift
//  NewsApi-OrangeTaskTests
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: APIServiceTests.self)
    }
}

