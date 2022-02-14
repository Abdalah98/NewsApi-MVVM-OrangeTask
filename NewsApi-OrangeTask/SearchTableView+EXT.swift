//
//  SearchTableView+EXT.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/14/22.
//

import UIKit
extension SearchVC : UITableViewDataSource , UITableViewDelegate{
    
    
    func configureNIBCell(){
        let nib = UINib(nibName: Cell.headLineNewsCell, bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: Cell.headLineNewsCell)
    }
    
    
    func tableViewDesign() {
        searchTableView.tableFooterView = UIView()
        searchTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.numofCell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: Cell.headLineNewsCell) as? HeadLineNewsCell else {
            fatalError("Cell not exists in storyboard")
        }
        let result = viewModel.getCellViewModel(at: indexPath)
        cell.searchCellViewModel = result
        cell.callBack = {
            // open Url inside cell
            self.goSafari(urlString: cell.url ?? "")
        }
        return cell
     }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
    
}
