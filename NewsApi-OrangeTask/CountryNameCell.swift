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
   // The var  countryNameCellViewModel read data from it and pass it from CountryVC
    var countryNameCellViewModel:CountryCellViewModel?{
        didSet{
            nameCountryLabel.text = countryNameCellViewModel?.countryName
            checkImage.image      = UIImage(named: countryNameCellViewModel?.countryIamge ?? "")
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //customize constrain cell
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 10, bottom:2, right: 10))
    }
   
    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            selectionStyle = .none
        }
}
