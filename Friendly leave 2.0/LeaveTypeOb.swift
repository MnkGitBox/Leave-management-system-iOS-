//
//  Leave.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

struct LeaveTypeOb{
    
    var name:String
    var ico:String
    var descrip:String
    var reserved:NSNumber
    var period:String
    
    init(LeaveType:[String:Any]) {
        
        self.name = LeaveType["name"] as! String
        self.ico = LeaveType["profile_Img"] as! String
        self.descrip = LeaveType["descrip"] as! String
        self.reserved = LeaveType["reserved"] as! NSNumber
        self.period = LeaveType["period"] as! String
        
    }
    
    
}
