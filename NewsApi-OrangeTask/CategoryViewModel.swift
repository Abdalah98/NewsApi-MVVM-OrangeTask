//
//  CategoryViewModel.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
class CategoryViewModel {
    let userDefaults = UserDefaults.standard
    
    var selectedIndex:Category?
 private var categoryName = [Category(categoryName: "business"),
                                Category(categoryName: "entertainment"),
                                Category(categoryName: "general"),
                                Category(categoryName: "health"),
                                Category(categoryName: "science"),
                                Category(categoryName: "sports"),
                                Category(categoryName: "technology")]
    
    // The cellViewModel in which I put the data  i get it from json and put in cell when data isready
    private var cellViewModel : [CategoryCellViewModel] = [CategoryCellViewModel]()
   
 
    // return number count of cell
    var numberOfCell :Int {
        return cellViewModel.count
    }
    func initFetchData(){
         
    self.processFetchedCategoy(category: categoryName)
    }
    
    // call each cell and return data by indexPath item
       func getCellViewModel(at indexPath : IndexPath) -> CategoryCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    //  i fetch data and i put data  in categoryCellViewModel
    func createCellViewModel( category: Category ) -> CategoryCellViewModel {
        let categoryName = category.categoryName

        return CategoryCellViewModel(categoryName:categoryName)
    }
    
    // fetch all category and for loop it  and append data in createCellViewModel
     private func processFetchedCategoy( category: [Category] ) {
        self.categoryName = category // Cache
        var vms = [CategoryCellViewModel]()
        for allcategory in category {
            vms.append(createCellViewModel(category: allcategory) )
        }
        self.cellViewModel = vms
    }
    
     var selectedCategoy = [Category]()
      
     // return when i selectedcategoryName cell get cell indexPath Item
    func selectCategory( at indexPath: IndexPath ){
        let category = self.categoryName[indexPath.row]
        self.selectedIndex =  category
        self.selectedCategoy.append(category)
    }
    
    func didTabNextCategory(){
        let categoryName = selectedCategoy.map{ $0.categoryName}
        userDefaults.set(categoryName, forKey: Constant.categoryName)
    }
}
