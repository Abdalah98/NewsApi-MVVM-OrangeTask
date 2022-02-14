//
//  HeadLineNewsCell.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

class HeadLineNewsCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    var callBack:(()->())?
    var url:String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom:5, right: 10))
    }

    /// The var  headLineNewsCellViewModel read data from it and pass it from headLine vc
    var headLineNewsCellViewModel:HeadLineNewsCellViewModel?{
        didSet{
            titleLabel.text = headLineNewsCellViewModel?.title
            dateLabel.text = headLineNewsCellViewModel?.date.convertToDisplayFormat()
            discriptionLabel.text = headLineNewsCellViewModel?.description
            sourceLabel.text = headLineNewsCellViewModel?.name
            // download image from  api and  save in cache
            url  =  headLineNewsCellViewModel?.url
            if let url = headLineNewsCellViewModel?.image {
                self.imageNews.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "no_image_placeholder"))
            }
        }
    }
    
    @IBAction func oprnUrlAction(_ sender: Any) {
        callBack?()
    }
    
}
