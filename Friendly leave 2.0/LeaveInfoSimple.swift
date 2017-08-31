//
//  LeaveInfoSimple.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-22.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation

struct LeaveInfoSimple{
    
    var typeName:String
    var currState:String
    var beganDate:Date
    var returnDate:Date
    var reqDate:Date
    var rejDate:Date?
    var isPending = false
    var isAccept = false
    var isReject = false
    var text:(action:String, tail:String)?
    var availability:leaveAvailabilityKey = .none
    var icoName:String?
    var actionDate:Date = Date()
    var infoOb:InfoOb!
    
    init(info:InfoOb, type:LeaveType,_ availability:leaveAvailabilityKey = .none) {
        
        self.typeName = type.name!
        self.infoOb = info
        self.currState = info.currentState
        
        guard let beganD = info.beginDate.convertToDate()else{fatalError()}
        guard let returnD = info.returnDate.convertToDate()else{fatalError()}
        guard let reqD = info.reqDate.convertToDate()else{fatalError()}
        self.beganDate = beganD
        self.returnDate = returnD
        self.reqDate = reqD
        if let rejD = info.rejDate?.convertToDate(){
            self.rejDate = rejD
        }
        self.icoName = type.profile_img
        self.availability = availability
        switch info.currentState {
        case InfoCurrentState.accept:
            isAccept = true
            if self.availability == .inleave{
                text = ("started", "ago")
                actionDate = returnDate
            }else if self.availability == .untouch{
                text = ("more", "to start")
                actionDate = beganDate
            }
            
        case InfoCurrentState.pending:
            isPending = true
            text = ("requested", "ago")
            actionDate = reqDate
            
        case InfoCurrentState.reject:
            isReject = true
            text = ("rejected", "ago")
            if let date = rejDate{
                actionDate = date
            }
        default:break
        }
        
    }
    
    mutating func findCurrState(in state:String){
        
        switch state {
        case InfoCurrentState.accept:
            isAccept = true
            if availability == .inleave{
                text = ("started", "remain")
                actionDate = beganDate
            }else if availability == .untouch{
                text = ("will start", "more")
                actionDate = beganDate
            }
            
        case InfoCurrentState.pending:
            isPending = true
            text = ("requested", "ago")
            actionDate = reqDate
            
        case InfoCurrentState.reject:
            isReject = true
            text = ("rejected", "ago")
            if let date = rejDate{
                actionDate = date
            }
        default:break
        }
        
    }
    
}
