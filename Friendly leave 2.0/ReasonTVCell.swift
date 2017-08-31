//
//  ReasonTVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-02.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class ReasonTVCell: SummaryBaseTVCell {
    
    override var setRequestInfo: LeaveRequestInfo?{
        
        didSet{
            
            reasonTV.text = setRequestInfo?.reason
        }
        
    }
    
    let reasonTV:UITextView = {
        
        let tv = UITextView()
        tv.text = ""
        tv.textColor = CustomColor.darkAsh
        tv.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        tv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.isSelectable = false
        return tv
        
    }()
    
    
    
    override func setupInLoad() {
        
        addSubview(reasonTV)
        
        reasonTV.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        reasonTV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        reasonTV.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        reasonTV.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        
    }
    
}
