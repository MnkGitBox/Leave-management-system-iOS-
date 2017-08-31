//
//  LeaveTypeInfo.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-11.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation


struct LeaveTypeInfo {
    
    let name:String
    let id:String
    let profileImg:String?
    let descrip:String?
    let reserved:Int16
    let period:String?
    let leaveType:LeaveType
    var remain:Int16
    var accLeaveDays:Int16 = 0
    var pendingLeaveDays:Int16 = 0
    
    
    
    init(leaveType:LeaveType) {
        
        self.leaveType = leaveType
        name = leaveType.name!
        id = leaveType.id!
        profileImg = leaveType.profile_img
        descrip = leaveType.descri
        reserved = leaveType.reserved
        period = leaveType.period
        remain = leaveType.reserved
        
        getInfoDetails()
        
        
    }
    
    mutating func getInfoDetails(){
        
        guard let leaveInfo = leaveType.info else{return}
        
        for ob in leaveInfo.allObjects{
            
            guard let info = ob as? Info else{return}
            
            if info.currState == InfoCurrentState.accept{
                
                accLeaveDays += info.leaveDays
                
            }
            if info.currState == InfoCurrentState.pending{
                
                pendingLeaveDays += info.leaveDays
                
            }
            
        }
        
        remain -= (accLeaveDays + pendingLeaveDays)
        
    }
    
    func setAndReturnLeavesInfo()->[String:[InfoOb]]{
        
        var acceptLeave:[InfoOb] = []
        var rejectLeave:[InfoOb] = []
        var pendingLeave:[InfoOb] = []
        var compactDic:[String:[InfoOb]] = [:]
        
        guard let typeInfo = leaveType.info else{return compactDic}
        
        for ob in typeInfo.allObjects{
            
            
            guard let infoCoreOb = ob as? Info else{print("coredata conversion err");return compactDic}
            
            var infoOb = InfoOb(InfoCoOb: infoCoreOb)
            infoOb.getDateRange()
            
            if infoCoreOb.currState == InfoCurrentState.accept{
                
                acceptLeave.append(infoOb)
                
            }
            if infoCoreOb.currState == InfoCurrentState.pending{
                
                pendingLeave.append(infoOb)
                
            }
            if infoCoreOb.currState == InfoCurrentState.reject{
                
                rejectLeave.append(infoOb)
                
            }
            
        }
        
        if acceptLeave.count > 0{
            
            compactDic[LeaveCurrentStateHeadingName.accept] = acceptLeave
            
        }
        if pendingLeave.count > 0{
            
            compactDic[LeaveCurrentStateHeadingName.pending] = pendingLeave
            
        }
        if rejectLeave.count > 0{
            
            compactDic[LeaveCurrentStateHeadingName.reject] = rejectLeave
            
        }
        
        
        return compactDic
        
    }
    
    
}

struct LeaveCurrentStateHeadingName {
    
    static let accept = "accept leaves"
    static let pending = "pending leaves"
    static let reject = "reject leaves"
    
}




