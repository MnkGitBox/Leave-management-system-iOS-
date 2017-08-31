//
//  User.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

struct User{
    
    var name:String?
    var jobTitle:String?
    var imgUrl:String?
    var defartment:String?
    
    init(_ info:[String:Any]) {
        
        self.name = info[dbAttributename.userNameFull] as? String
        self.jobTitle = info[dbAttributename.jobTitle] as? String
        self.imgUrl = info[dbAttributename.proPicURL] as? String
        self.defartment = info[dbAttributename.department] as? String
        
    }
    
}
