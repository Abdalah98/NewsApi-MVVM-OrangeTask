//
//  CountryVC.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class CountryVC: UIViewController {
  
    
    @IBOutlet weak var CountryTableView: UITableView!
    
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
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
                 self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
}

extension CountryVC : UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source

    func configureNIBCell(){
        let nib = UINib(nibName: Cell.countryCell, bundle: nil)
        CountryTableView.register(nib, forCellReuseIdentifier: Cell.countryCell)
    }
    fileprivate func tableViewDesign() {
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
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.countryCell, for: indexPath) as? CountryNameCell {
                    cell.isSelected = true
            self.viewModel.selectCountry(at: indexPath)

                }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.countryCell, for: indexPath) as? CountryNameCell {
                    cell.isSelected = false
            self.viewModel.selectCountry(at: indexPath)

                }
  print(viewModel.selectCountry(at: indexPath))
    }
    
  
  //
//        let storyBoard: UIStoryboard = UIStoryboard(name: "RegisterFemale", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "SplashFemale") as! SplashVC
//        userDefaults.set(genderType, forKey: Constant.genderType)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
