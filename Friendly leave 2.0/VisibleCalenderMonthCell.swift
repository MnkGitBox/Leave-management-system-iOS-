//
//  VisibleCalenderMonthCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-14.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class VisibleCalenderMonthCell: UICollectionViewCell {
    
    @IBOutlet weak var monthAndYear: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthAndYear.textColor = CustomColor.whiteCream
        
    }
    
}
