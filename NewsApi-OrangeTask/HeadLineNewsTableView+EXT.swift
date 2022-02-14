//
//  HeadLineNewsTableView+EXT.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/14/22.
//

import Foundation
import UIKit
extension HeadLineNewsVC : UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source
    
    func configureNIBCell(){
        let nib = UINib(nibName: Cell.headLineNewsCell, bundle: nil)
        headLineNewsTableView.register(nib, forCellReuseIdentifier: Cell.headLineNewsCell)
    }
    func tableViewDesign() {
        headLineNewsTableView.tableFooterView = UIView()
        headLineNewsTableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfCell)
        return viewModel.numberOfCell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.headLineNewsCell, for: indexPath) as? HeadLineNewsCell else{
            fatalError("Not found cell identifier")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.headLineNewsCellViewModel = cellVM
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
