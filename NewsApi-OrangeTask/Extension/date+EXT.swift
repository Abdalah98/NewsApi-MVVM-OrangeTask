//
//  date+EXT.swift
//  News
//
//  Created by Abdallah on 8/11/21.
//

import Foundation
extension Date{
    func convertToMonthYearFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
        
    }
}
