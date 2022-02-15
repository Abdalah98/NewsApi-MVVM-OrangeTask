//
//  StubGenerator.swift
//  MVVMPlaygroundTests
//  NewsApi-OrangeTaskTests
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
@testable import NewsApi_OrangeTask

class StubGenerator {
    func stubNews() -> [Article]? {
        guard let path = Bundle.unitTest.path(forResource: "News", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let news = try? decoder.decode(News.self, from: data)
        return news?.articles
    }
}
