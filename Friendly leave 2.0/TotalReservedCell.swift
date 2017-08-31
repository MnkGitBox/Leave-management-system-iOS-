//
//  TotalReservedCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class TotalReservedCell: UITableViewCell {
    
    @IBOutlet weak var reservedTimePeriod: UILabel!
    @IBOutlet weak var timePeriod: UILabel!
    @IBOutlet weak var reservedTimePeriodContainer: UIView!
    
    var period:String?{
        
        didSet{
            timePeriod.text = "total reserved for \(period!)".capitalized
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reservedTimePeriodContainer.backgroundColor = CustomColor.darkGreen
        reservedTimePeriodContainer.layer.cornerRadius = 3
        reservedTimePeriodContainer.clipsToBounds = true
        
    }
    
    
}
