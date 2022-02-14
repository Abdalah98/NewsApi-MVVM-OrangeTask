//
//  CountryViewModel.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
class CountryViewModel {
    let userDefaults = UserDefaults.standard

    var selectedIndex:Country?
private var countryName = [Country(name: "ae"),
                 Country(name: "ar"),
                 Country(name: "at"),
                 Country(name: "au"),
                 Country(name: "be"),
                 Country(name: "bg"),
                 Country(name: "br"),
                 Country(name: "ca"),
                 Country(name: "au"),
                 Country(name: "ch"),
                 Country(name: "cn"),
                 Country(name: "co"),
                 Country(name: "cu"),
                 Country(name: "cz"),
                 Country(name: "de"),
                 Country(name: "eg"),
                 Country(name: "fr"),
                 Country(name: "gb"),
                 Country(name: "gr"),
                 Country(name: "hk"),
                 
                 Country(name: "hu"),
                 Country(name: "id"),
                 Country(name: "ie"),
                 Country(name: "il"),
                 Country(name: "in"),
                 Country(name: "it"),
                 Country(name: "jp"),
                 Country(name: "kr"),
                 Country(name: "lt"),
                 Country(name: "lv"),
                 Country(name: "ma"),
                 Country(name: "mx"),
                 
                 Country(name: "ng"),
                 Country(name: "nl"),
                 Country(name: "no"),
                 Country(name: "nz"),
                 Country(name: "ph"),
                 Country(name: "pl"),
                 Country(name: "pt"),
                 Country(name: "ro"),
                 Country(name: "rs"),
                 Country(name: "ru"),
                 Country(name: "sa"),
                 Country(name: "se"),
                 Country(name: "sg"),
                 Country(name: "si"),
                 Country(name: "sk"),
                 Country(name: "th"),
                 Country(name: "tr"),
                 Country(name: "tw"),
                 Country(name: "ua"),
                 Country(name: "us"),
                 Country(name: "ve"),
                 Country(name: "za")
]
    
    // The cellViewModel in which I put the data  i get it from json and put in cell when data isready
    private var cellViewModel : [CountryCellViewModel] = [CountryCellViewModel]()
   
 
    // return number count of cell
    var numberOfCell :Int {
        return cellViewModel.count
    }
    func initFetchData(){
         
    self.processFetchedCountry(country: countryName)
    }
    
    // call each cell and return data by indexPath item
       func getCellViewModel(at indexPath : IndexPath) -> CountryCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    //  i fetch data and i put data  in CountryNameCellViewModel
 
    func createCellViewModel( country: Country ) -> CountryCellViewModel {
        let countryName = country.name

        return CountryCellViewModel(countryName: countryName)
    }
    // fetch all Country and for loop it  and append data in createCellViewModel
     private func processFetchedCountry( country: [Country] ) {
        self.countryName = country // Cache
        var vms = [CountryCellViewModel]()
        for allCountry in country {
            vms.append( createCellViewModel(country: allCountry) )
        }
        self.cellViewModel = vms
    }

 
    // return when i selectedNews cell get cell indexPath Item
    func selectCountry( at indexPath: IndexPath ){
        let country = self.countryName[indexPath.row]
 
        self.selectedIndex = country
    }
}
 
