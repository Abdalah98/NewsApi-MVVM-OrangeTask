//
//  CountryNameCell.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class CountryNameCell: UITableViewCell {
    @IBOutlet weak var checkImage : UIImageView!
    @IBOutlet weak var nameCountryLabel: UILabel!
    
    var countryNameCellViewModel:CountryCellViewModel?{
        didSet{
            nameCountryLabel.text = countryNameCellViewModel?.countryName
        }
    }
    
    override var isSelected: Bool{
        didSet{
            nameCountryLabel.textColor = isSelected ? #colorLiteral(red: 0.9973734021, green: 0.6361894011, blue: 0.07230844349, alpha: 1) : #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1)
        }
    }
}
