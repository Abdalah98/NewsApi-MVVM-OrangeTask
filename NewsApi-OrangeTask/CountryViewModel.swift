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
    private var countryName = [Country(countryName: "Egypt", countryImage: "egypt", countryAppreviation: "eg"),
                               Country(countryName: "The United States of America", countryImage: "united-states", countryAppreviation: "us"),
                               Country(countryName: "France", countryImage: "france", countryAppreviation: "fr"),
                               Country(countryName: "The United Arab Emirates", countryImage: "united-arab-emirates", countryAppreviation: "ar"),
                               Country(countryName: "Germany", countryImage: "germany", countryAppreviation: "de"),
                               Country(countryName: "Russia", countryImage: "russia", countryAppreviation: "ru"),
                               
                               Country(countryName: "Italian Republic", countryImage: "italy", countryAppreviation: "it"),
                               Country(countryName: "Japan", countryImage: "japan", countryAppreviation: "jp"),
                               Country(countryName: "Norway", countryImage: "norway", countryAppreviation: "no"),
                               
                               Country(countryName: "New Zealand", countryImage: "new-zealand", countryAppreviation: "nz"),
                               Country(countryName: "Australia", countryImage: "australia", countryAppreviation: "au"),
    ]
    
    // The cellViewModel in which I put the data  i get it from json and put in cell when data isready
    private var cellViewModel : [CountryCellViewModel] = [CountryCellViewModel]()
    
    // return number count of cell
    var numberOfCell :Int {
        return cellViewModel.count
    }
    //
    func initFetchData(){
        self.processFetchedCountry(country: countryName)
    }
    
    // call each cell and return data by indexPath item
    func getCellViewModel(at indexPath : IndexPath) -> CountryCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    //  i fetch data and i put data  in CountryNameCellViewModel
    func createCellViewModel( country: Country ) -> CountryCellViewModel {
        let countryName = country.countryName
        let countryImage = country.countryImage
        let countryAppreviation = country.countryAppreviation
        return CountryCellViewModel(countryName: countryName, countryAppreviation: countryAppreviation, countryIamge: countryImage)
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
        //  print(selectedIndex?.countryAppreviation ?? "","index")
        // when selected indexPath save in userDefaults
        userDefaults.set(selectedIndex?.countryAppreviation ?? "", forKey: Constant.countryName)
        
    }
}

