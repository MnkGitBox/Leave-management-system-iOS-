//
//  SingleDateTimeTableViewCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-07.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class SingleDateTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    var valueDic:[ValuesKey:Any]?{
        
        didSet{
            guard let newData = valueDic else{return}
            
            date.text = newData[.date] as? String
            //            time.text = newData[.time] as? String
            
        }
        
    }
    
    
}
