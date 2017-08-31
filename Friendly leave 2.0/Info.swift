//
//  Info.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-11.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import CoreData

class Info: NSManagedObject {
    
    class func createOrUpdateLeaveInfoAndSetToType(using infoOb:InfoOb, in context:NSManagedObjectContext){
        
        guard let type = try? LeaveType.checkAndGetLeave(for: infoOb.leaveID, in: context) else {
            fatalError("Info--LeaveType--checkAndGetLeaveErr")
        }
        
        guard let leaveType = type else {
            fatalError("Info--type-optionaunwrappingErr")
        }
        
        guard let isExitInfo = try? checkIsExitInfo(id: infoOb.id, in: context) else {
            fatalError("Info--checkIsExitInfo-err")
        }
        
        
        
        
        if let info = isExitInfo{
            
            
            info.setValue(infoOb.currentState, forKey: dbAttributename.currState)
            info.setValue(infoOb.beginDate, forKey: dbAttributename.beginDate)
            info.setValue(infoOb.returnDate, forKey: dbAttributename.returnDate)
            info.setValue(infoOb.rejReason, forKey: dbAttributename.rejReason)
            info.setValue(infoOb.rejUserID, forKey: dbAttributename.rejUserID)
            info.setValue(infoOb.accUserID, forKey: dbAttributename.accUserID)
            info.setValue(Int16(infoOb.leaveDays), forKey: dbAttributename.leaveDays)
            info.setValue(infoOb.reactionTime, forKey: dbAttributename.reactionTime)
            info.setValue(infoOb.isChecked, forKey: dbAttributename.isChecked)
            if let rejDate = infoOb.rejDate{
                info.setValue(rejDate, forKey: dbAttributename.rejDate)
            }
            leaveType.removeFromInfo(info)
            leaveType.addToInfo(info)
            
            
        }else{
            
            
            let info = Info(context: context)
            
            info.id = infoOb.id
            info.leaveTypeID = infoOb.leaveID
            info.currState = infoOb.currentState
            info.beginDate = infoOb.beginDate.int64Value
            info.returnDate = infoOb.returnDate.int64Value
            info.reqReason = infoOb.reqReason
            info.rejReason = infoOb.rejReason
            info.reqDate =  infoOb.reqDate.int64Value
            info.rejUserID = infoOb.rejUserID
            info.accUserID = infoOb.accUserID
            info.leaveDays = Int16(infoOb.leaveDays)
            info.userID = infoOb.userID
            info.reactionTime = infoOb.reactionTime.floatValue
            info.isChecked = infoOb.isChecked
            if let rejDate = infoOb.rejDate{
                info.rejDate = rejDate.int64Value
            }
            leaveType.addToInfo(info)
            
        }
        
        
    }
    
    
    static func checkIsExitInfo(id:String,in context:NSManagedObjectContext)throws->Info?{
        
        let request:NSFetchRequest<Info> = Info.fetchRequest()
        
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let infoObs = try context.fetch(request)
            
            guard infoObs.count != 0 else { return nil}
            
            guard infoObs.count == 1 else {
                
                fatalError("Info--checkIsExitInfo--infoDBIsinconsistanceErr")
            }
            
            return infoObs[0]
            
        } catch let err {
            throw err
        }
        
    }
    
    
}
