//
//  User Request.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-19.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FireRequestUsr{
    
    class func details(using usrId:String, userData:@escaping (User)->Void){
        let ref = FIRDatabase.database().reference(withPath: "users/"+usrId)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let usrdata = snapshot.value as? [String:Any]{
                userData(User(usrdata))
            }
            
        }) { (err) in
            print("FireRequestUsr: ", err.localizedDescription)
        }
        
    }
    
}
