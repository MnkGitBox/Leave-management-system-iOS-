//
//  DateCountCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-15.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class DateCountCell: SummaryBaseTVCell {
    
    override var setRequestInfo: LeaveRequestInfo?{
        didSet{
            let result = calculateBetweenDays()
            countLabel.text = result.count
            trail.text = result.label
        }
    }
    
    let countLabel:UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countView:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.blue
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let trail:UILabel = {
        let label = UILabel()
        label.text = "Week day"
        label.textColor = CustomColor.ash
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupInLoad() {
        
        addSubview(countView)
        countView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        countView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        countView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        countView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        countView.addSubview(countLabel)
        countLabel.leftAnchor.constraint(equalTo: countView.leftAnchor, constant: 8).isActive = true
        countLabel.rightAnchor.constraint(equalTo: countView.rightAnchor, constant: -8).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor).isActive = true
        
        addSubview(trail)
        trail.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        trail.leftAnchor.constraint(equalTo: countView.rightAnchor, constant: 8).isActive = true
        
        
    }
    
    fileprivate func calculateBetweenDays()->(count:String,label:String){
        
        guard let date1 = setRequestInfo?.leaveBeganDay else {return ("0","Week days")}
        guard let date2 = setRequestInfo?.workReturnDay else {return ("0","Week days")}
        let daysBetween = date1.range(between: date2)
        
        guard daysBetween > 1 else{
            return ("\(daysBetween)","Week days")
        }
        
        return ("\(daysBetween)","Week day")
    }
}
