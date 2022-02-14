//
//  Constant.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//


import Foundation

enum ApiKey {
    static let apiKey                  =   "2726bf3883ef4a29862f124e9ff4a46e"

}

// The name urlString
enum URLS {
    static let newsList = "https://newsapi.org/v2/top-headlines?country=%@&category=%@&apiKey=\(ApiKey.apiKey)"

}


// namenib of cell
enum Cell {
    static let countryCell                   =   "CountryNameCell"
    static let categoryCell                  =   "CategoryCell"
    static let headLineNewsCell              =   "HeadLineNewsCell"
}

// name Segue of storyboard
enum  Constant{
    //userDefult
    static let countryName                =   "CountryName"
    static let categoryName              =   "CategoryName"

    //storyBoard main
    static let main         =  "Main"
    static let categoryVC   = "CategoryVC"
    static let CountryVC    = "CountryVC"
    //storyboard headlinenews
    static let   navHeadLineNews           =  "NavHeadLineNews"
    static let mainHeadLineNews   = "HeadLineNews"
    static let headLineNewsVC   = "HeadLineNewsVC"
 
    
}


