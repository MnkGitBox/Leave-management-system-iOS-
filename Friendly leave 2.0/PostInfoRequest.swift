//
//  PostInfoRequest.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import FirebaseDatabase
import UIKit

class FirPostInfoRequest{
    
    class func writeIsChecked(state value:Bool, inInfoID iD:String){
        
        
        let ref = FIRDatabase.database().reference(withPath: DBPath.details + "/" + iD)
        
        let values = [dbAttributename.isChecked:value]
        
        ref.updateChildValues(values)
        
    }
    
    
    
}
