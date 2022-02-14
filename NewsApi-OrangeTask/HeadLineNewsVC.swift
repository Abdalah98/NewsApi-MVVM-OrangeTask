//
//  HeadLineNewsVC.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class HeadLineNewsVC: UIViewController {
    
    @IBOutlet weak var headLineNewsTableView: UITableView!
    
    var searching = false
    let searchController = UISearchController()

    // binding with viewModel
    lazy var viewModel: HeadLineNewsViewModel = {
        return  HeadLineNewsViewModel()
    }()
    
    let activity: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.style = .large
        aiv.color = .label
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.vms.count,"vms")
        configureNIBCell()
        tableViewDesign()
        view.addSubview(activity)
        activity.fillSuperview()
        initVM()
        
        configureSearch()
        //        NotificationCenter.default.addObserver(self,selector: #selector(statusManager),name: .flagsChanged,object: nil)
        //        updateUserInterface()
    }
    
    // check Network connection
    /// check network connection and get data
    /// case unreachable that mean no internet connection
    /// case wwan that mean via a cellular connection
    /// case wwan that mean via a wifi connection
    //    func updateUserInterface() {
    //        switch Network.reachability.status {
    //        case .unreachable:
    //            self.showAlert("you don't have connection check cellular connection or wifi!")
    //            initVM()
    //        case .wwan:
    //            initVM()
    //        case .wifi:
    //            initVM()
    //        }
    //        print("Reachability Summary")
    //        print("Status:", Network.reachability.status)
    //        print("HostName:", Network.reachability.hostname ?? "nil")
    //        print("Reachable:", Network.reachability.isReachable)
    //        print("Wifi:", Network.reachability.isReachableViaWiFi)
    //    }
    //
    //    /// Update User Interface if has connection or not has connection networking
    //    /// - Parameter notification: notification center
    //    @objc func statusManager(_ notification: Notification) {
    //        updateUserInterface()
    //    }
    //
    
    
    //  activityView Hide when get data or found error
    func stopActivity(){
        self.activity.stopAnimating()
        self.activity.hidesWhenStopped = true
    }
    // fetch data
    // fetch data when binding with Closure
    func initVM(){
        showAlert()
        updateLoadingStatus()
        reloadTableView()
        viewModel.initFetchDataFirstCategroy()
        viewModel.initFetchDatSecCategroy()
        viewModel.initFetchDataThirdCategroy()
        
    }
    ///  show Alert Closure : when get error or happen something show me error in Alert extension
    fileprivate func showAlert() {
        viewModel.showAlertClosure = {[weak self] in ()
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage  {
                    self?.showAlert(message)
                }
            }
        }
    }
    // updateLoadingStatus: when call data i show loading Activity when i fetch all data  it hidden or when something error it hide and show it data downloading
    // animate when collection show it
    fileprivate func  updateLoadingStatus() {
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
                        self.headLineNewsTableView.alpha = 0.0
                    })
                case .loading:
                    self.activity.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.headLineNewsTableView.alpha = 0.0
                    })
                case .populated:
                    self.stopActivity()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.headLineNewsTableView.alpha = 1.0
                    })
                }
            }
        }
    }
    // reloadTableViewClouser:  reload data when it comes to show in reloadTableViewClouser and fetch data
    fileprivate func reloadTableView() {
        viewModel.reloadTableViewClouser = {[weak self] in ()
            DispatchQueue.main.async {
                self?.headLineNewsTableView.reloadData()
            }
        }
    }
    //add search in navigationItem
    fileprivate func configureSearch() {
        searchController.searchBar.placeholder = "Search Here"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
}


extension HeadLineNewsVC :UISearchBarDelegate, UISearchControllerDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if searchText == ""{
            searching = false
            
        }else{
            print(searchText)
            viewModel.searchArticle(searchText: searchText)
            searching = true
            
            reloadTableView()
        }
    }
    
    
}
