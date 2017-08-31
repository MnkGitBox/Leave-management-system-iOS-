//
//  Calender Date Cell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-30.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalenderDateCell: JTAppleCell {
    
    let date:UILabel = {
        
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = CustomColor.darkAsh
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        return label
        
    }()
    let selectedIndicator:UIView = {
        
        let v = UIView()
        v.backgroundColor = CustomColor.calenderRed
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    let todayIndicator:UIView = {
        
        let view = UIView()
        view.backgroundColor = CustomColor.green
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cellMesarment:CGFloat = 24
    
    var rangeIndicator:UIView = {
        
        let view = UIView()
        view.backgroundColor = CustomColor.calenderRed.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var rangeIndicatorLeftAnchor:NSLayoutConstraint!
    var rangeIndicatorRightAnchor:NSLayoutConstraint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(rangeIndicator)
        rangeIndicatorLeftAnchor = rangeIndicator.leftAnchor.constraint(equalTo: leftAnchor)
        rangeIndicatorLeftAnchor.isActive = true
        rangeIndicatorRightAnchor = rangeIndicator.rightAnchor.constraint(equalTo: rightAnchor)
        rangeIndicatorRightAnchor.isActive = true
        rangeIndicator.heightAnchor.constraint(equalToConstant: cellMesarment - 6).isActive = true
        rangeIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        selectedIndicator.layer.cornerRadius = cellMesarment / 2
        addSubview(selectedIndicator)
        selectedIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectedIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedIndicator.heightAnchor.constraint(equalToConstant: cellMesarment).isActive = true
        selectedIndicator.widthAnchor.constraint(equalToConstant: cellMesarment).isActive = true
        
        addSubview(todayIndicator)
        todayIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        todayIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        todayIndicator.heightAnchor.constraint(equalToConstant: cellMesarment).isActive = true
        todayIndicator.widthAnchor.constraint(equalToConstant: cellMesarment).isActive = true
        
        todayIndicator.layer.cornerRadius = cellMesarment / 2
        
        addSubview(date)
        date.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        date.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        rangeIndicator.isHidden = true
        selectedIndicator.isHidden = true
        todayIndicator.isHidden = true
        
    }
    
    func specialStateCell(piority side:Side){
        
        selectedIndicator.isHidden = false
        rangeIndicator.isHidden = false
        
        switch side {
        case .left:
            rangeIndicatorRightAnchor.constant = -(frame.width / 2)
        case .right:
            rangeIndicatorLeftAnchor.constant = frame.width / 2
        }
        
        
    }
    
    func unSpecialStateCell(){
        selectedIndicator.isHidden = true
        rangeIndicator.isHidden = false
        rangeIndicatorRightAnchor.constant = 0
        rangeIndicatorLeftAnchor.constant = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum Side{
    case left
    case right
}
