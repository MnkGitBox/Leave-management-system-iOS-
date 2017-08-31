//
//  FromToDateTableViewCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class FromToDateTableViewCell: UITableViewCell {
    
    
    var valuesDic:[ValuesKey:String]?{
        
        didSet{
            
            guard let valuesDic = valuesDic else {return}
            
            begineDate.text = valuesDic[.beginDate]
            returnDate.text = valuesDic[.returnDate]
            
            datesBetweenLeave.text = valuesDic[.betweenDays]
            dayOrDays.text = valuesDic[.dayOrDays]
            
            
            
        }
        
    }
    
    
    
    @IBOutlet weak var datesBetweenLeave: UILabel!
    @IBOutlet weak var dayOrDays: UILabel!
    
    @IBOutlet weak var begineDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
    
    @IBOutlet weak var topContainer: UIView!
    
    @IBOutlet weak var detailCOntainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        detailCOntainer.layer.cornerRadius = 3
        //        detailCOntainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        //        detailCOntainer.layer.shadowRadius = 4
        //        detailCOntainer.layer.shadowOpacity = 0.2
        //        detailCOntainer.layer.masksToBounds = false
        
        //        topContainer.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        //        currStateIndicator.layer.shadowOpacity = 0.2
        //        currStateIndicator.layer.shadowRadius = 4
        //        currStateIndicator.layer.shadowOffset = CGSize(width: -1, height: 1)
        //        currStateIndicator.layer.masksToBounds = false
        
    }
    
    
    
}
