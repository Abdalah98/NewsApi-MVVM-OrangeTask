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
            checkImage.image      = UIImage(named: countryNameCellViewModel?.countryIamge ?? "")
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 10, bottom:2, right: 10))
    }
   
}
