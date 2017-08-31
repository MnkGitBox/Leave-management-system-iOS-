//
//  SLDTableViewHeaderCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-24.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class SLDTableViewHeaderCell: UITableViewCell {
    
    var header:UILabel = {
        let label = UILabel()
        label.text = "HEADER"
        label.font = UIFont.systemFont(ofSize: 12.5, weight: UIFontWeightRegular)
        label.textColor = CustomColor.whiteCream
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = CustomColor.turqueGreen
        
        addSubview(header)
        header.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        header.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5).isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
