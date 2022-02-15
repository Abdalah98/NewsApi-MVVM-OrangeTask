//
//  CategoryVC.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var CategoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Category"
        configureNIBCell()
        tableViewDesign()
        viewModel.initFetchData()
        
    }
    // binding with viewModel
    lazy var viewModel: CategoryViewModel = {
        return  CategoryViewModel()
    }()
    
    @IBAction func nextAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constant.mainHeadLineNews, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constant.navHeadLineNews)
        nextViewController.modalPresentationStyle = .fullScreen
        viewModel.didTabNextCategory()
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}



