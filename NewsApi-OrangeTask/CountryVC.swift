//
//  CountryVC.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class CountryVC: UIViewController {
    
    @IBOutlet weak var CountryTableView: UITableView!
    // check is select Country or no
    var selectCell = false
    // binding with viewModel
    lazy var viewModel: CountryViewModel = {
        return  CountryViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNIBCell()
        tableViewDesign()
        viewModel.initFetchData()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if selectCell == false {
            self.showAlert("please choose Country")
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: Constant.main, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constant.categoryVC) 
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


