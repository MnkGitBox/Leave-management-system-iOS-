//
//  PostLeaveRequest.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-14.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PostLeaveRequest{
    
    class func performNew(to info:[String:Any], getErr:@escaping (String?)->Void){
        
        let refDBInfo = FIRDatabase.database().reference(withPath: DBPath.details).childByAutoId()
        
        refDBInfo.updateChildValues(info)
        
        let leaveTypeID = info[dbAttributename.leaveTypeID] as! String
        let userID = info[dbAttributename.userID] as! String
        let newRequestKey = refDBInfo.key
        let leaveState = info[dbAttributename.currState] as! String
        
        let refDBUserLeaveDetails = FIRDatabase.database().reference(withPath: DBPath.user_leave_details + "/\(userID)/\(leaveTypeID)")
        
        let shortInfo = [newRequestKey:leaveState]
        
        var timer:Timer?
        timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: false, block: { (timer) in
            timer.invalidate()
            getErr("connection err, request will be sent automatically when connection available")
            
        })
        
        refDBUserLeaveDetails.updateChildValues(shortInfo) { (err, ref) in
            
            if let errMsg = err{
                timer?.invalidate()
                getErr(errMsg.localizedDescription)
                
            }else{
                timer?.invalidate()
                getErr(err?.localizedDescription)
                
            }
        }
        
        let connectedRef = FIRDatabase.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { (snapshot) in
            
            guard let state = snapshot.value as? Bool else{return}
            
            if !state{
                timer?.invalidate()
                getErr("no connection, request will be sent automatically when connection available")
            }
            
        })
        
        
        
    }
    
    
    
}

