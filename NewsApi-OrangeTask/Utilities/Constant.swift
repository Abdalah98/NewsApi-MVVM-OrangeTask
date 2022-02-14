//
//  Constant.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//


import Foundation

enum ApiKey {
    static let apiKey                  =   "acea22a4e7c242ed95b6c26851d0b776"
    
}

// The name urlString
enum URLS {
    static let country                 =   "de"
    static let category                =   "business"
    static let newsList = "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=\(ApiKey.apiKey)"
    static let newsList2 = "https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=acea22a4e7c242ed95b6c26851d0b776"
    static let newsList3 = "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=acea22a4e7c242ed95b6c26851d0b776"
  
    
    
}




// namenib of cell
enum Cell {
    static let countryCell                   =   "CountryNameCell"
    static let categoryCell                  =   "CategoryCell"
    static let headLineNewsCell              =   "HeadLineNewsCell"

    
    
}

// name Segue of storyboard
enum  Segue{
    static let goProductListDetails              =   "GoProductListDetails"
}

struct UserDefulat {
    
}
