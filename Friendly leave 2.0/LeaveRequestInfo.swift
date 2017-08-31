//
//  LeaveRequestInfo.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

struct LeaveRequestInfo{
    
    var leaveType:LeaveTypeInfo
    var leaveTypeID:String
    var userID:String
    var leaveBeganDay:Date
    var workReturnDay:Date
    var reason:String
    var reqDate:NSNumber
    var reactionTime:NSNumber!
    var isChecked:Bool
    
    init(requestInfo:[String:Any]) {
        
        leaveType  = requestInfo[dbAttributename.leaveType] as! LeaveTypeInfo
        leaveTypeID = leaveType.id
        leaveBeganDay = requestInfo[dbAttributename.beginDate] as! Date
        workReturnDay = requestInfo[dbAttributename.returnDate] as! Date
        reason = requestInfo[dbAttributename.reqReason] as! String
        
        let today = Date()
        reqDate = today.timeIntervalSince1970 as NSNumber
        userID = requestInfo[dbAttributename.userID] as! String
        isChecked = requestInfo[dbAttributename.isChecked] as! Bool
        
    }
    
    func convertToDic()->[String:Any]{
        
        var returnDic:[String:Any] = [:]
        
        //        let beginDate = from.toDate(ofFormat: "E, dd MMM yyyy")
        //        let returnDate = to.toDate(ofFormat: "E, dd MMM yyyy")
        
        returnDic[dbAttributename.leaveTypeID] = leaveTypeID
        returnDic[dbAttributename.userID] = userID
        returnDic[dbAttributename.beginDate] = leaveBeganDay.timeIntervalSince1970 as NSNumber
        returnDic[dbAttributename.returnDate] = workReturnDay.timeIntervalSince1970 as NSNumber
        returnDic[dbAttributename.reqReason] = reason
        returnDic[dbAttributename.reqDate] = reqDate
        returnDic[dbAttributename.currState] = InfoCurrentState.pending
        returnDic[dbAttributename.reactionTime] = reactionTime
        returnDic[dbAttributename.isChecked] = isChecked
        
        return returnDic
        
    }
    
}

