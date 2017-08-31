//
//  Leave_Request.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-23.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FireRequestLeave{
    
    //MARK: - Request to Leaves and Get Specific Leave by Key
    class func leave(from key:String,completion:@escaping (LeaveTypeOb)->Void){
        
        let ref = FIRDatabase.database().reference(withPath:DBPath.leaves).child(key)
        
        //        ref.observeSingleEvent(of: .value, with: { (snapshot) in
        //
        //            guard let leaveDic = snapshot.value as? [String:Any] else{return}
        //
        //            let leave = LeaveTypeOb(LeaveType: leaveDic)
        //
        //            completion(leave)
        //
        //        },{ (err) in
        //
        //        })
        //
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let leaveDic = snapshot.value as? [String:Any] else{return}
            
            let leave = LeaveTypeOb(LeaveType: leaveDic)
            
            completion(leave)
            
        }) { (err) in
            print("FireRequestLeave", err.localizedDescription)
        }
        
    }
    
    
    
    class func requestLeave(completion:@escaping ([String:LeaveTypeOb])->Void){
        
        var leaves:[String:LeaveTypeOb] = [:]
        let dBRef = FIRDatabase.database().reference(withPath: DBPath.leaves)
        dBRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for object in snapshot.children{
                
                let ob = object as! FIRDataSnapshot
                let leave = ob.value as! [String:Any]
                let leaveOb = LeaveTypeOb(LeaveType: leave)
                leaves[ob.key] = leaveOb
            }
            
            completion(leaves)
            
        }){ (err) in
            print("requestLeave: ", err.localizedDescription)
        }
    }
    
    
    
    
}

