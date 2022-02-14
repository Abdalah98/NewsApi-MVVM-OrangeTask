//
//  SearchVC.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/14/22.
//

import UIKit
class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    let searchController = UISearchController()
    
    var viewModel : SearchViewModel = {
        return SearchViewModel()
    }()
    
    let activity: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.style = .large
        aiv.color = .label
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    //  activityView Hide when get data or found error
    func stopActivity(){
        self.activity.stopAnimating()
        self.activity.hidesWhenStopped = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.allowsSelection = true
        tableViewDesign()
        configureNIBCell()
        view.addSubview(activity)
        activity.fillSuperview()
        configureSearch()
        stopActivity()
    }
    
    fileprivate func configureSearch() {
        searchController.searchBar.placeholder = "Search Here"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    func initVM(searchText:String){
        
        viewModel.showAlertClouser = { [weak self ] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
            
        }
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.stopActivity()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.searchTableView.alpha = 0.0
                    })
                case .loading:
                    self.activity.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.searchTableView.alpha = 0.0
                    })
                case .populated:
                    self.stopActivity()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.searchTableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClouser = { [weak self] () in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }
        viewModel.initFetchData(searchText: searchText)
    }
}


extension SearchVC :UISearchBarDelegate, UISearchControllerDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        initVM(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cellViewModel.removeAll()
        self.searchTableView.reloadData()
        
    }
    
}
