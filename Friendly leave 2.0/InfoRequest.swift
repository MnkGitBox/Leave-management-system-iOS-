//
//  InfoRequest.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import CoreData
import UIKit

class CoreInfoRequest{
    
    class func writeIsChecked(inInfoOb infoOb:InfoOb){
        
        let container:NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        var infoOb = infoOb
        infoOb.isChecked = true
        
        if let context = container?.viewContext{
            
            Info.createOrUpdateLeaveInfoAndSetToType(using: infoOb, in: context)
            
        }
        
    }
    
    class func getInfoIsNotChecked()->Int{
        
        let container:NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        var infos = [Info]()
        
        let request:NSFetchRequest<Info> = Info.fetchRequest()
        request.predicate = NSPredicate(format: "isChecked == %@", false as CVarArg)
        
        if let context = container?.viewContext{
            
            do {
                infos = try context.fetch(request)
            } catch let err {
                
                print("CoreInfoRequest--getInfoIsNotChecked--err",err.localizedDescription)
                
            }
            
            
        }
        
        return infos.count
    }
    
    
}



