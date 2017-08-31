//
//  Leave.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-30.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import CoreData

class LeaveType: NSManagedObject {
    
    
    class func createLeave(of leaveOB:(key:String,value:LeaveTypeOb),in context:NSManagedObjectContext)throws{
        
        
        do{
            
            let isTypeEmpty = try isLeaveEmpty(for: leaveOB.key, in: context)
            
            guard isTypeEmpty else {return}
            
            
        }catch let err{
            
            throw err
            
        }
        
        
        let type = LeaveType(context: context)
        
        type.id = leaveOB.key
        type.name = leaveOB.value.name
        type.profile_img = leaveOB.value.ico
        type.descri = leaveOB.value.descrip
        type.period = leaveOB.value.period
        type.reserved = leaveOB.value.reserved as! Int16
        type.remain = leaveOB.value.reserved as! Int16
        
    }
    
    
    class func checkAndGetLeave(for id:String,in context:NSManagedObjectContext)throws->LeaveType?{
        
        let request:NSFetchRequest<LeaveType> = LeaveType.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            
            let match = try context.fetch(request)
            guard match.count != 0 else {
                return nil
            }
            guard match.count == 1 else {
                fatalError("LeaveType--checkAndGetLeave--DataBaseInconsistanceErr")
            }
            
            return match[0]
            
        } catch let err{
            throw err
        }
        
    }
    
    
    static func isLeaveEmpty(for id:String, in context:NSManagedObjectContext)throws->Bool{
        
        
        let request:NSFetchRequest<LeaveType> = LeaveType.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do{
            
            let match = try context.fetch(request)
            
            guard match.count == 0 else {return false}
            return true
            
        }catch let err{
            
            throw err
            
        }
        
        
    }
    
    
}
