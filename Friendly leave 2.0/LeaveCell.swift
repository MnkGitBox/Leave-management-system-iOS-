//
//  LeaveCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class LeaveCell: UITableViewCell {
    
    
    @IBOutlet weak var availabel: UIView!
    @IBOutlet weak var leaveIcoIV: UIImageView!
    @IBOutlet weak var leaveName: UILabel!
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var icoContainerView: UIView!
    
    
    var leaveTypeInfoOb:LeaveTypeInfo?{
        
        didSet{
            
            guard let infoOb = leaveTypeInfoOb else{return}
            
            leaveName.text = infoOb.name.capitalized
            discription.text = infoOb.descrip
            
            guard let imgName = infoOb.profileImg else {return}
            leaveIcoIV.image = UIImage(named: imgName)
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leaveIcoIV.layer.cornerRadius = 5
        leaveIcoIV.clipsToBounds = true
        
        selectionStyle = .none
        availabel.backgroundColor = CustomColor.red
        backgroundColor = .white
        
        
    }
    
    
}








