//
//  SelectedDaysTVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-02.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class SelectedDaysTVCell: SummaryBaseTVCell {
    
    override var setRequestInfo:LeaveRequestInfo?{
        
        didSet{
            
            guard let beginDate = setRequestInfo?.leaveBeganDay.toString(using: "dd, MMM yyyy")else{return}
            guard let returnDate = setRequestInfo?.workReturnDay.toString(using: "dd, MMM yyyy")else{return}
            
            dateBeganToReturn.text = beginDate + " - " + returnDate
            
        }
        
    }
    
    
    
    let dateBeganToReturn:UILabel = {
        
        let label = UILabel()
        label.text = "Thu, 02 January 2017"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.textColor = CustomColor.ash
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let imgView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "date_ico")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func setupInLoad() {
        
        addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(dateBeganToReturn)
        dateBeganToReturn.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 8).isActive = true
        dateBeganToReturn.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        dateBeganToReturn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
}
