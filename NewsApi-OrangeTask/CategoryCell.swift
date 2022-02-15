//
//  CategoryCell.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var nameCategoryLabel: UILabel!
    
    // The var  categoryCellViewModel read data from it and pass it from CategoryVC
    var categoryCellViewModel:CategoryCellViewModel?{
        didSet{
            nameCategoryLabel.text = categoryCellViewModel?.categoryName
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //customize constrain cell
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 10, bottom:2, right: 10))
    }
}
