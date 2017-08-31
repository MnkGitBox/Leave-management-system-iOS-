//
//  CoreDataRequest.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import CoreData

class LeaveRequest{
    
    class func fetchLeaves()throws->[LeaveType]{
        
        var leaveTypes = [LeaveType]()
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else{
            return []
        }
        
        do {
            leaveTypes = try context.fetch(LeaveType.fetchRequest())
        } catch let err {
            throw err
        }
        
        return leaveTypes
        
    }
    class func fetchLeave(using leaveId:String)->LeaveType?{
        
        var leaveTypes = [LeaveType]()
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return nil
        }
        
        let request:NSFetchRequest<LeaveType> = LeaveType.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ ", leaveId)
        
        do {
            leaveTypes = try context.fetch(request)
        } catch let err {
            print("leaveType Fetch Using ID err: ",err.localizedDescription)
        }
        
        return leaveTypes[0]
        
        
        
    }
    
    
    
}
