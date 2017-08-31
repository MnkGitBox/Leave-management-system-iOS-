//
//  HotInfo.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-22.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation

struct HotInfo{
    
    var currHot:LeaveInfoSimple?
    
    init(){}
    
    mutating func check(infoIn leaveTypeOb:LeaveTypeInfo){
        
        let leaveCompactDic = leaveTypeOb.setAndReturnLeavesInfo()
        
        checkIsAcceptAvailable(leaveCompactDic, leaveTypeOb)
        checkIsPendingAvailabe(leaveCompactDic, leaveTypeOb)
        checkIsRejectAvailabe(leaveCompactDic, leaveTypeOb)
        
    }
    
    //MARK: - CHECK IS AVAILABLE HOT LEAVE
    fileprivate mutating func checkIsAcceptAvailable(_ leaveCompactDic: [String : [InfoOb]], _ leaveTypeOb: LeaveTypeInfo) {
        //Check and set if accept leave found as hot leave
        if let acceptInfos = leaveCompactDic[LeaveCurrentStateHeadingName.accept]{
            
            for info in acceptInfos{
                guard let beginDate = info.beginDate.convertToDate()else{fatalError()}
                guard let returnDate = info.returnDate.convertToDate()else{fatalError()}
                
                let availability = info.checkLeave(startDate: beginDate, and: returnDate, equalGreaterOrLessTo: Date())
                
                switch availability {
                case .inleave:
                    self.currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType,.inleave )
                    return
                case .untouch:
                    guard let currSelected = currHot else{
                        self.currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType, .untouch)
                        break
                    }
                    
                    //to-do: check break here.....
                    
                    guard currSelected.isAccept else{break}
                    guard currSelected.beganDate > beginDate else{break}
                    self.currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType, .untouch)
                default:break
                }
                
            }
        }
    }
    
    fileprivate mutating func checkIsPendingAvailabe(_ leaveCompactDic: [String : [InfoOb]], _ leaveTypeOb: LeaveTypeInfo){
        
        //to-do: check there may no need to second check...or second check outside the if statement..
        if let currSelected = currHot{
            guard !currSelected.isAccept else{return}
        }
        
        
        //Check and set if pending leave found as hot leave
        guard let pendingInfos = leaveCompactDic[LeaveCurrentStateHeadingName.pending]else{return}
        
        for info in pendingInfos{
            
            guard let hotSelected = currHot else{
                currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType)
                continue
            }
            
            guard hotSelected.isPending else{
                currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType)
                continue
            }
            
            guard let reqDate = info.reqDate.convertToDate()else{fatalError()}
            
            guard hotSelected.reqDate < reqDate else{continue}
            currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType)
            
            
        }
        
    }
    
    fileprivate mutating func checkIsRejectAvailabe(_ leaveCompactDic: [String : [InfoOb]], _ leaveTypeOb: LeaveTypeInfo) {
        
        //to-do: check there may no need to second check...or second check outside the if statement..
        if let currSelected = currHot{
            guard !currSelected.isAccept else{return}
            guard !currSelected.isPending else{return}
        }
        //Check and set if accept leave found as hot leave
        guard let rejectInfos = leaveCompactDic[LeaveCurrentStateHeadingName.reject]else{return}
        for info in rejectInfos{
            
            guard let hotSelected = currHot else{
                currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType)
                continue
            }
            
            let rejDayNumber = info.rejDate!
            guard let rejDate = rejDayNumber.convertToDate()else{fatalError()}
            
            //            to-do check there guard is may be not suatable there..and greater than sign check is it correct..
            guard hotSelected.rejDate! > rejDate else{continue}
            currHot = LeaveInfoSimple(info: info, type: leaveTypeOb.leaveType)
            
        }
        
    }
    
    
    
}
