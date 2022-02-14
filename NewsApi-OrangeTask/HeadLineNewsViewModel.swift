//
//  HeadLineNewsViewModel.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
class HeadLineNewsViewModel{
    // i  do  ApiServiceProtocol  to Dependency Injection
    let apiService : ApiServiceProtocol
    var selectedArticle: Article?
    // articleData   is array of DataSource to append data it
    private  var articleData = [Article]()
    
    // The cellViewModel in which I put the data  i get it from json and put in cell when data isready it call reloadTableViewClouser
    private var cellViewModel : [HeadLineNewsCellViewModel] = [HeadLineNewsCellViewModel](){
        didSet{
            self.reloadTableViewClouser?()
        }
    }
    
    // callback for interfaces
    var reloadTableViewClouser :(()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    // i  do init to easy mocking   ApiServiceProtocol  to Dependency Injection
    init(apiService : ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    // return number count of cell
    var numberOfCell :Int {
        print(cellViewModel.count)
        return cellViewModel.count
    }
    //  base of loading view
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    // alertMessage  put the error in it if get error from api i  put it and show in Alert
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    // once call it initFetchData in viewController the start state loading
    // if get error change state to error and hide loading and show Alert
    // and get data and make process
    func initFetchData(){
        state = .loading
        apiService.getNewsList{[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                self.processFetchedArticle(articles: response.articles )
                self.state = .populated
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue
            }
        }
     
    }
    func initFetchData2(){
        state = .loading
    apiService.getNewsList2{[weak self] result in
        guard let self = self else{return}
        switch result {
        case .success(let response):
            
            self.processFetchedArticle(articles: response.articles )
            self.state = .populated
            
        case .failure(let error):
            self.state = .error
            self.alertMessage = error.rawValue
        }
    }
    }
    func initFetchData3(){
        state = .loading
    apiService.getNewsList3{[weak self] result in
        guard let self = self else{return}
        switch result {
        case .success(let response):
            
            self.processFetchedArticle(articles: response.articles )
            self.state = .populated
            
        case .failure(let error):
            self.state = .error
            self.alertMessage = error.rawValue
        }
    }
    }
    // call each cell and return data by indexPath item
    func getCellViewModel(at indexPath : IndexPath) -> HeadLineNewsCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    //  i fetch data and i put data  in HeadLineNewsCellViewModel
    func createCellViewModel( article: Article ) -> HeadLineNewsCellViewModel {
        let  title  = article.title
        let  date   = article.publishedAt
        let  image   = article.urlToImage ?? ""
        let  source  = article.source.name
        let  name    = article.source.name
        let  description = article.articleDescription
        let  url     = article.url
        
        return HeadLineNewsCellViewModel(title: title, date: date, image: image, source: source, name: name, description: description ?? "", url: url)
        
    }
    // fetch all articles for loop it  and append data in createCellViewModel
    private func processFetchedArticle( articles: [Article] ) {
        self.articleData = articles // Cache
        var vms = [HeadLineNewsCellViewModel]()
        for article in articles {
            vms.append( createCellViewModel(article: article) )
        }
        self.cellViewModel = vms
    }
    
    // return when i selectedArticle cell get cell indexPath Item
    func productDetails( at indexPath: IndexPath ){
        let article = self.articleData[indexPath.row]
        self.selectedArticle = article
    }
}
