//
//  SrearchViewModel.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
class SearchViewModel {
    
    let apiService : ApiServiceProtocolSearch
    var selectedArticle: Article?
    // articleData   is array of DataSource to append data it
    private  var articleData = [Article]()
    
    init( apiService : ApiServiceProtocolSearch = ApiService()) {
        self.apiService = apiService
    }
    
    var reloadTableViewClouser:(()->())?
    var showAlertClouser:(()->())?
    var updateLoadingStatus : (()->())?
    
    
    var cellViewModel:[SearchCellViewModel] = [SearchCellViewModel](){
        didSet{
            self.reloadTableViewClouser?()
        }
    }
    
   
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClouser?()
        }
    }
    
    var numofCell : Int {
        return cellViewModel.count
    }
    
    func initFetchData(searchText : String){
        state = .loading
        apiService.searchResult(searchText: searchText) { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                self.processFetchedArticle(result: response.articles)
                self.state = .populated
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue
                
            }
        }
    }
    
    func getCellViewModel(at indexPath : IndexPath) -> SearchCellViewModel {
        return cellViewModel[indexPath.row]
    }
    
    func creatCellModel(resultArticle : Article)->SearchCellViewModel{
        let  title       = resultArticle.title
        let  date        = resultArticle.publishedAt
        let  image       = resultArticle.urlToImage ?? ""
        let  source      = resultArticle.source.name
        let  name        = resultArticle.source.name
        let  description = resultArticle.articleDescription
        let  url         = resultArticle.url
        
        return SearchCellViewModel(title: title, date: date, image: image, source: source, name: name, description: description ?? "", url: url)
    }
    
    func processFetchedArticle(result : [Article]){
        // api
        self.articleData = result
        
        var vms = [SearchCellViewModel]()
        // save in cell model
        for results in result {
            vms.append(creatCellModel(resultArticle: results))
        }
        // equel cell view model
        self.cellViewModel = vms
    }
    func userPressed(at indexPath : IndexPath){
        let news = articleData[indexPath.item]
        self.selectedArticle = news
    }
    
    

}
