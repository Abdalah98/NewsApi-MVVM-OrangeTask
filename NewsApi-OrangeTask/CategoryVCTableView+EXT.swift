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
        // check it selected or no
        cell.accessoryType = selectedEventTypes.contains(indexPath) ? .checkmark:.none
        return cell
    }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: false)
        // if i unselected it remove it from selectCategory
           if selectedEventTypes.contains(indexPath) {
               selectedEventTypes.remove(indexPath)
            self.viewModel.selectCategory(at: indexPath)
            // if i selected 3 categories  it append  in selectCategory
           } else if selectedEventTypes.count < 3 {
               selectedEventTypes.insert(indexPath)
              self.viewModel.selectCategory(at: indexPath)
           }
        tableView.reloadRows(at: [indexPath], with:.none)
       }


    
    
    
}
