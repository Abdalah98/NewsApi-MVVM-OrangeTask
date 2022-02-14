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
    
    var filteredData = [HeadLineNewsCellViewModel]()
    
    var vms = [HeadLineNewsCellViewModel]()
    let group = DispatchGroup()
    
    let userDefaultsCountryName = UserDefaults.standard.string(forKey: Constant.countryName)
    
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
        group.notify(queue: .main ){ [weak self] in
            guard let self = self else{return}
            self.reloadTableViewClouser?()
        }
    }
    
    func searchArticle(searchText:String){
        filteredData = cellViewModel

        filteredData = cellViewModel.filter({ $0.title.contains(searchText)})
                    self.reloadTableViewClouser?()
      
    }
    // return number count of cell
    var numberOfCell :Int {
        print(cellViewModel.count)
        return cellViewModel.count
    }
    var numberOfCellSearch :Int {
        print(filteredData.count)
        return filteredData.count
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
    func initFetchDataFirstCategroy(){
        state = .loading
        group.enter()
        apiService.getNewsList(countryName:userDefaultsCountryName ?? "empty countyName", categoryName:"health"){[weak self] result in
            guard let self = self else{return}
            self.group.leave()
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
    func initFetchDatSecCategroy(){
        state = .loading
        group.enter()
        apiService.getNewsList(countryName:userDefaultsCountryName ?? "empty countyName", categoryName: "entertainment"){[weak self] result in
            guard let self = self else{return}
            self.group.leave()

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
    func initFetchDataThirdCategroy(){
        state = .loading
        group.enter()
        apiService.getNewsList(countryName:userDefaultsCountryName ?? "empty countyName", categoryName:"technology"){[weak self] result in
            guard let self = self else{return}
            self.group.leave()

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
    
    func getCellViewModelSearch(at indexPath : IndexPath) -> HeadLineNewsCellViewModel{
        return filteredData[indexPath.item]
    }
    
    //  i fetch data and i put data  in HeadLineNewsCellViewModel
    func createCellViewModel( article: Article ) -> HeadLineNewsCellViewModel {
        let  title  = article.title ?? ""
        let  date   = article.publishedAt ?? ""
        let  image   = article.urlToImage ?? ""
        let  source  = article.source?.name ?? ""
        let  name    = article.source?.name ?? ""
        let  description = article.articleDescription ?? ""
        let  url     = article.url ?? ""
        
        return HeadLineNewsCellViewModel(title: title, date: date, image: image, source: source, name: name, description: description , url: url )
        
    }

    
    // fetch all articles for loop it  and append data in createCellViewModel
    private func processFetchedArticle( articles: [Article] ) {
        self.articleData = articles // Cache
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

