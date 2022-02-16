//
//  CountryVCTableView+EXT.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/14/22.
//

import UIKit

extension CountryVC : UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source
    
    func configureNIBCell(){
        let nib = UINib(nibName: Cell.countryCell, bundle: nil)
        CountryTableView.register(nib, forCellReuseIdentifier: Cell.countryCell)
    }
    
    func tableViewDesign() {
        CountryTableView.tableFooterView = UIView()
        CountryTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.countryCell, for: indexPath) as? CountryNameCell else{
            fatalError("Not found cell identifier")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.countryNameCellViewModel = cellVM
        
        if cell.accessoryType == .none{
            self.selectCell = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //to select the same selectIndex
        selectCell = true
        self.viewModel.selectCountry(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
