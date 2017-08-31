//
//  SummaryBaseTVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-02.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class SummaryBaseTVCell: UITableViewCell {
    
    var setRequestInfo:LeaveRequestInfo?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupInLoad()
    }
    
    func setupInLoad(){
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
