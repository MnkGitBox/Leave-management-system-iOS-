//
//  ProfileTableViewCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var respondedUsrId:String?{
        didSet{
            guard let usrId = respondedUsrId else {return}
            FireRequestUsr.details(using: usrId) { [weak self]userData in
                self?.personName.text = userData.name
                if let job = userData.jobTitle, let department = userData.defartment{
                    self?.personOccupation.text = job + ", " + department
                }
                self?.imgUrl = userData.imgUrl
            }
        }
    }
    
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personOccupation: UILabel!
    var imgUrl:String?{
        didSet{
            profileImg.image(from: imgUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //configure img view
        profileImg.layer.cornerRadius = 25
        profileImg.layer.masksToBounds = true
        
    }
}


