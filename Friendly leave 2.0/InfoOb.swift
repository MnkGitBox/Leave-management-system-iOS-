//
//  InfoOb.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-13.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation

struct InfoOb {
    
    var id:String
    var leaveID:String
    var userID:String
    var currentState:String
    var rejReason:String?
    var reqReason:String?
    var beginDate:NSNumber
    var returnDate:NSNumber
    var reqDate:NSNumber
    var rejUserID:String?
    var accUserID:String?
    var leaveDays = 0
    var rejDate:NSNumber?
    var reactionTime:NSNumber
    var isChecked:Bool
    
    init(infoDic:[String:Any]) {
        
        id = infoDic[dbAttributename.id] as! String
        leaveID = infoDic[dbAttributename.leaveTypeID] as! String
        userID = infoDic[dbAttributename.userID] as! String
        currentState = infoDic[dbAttributename.currState] as! String
        rejReason = infoDic[dbAttributename.rejReason] as? String
        reqReason = infoDic[dbAttributename.reqReason] as? String
        beginDate = infoDic[dbAttributename.beginDate] as! NSNumber
        returnDate = infoDic[dbAttributename.returnDate] as! NSNumber
        reqDate = infoDic[dbAttributename.reqDate] as! NSNumber
        rejUserID = infoDic[dbAttributename.rejUserID] as? String
        accUserID = infoDic[dbAttributename.accUserID] as? String
        rejDate = infoDic[dbAttributename.rejDate] as? NSNumber
        reactionTime = infoDic[dbAttributename.reactionTime] as! NSNumber
        isChecked = infoDic[dbAttributename.isChecked] as! Bool
        
        getDateRange()
    }
    
    init(InfoCoOb:Info) {
        
        id = InfoCoOb.id!
        leaveID = InfoCoOb.leaveTypeID!
        userID = InfoCoOb.userID!
        currentState = InfoCoOb.currState!
        rejReason = InfoCoOb.rejReason
        reqReason = InfoCoOb.reqReason
        beginDate = InfoCoOb.beginDate as NSNumber
        returnDate = InfoCoOb.returnDate as NSNumber
        reqDate = InfoCoOb.reqDate as NSNumber
        rejUserID = InfoCoOb.rejUserID
        accUserID = InfoCoOb.accUserID
        rejDate = InfoCoOb.rejDate as NSNumber
        reactionTime = InfoCoOb.reactionTime as NSNumber
        isChecked = InfoCoOb.isChecked
        
        getDateRange()
    }
    
    
    mutating func getDateRange(){
        
        guard let start = beginDate.convertToDate()else{return}
        guard let end = returnDate.convertToDate()else{return}
        
        var weekDays:[Date] = []
        
        let days = start.rangeOfDays(between: end)
        
        for day in days{
            
            if day.isWeek(){
                
                weekDays.append(day)
            }
            
        }
        
        leaveDays = weekDays.count
        
    }
    
    //MARK: - Set Detail Object info to array....With DetailWithCellType. This include cell type,key for cell header string, value is cell values....this value is any..so we can send any object to array like dictionary
    
    func subInfoWithCellType()->[String:[DetailWithCellType]]{
        
        var compactSubInfoWithCellType:[String:[DetailWithCellType]] = [:]
        var requestInfo:[DetailWithCellType] = []
        var rejectInfo:[DetailWithCellType] = []
        
        if let beginDate = self.beginDate.convertToDate(), let returnDate = self.returnDate.convertToDate(){
            
            var valueDic:[ValuesKey:String] = [:]
            
            valueDic[.beginDate] = beginDate.toString(using: "dd MMM yyyy")
            valueDic[.returnDate] = returnDate.toString(using: "dd MMM yyyy")
            
            valueDic[.betweenDays] = String(beginDate.range(between:returnDate))
            
            if valueDic[.betweenDays] == "1"{
                
                valueDic[.dayOrDays] = "Day"
                
            }else{
                valueDic[.dayOrDays] = "Days"
            }
            
            requestInfo.append(DetailWithCellType(type: .doubleDate, key: CellHeader.days, value: valueDic))
        }
        
        if let reqReason = self.reqReason{
            requestInfo.append(DetailWithCellType(type: .reason, key: CellHeader.reason, value: reqReason))
        }
        
        
        
        if let date = self.reqDate.convertToDate(){
            
            var valueDic:[ValuesKey:Any] = [:]
            
            valueDic[.date] = date.toString(using: "E, dd MMMM yyyy")
            //            valueDic[.time] = date.toString(using: "h.mm a")
            
            requestInfo.append(DetailWithCellType(type: .dateTime, key: CellHeader.reqDate, value: valueDic))
            
        }
        
        
        
        if let rejReason = self.rejReason{
            rejectInfo.append(DetailWithCellType(type: .reason, key: CellHeader.rejReason, value: rejReason))
        }
        
        if self.rejDate != nil && self.rejDate != 0{
            if let rejDate = self.rejDate?.convertToDate(){
                
                var valueDic:[ValuesKey:Any] = [:]
                
                valueDic[.date] = rejDate.toString(using: "E, dd MMMM yyyy")
                
                rejectInfo.append(DetailWithCellType(type: .dateTime, key: CellHeader.rejdate, value: valueDic))
                
            }
        }
        
        if let rejPersonKey = self.rejUserID{
            rejectInfo.append(DetailWithCellType(type: .profile, key: CellHeader.rejPerson, value: rejPersonKey))
        }
        
        
        
        
        compactSubInfoWithCellType["reject"] = rejectInfo
        compactSubInfoWithCellType["request"] = requestInfo
        
        return compactSubInfoWithCellType
    }
    
    
    
    
    
    func checkLeave(startDate start:Date, and end:Date, equalGreaterOrLessTo today:Date)->leaveAvailabilityKey{
        
        
        let used = end < today
        let remain = start > today
        var using = false
        
        let dates = start.rangeOfDays(between: end)
        
        for date in dates{
            
            if today.shortDate() == date.shortDate(){
                
                using = true
                
            }
        }
        
        guard !used else{return leaveAvailabilityKey.touched}
        guard !remain else{return leaveAvailabilityKey.untouch}
        guard !using else{return leaveAvailabilityKey.inleave}
        return leaveAvailabilityKey.none
        
    }
    
    
    
    
}

extension InfoOb:Equatable{
    static func ==(lhs:InfoOb, rhs:InfoOb)->Bool{
        
        guard let lhsReqDate = lhs.reqDate.convertToDate()else{return false}
        guard let rhsReqDate = rhs.reqDate.convertToDate()else{return false}
        return (lhsReqDate) == (rhsReqDate)
    }
}

extension InfoOb:Comparable{
    static func <(lhs:InfoOb, rhs:InfoOb)->Bool{
        guard let lhsReqDate = lhs.reqDate.convertToDate()else{return false}
        guard let rhsReqDate = rhs.reqDate.convertToDate()else{return false}
        return lhsReqDate > rhsReqDate
    }
}



