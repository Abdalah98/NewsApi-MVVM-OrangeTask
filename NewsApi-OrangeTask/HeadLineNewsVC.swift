//
//  HeadLineNewsVC.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class HeadLineNewsVC: UIViewController {

    @IBOutlet weak var headLineNewsTableView: UITableView!
    
    
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
         configureNIBCell()
         tableViewDesign()
        view.addSubview(activity)
        activity.fillSuperview()
        initVM()
    }


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
        reloadCollectionView()
        viewModel.initFetchData()
 
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
    /// updateLoadingStatus: when call data i show loading Activity when i fetch all data  it hidden or when something error it hide and show it data downloading
    /// animate when collection show it
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
    /// reloadTableViewClouser:  reload data when it comes to show in reloadTableViewClouser and fetch data
    fileprivate func  reloadCollectionView() {
        viewModel.reloadTableViewClouser = {[weak self] in ()
            DispatchQueue.main.async {
                self?.headLineNewsTableView.reloadData()
            }
        }
    }
   
}


