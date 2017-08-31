//
//  Detail_Request.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-24.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FireRequestInfo{
    
    
    class func fetchLeaveInfoForType(complete:@escaping (InfoOb)->Void){
        
        let fireDB = FIRDatabase.database()
        
        guard let userID = FIRAuth.auth()?.currentUser?.uid else{return}
        
        let userLeaveDetails = fireDB.reference(withPath: DBPath.user_leave_details)
        let details = fireDB.reference(withPath: DBPath.details)
        userLeaveDetails.child(userID).observe(.childAdded, with: { (snapshot1) in
            
            
            userLeaveDetails.child("\(userID)/\(snapshot1.key)").observe(.childAdded, with: { (snapshot2) in
                
                
                details.child(snapshot2.key).observe(.value, with: { (snapShot3) in
                    
                    
                    if var leaveInfo = snapShot3.value as? [String:Any]{
                        leaveInfo[dbAttributename.id] = snapShot3.key
                        let infoOb = InfoOb(infoDic: leaveInfo)
                        complete(infoOb)
                    }
                    
                }){ (err) in
                    print("fetchLeaveInfoForType: ", err.localizedDescription)
                }
                
                
                
            }){ (err) in
                print("fetchLeaveInfoForType2: ", err.localizedDescription)
            }
            
        }, withCancel: { (error) in
            
            print("FireRequestInfo--fetchLeaveInfoForTypeErr: ",error.localizedDescription)
            
        })
        
        
    }
    
    
    
    
}
