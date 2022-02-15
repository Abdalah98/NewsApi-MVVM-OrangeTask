//
//  CategoryVCTableView+EXT.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/15/22.
//

import UIKit
extension CategoryVC : UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source
    // creatNibCell and call it
    func configureNIBCell(){
        let nib = UINib(nibName: Cell.categoryCell, bundle: nil)
        CategoryTableView.register(nib, forCellReuseIdentifier: Cell.categoryCell)
    }
    
     func tableViewDesign() {
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

//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
      //  self.viewModel.selectedCategoy.a
      self.viewModel.selectCategory(at: indexPath)
    print(indexPath)
    }
}
