//
//  LeaveNameTVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-02.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class LeaveNameTVCell: SummaryBaseTVCell {
    
    override var setRequestInfo: LeaveRequestInfo?{
        
        didSet{
            
            leaveName.text = setRequestInfo?.leaveType.name.capitalized
            guard let iconName = setRequestInfo?.leaveType.profileImg else {return}
            leaveIconIV.image = UIImage(named: iconName)
        }
        
    }
    
    let leaveIcoContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let leaveIconIV:UIImageView = {
        
        let imgv = UIImageView()
        imgv.image = #imageLiteral(resourceName: "default_ico")
        imgv.contentMode = .scaleAspectFit
        imgv.layer.cornerRadius = 25
        imgv.layer.borderColor = CustomColor.whiteCream.cgColor
        imgv.layer.borderWidth = 1
        imgv.clipsToBounds = true
        //        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
        
    }()
    
    let leaveName:UILabel = {
        
        let label = UILabel()
        label.text = "Default Leave"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override func setupInLoad() {
        
        backgroundColor = CustomColor.darkGreen
        leaveIconIV.frame = CGRect(x:0, y:0, width: 50, height: 50)
        leaveIcoContainer.addSubview(leaveIconIV)
        addSubview(leaveIcoContainer)
        leaveIcoContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        leaveIcoContainer.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        leaveIcoContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leaveIcoContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(leaveName)
        leaveName.topAnchor.constraint(equalTo: leaveIcoContainer.bottomAnchor, constant:16).isActive = true
        leaveName.centerXAnchor.constraint(equalTo: leaveIcoContainer.centerXAnchor).isActive = true
        leaveName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        
    }
    
}
