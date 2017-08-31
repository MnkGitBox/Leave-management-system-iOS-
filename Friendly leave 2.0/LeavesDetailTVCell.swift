//
//  LeavesDetailTVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-06.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class LeavesDetailTVCell: UITableViewCell {
    
    let leaveImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "default_ico")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let leaveNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Leave Name"
        label.font = UIFont.systemFont(ofSize: 16.5, weight: UIFontWeightRegular)
        label.textColor = CustomColor.headingTxtColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leaveDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Used 0 Waiting"
        label.font = UIFont.systemFont(ofSize: 12.5)
        label.textColor = CustomColor.subtitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let leaveRemainNumberLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = CustomColor.turqueGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let leaveRemainDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Days left"
        label.font = UIFont.systemFont(ofSize: 12.5)
        label.textColor = CustomColor.subtitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let stackView:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.axis = .vertical
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let disclosureIndicator: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Disclosure Indicator_Black")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    var leaveTypeInfo:LeaveTypeInfo?{
        
        didSet{
            
            guard let typeWithInfo = leaveTypeInfo else {return}
            
            leaveNameLabel.text = typeWithInfo.name.capitalized
            
            if let imgName = typeWithInfo.profileImg{
                
                leaveImgView.image = UIImage(named: imgName)
                
            }
            
            leaveRemainNumberLabel.text = String(typeWithInfo.remain)
            
            let used = typeWithInfo.accLeaveDays
            let pending = typeWithInfo.pendingLeaveDays
            
            leaveDescriptionLabel.text = "\(used) Used \(pending) Waiting"
            
            
        }
        
        
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = CustomColor.cellBackground
        self.selectionStyle = .none
        
        stackView.addArrangedSubview(leaveRemainNumberLabel)
        stackView.addArrangedSubview(leaveRemainDescriptionLabel)
        
        
        self.addSubview(leaveImgView)
        leaveImgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        leaveImgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        leaveImgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        leaveImgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leaveImgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(leaveNameLabel)
        leaveNameLabel.leftAnchor.constraint(equalTo: leaveImgView.rightAnchor, constant: 16).isActive = true
        leaveNameLabel.topAnchor.constraint(equalTo: leaveImgView.topAnchor).isActive = true
        
        self.addSubview(leaveDescriptionLabel)
        leaveDescriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: leaveNameLabel.bottomAnchor, constant: 4).isActive = true
        leaveDescriptionLabel.leftAnchor.constraint(equalTo: leaveNameLabel.leftAnchor).isActive = true
        leaveDescriptionLabel.rightAnchor.constraint(equalTo: leaveNameLabel.rightAnchor).isActive = true
        
        
        self.addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leaveNameLabel.rightAnchor, constant: 8).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        self.addSubview(disclosureIndicator)
        disclosureIndicator.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 8).isActive = true
        disclosureIndicator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        disclosureIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        disclosureIndicator.heightAnchor.constraint(equalToConstant: 13).isActive = true
        disclosureIndicator.widthAnchor.constraint(equalToConstant: 9).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
