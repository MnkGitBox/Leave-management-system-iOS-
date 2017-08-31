//
//  Signin Request.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation

import FirebaseAuth
import FirebaseDatabase

class SigninOutRequest{
    
    
    class func signin(user userName:String,for password:String,completion:@escaping ((Bool,String?))->Void){
        
        var err:String?
        
        FIRAuth.auth()?.signIn(withEmail: userName, password: password, completion: { (user, error) in
            
            guard error == nil else{
                err = error?.localizedDescription
                completion((false, err))
                return
            }
            
            completion((true, err))
            
        })
        
        
    }
    
    
    class func signout()->(isSignout:Bool,err:String?){
        
        var isSignOut = false
        var err:String?
        
        do {
            
            try FIRAuth.auth()?.signOut()
            
            
        } catch let error {
            
            err = error.localizedDescription
            return (isSignOut,err)
        }
        isSignOut = true
        return (isSignOut,err)
    }
    
    class func getCurrentAuthUsrDetails(using uid:String, userInfo:@escaping (User)->Void){
        
        let refUsr = FIRDatabase.database().reference(withPath: DBPath.users+"/"+uid)
        refUsr.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let info = snapshot.value as? [String:Any]{
                let currUsr = User(info)
                userInfo(currUsr)
            }
            
        })
        
    }
    
}
