//
//  StateTableViewCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {
    
    var title:String?{
        didSet{
            guard let title = title else {return}
            header.text = title
        }
    }
    var value:String?{
        didSet{
            guard let value = self.value else {return}
            state.text = value
        }
    }
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var state: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //configure state label
        state.layer.cornerRadius = 6
        state.layer.masksToBounds = true
        
    }
    
    
    
}
