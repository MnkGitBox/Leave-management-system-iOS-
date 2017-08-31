//
//  ReasonsTableViewCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class ReasonsTableViewCell: UITableViewCell {
    
    var title:String?{
        didSet{
            guard let title = title else {return}
            header.text = title
        }
    }
    var value:String?{
        didSet{
            guard let value = self.value else {return}
            reasonDescription.text = value
        }
    }
    
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var reasonDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        
        
    }
    
    
}
