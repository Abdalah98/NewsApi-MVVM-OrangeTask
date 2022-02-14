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
        title = "choose Category"
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
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}

extension CategoryVC : UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source
    
    func configureNIBCell(){
        let nib = UINib(nibName: Cell.categoryCell, bundle: nil)
        CategoryTableView.register(nib, forCellReuseIdentifier: Cell.categoryCell)
    }
    fileprivate func tableViewDesign() {
        CategoryTableView.tableFooterView = UIView()
        CategoryTableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.categoryCell, for: indexPath) as? CategoryCell else{
            fatalError("Not found cell identifier")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.categoryCellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectCategory(at: indexPath)
        
    }
}


