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
    
}
