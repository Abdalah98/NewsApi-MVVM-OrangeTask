//
//  CategoryCell.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var nameCategoryLabel: UILabel!
 
    var categoryCellViewModel:CategoryCellViewModel?{
        didSet{
            nameCategoryLabel.text = categoryCellViewModel?.categoryName
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 10, bottom:2, right: 10))
    }
}
