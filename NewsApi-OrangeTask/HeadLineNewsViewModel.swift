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
    // read from usedefulat  favorite country which i choose it
    let userDefaultsCountryName = UserDefaults.standard.string(forKey: Constant.countryName)
    let userDefaultsCategoryName:[Any]? = UserDefaults.standard.array(forKey: Constant.categoryName)

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
        filteredData = cellViewModel.filter({ $0.title.contains(searchText.lowercased())})
        filteredData = cellViewModel.filter({ $0.title.contains(searchText.uppercased())})

        self.reloadTableViewClouser?()
        
    }
    // return number count of cell
    var numberOfCellNews :Int {
        return cellViewModel.count
    }
    var numberOfCellSearch :Int {
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
    func initFetchDataFavoriteCategroy(){
        guard let userDefaultsCategoryName = userDefaultsCategoryName as? [String] else {
            return
        }
        state = .loading
        for categoy in userDefaultsCategoryName {
            group.enter()
            apiService.getNewsList(countryName:userDefaultsCountryName ?? "empty countyName", categoryName:categoy){[weak self] result in
                guard let self = self else{return}
                self.group.leave()
                switch result {
                case .success(let response):
                    self.processFetchedArticle(articles: response.articles )
                    self.sortByDate()
                    self.state = .populated
                case .failure(let error):
                    self.state = .error
                    self.alertMessage = error.rawValue
                }
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
        let  title   = article.title ?? ""
        let  date    = article.publishedAt ?? ""
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
    func articleDetails( at indexPath: IndexPath ){
        let article = self.articleData[indexPath.row]
        self.selectedArticle = article
    }
    // ordered data by date to show it
    private func sortByDate(){
        self.cellViewModel.sort(by: {($0.date ).count < ($1.date ).count })
    }
}

