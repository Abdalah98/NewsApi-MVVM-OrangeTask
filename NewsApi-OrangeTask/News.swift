//
//  AllNews.swift
//  News-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//
// MARK: - AllNews
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
