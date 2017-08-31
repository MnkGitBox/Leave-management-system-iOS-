//
//  Detail.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-22.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class Detail: NSObject {
    
//    var id:String?
//    var leave_id:String?
//    var uid:String?
//    var type:String?
//    var rej_reason:String?
//    var req_reason:String?
//    var from:NSNumber?
//    var to:NSNumber?
//    var req_date:NSNumber?
//    var rej_person:String?
//    var acc_person:String?
//    var dayCount = 0
//    
//    
//    
//    
//    func getDateRange(){
//        
//        guard let start = from?.convertToDate()else{return}
//        guard let end = to?.convertToDate()else{return}
//        
//        var weekDays:[Date] = []
//        
//        let days = start.rangeOfDays(between: end)
//        
//        for day in days{
//            
//            if day.isWeek(){
//                
//                weekDays.append(day)
//            }
//        
//        }
//        
//       dayCount = weekDays.count
//        
//    }
//    
//   
//    
//    
//    
//    
//
//    
////MARK: - Set Detail Object info to array....With DetailWithCellType. This include cell type,key for cell header string, value is cell values....this value is any..so we can send any object to array like dictionary
//    
//    func detailArray()->[DetailWithCellType]{
//        
//        var returnArray:[DetailWithCellType] = []
// 
//        if self.from == self.to{
//            
//            var valuesDic:[ValuesKey:String] = [:]
//            
//            if let date = self.from?.convertToDate(){
//                
//                valuesDic[.dateOfMonth] = date.dateOfMonth()
//                valuesDic[.dateOfWeek] = date.dateOfWeek()
//                valuesDic[.year] = date.year()
//                valuesDic[.month] = date.month()
//                
//                valuesDic[.betweenDays] = String(describing: self.from?.convertToDate()?.range(between: (self.to?.convertToDate())!))
//                valuesDic[.dayOrDays] = "Day"
//            }
//            
//            
//            returnArray.append(DetailWithCellType(type: .singleDate, key:"", value: valuesDic))
//            
//        }else{
//            
//            var valueDic:[ValuesKey:String] = [:]
//            
//            if let from = self.from?.convertToDate(), let to = self.to?.convertToDate(){
//                
//                valueDic[.dateOfWeekFrom]  = from.dateOfWeek()
//                valueDic[.dateOfMonthFrom] = from.dateOfMonth()
//                valueDic[.monthFrom] = from.month()
//                valueDic[.yearFrom] = from.year()
//                
//                valueDic[.dateOfWeekTo] = to.dateOfWeek()
//                valueDic[.dateOfMonthTo] = to.dateOfMonth()
//                valueDic[.monthTo] = to.month()
//                valueDic[.yearTo] = to.year()
//                
//                valueDic[.betweenDays] = String(from.range(between:to))
//                valueDic[.dayOrDays] = "Days"
//                
//            }
//            
//            returnArray.append(DetailWithCellType(type: .doubleDate, key: "", value: valueDic))
//        }
//        
//        
//        if let rejReason = self.rej_reason{
//            returnArray.append(DetailWithCellType(type: .reason, key: CellHeader.rejReason, value: rejReason))
//        }
//        
//        if let reqReason = self.req_reason{
//            returnArray.append(DetailWithCellType(type: .reason, key: CellHeader.reqReason, value: reqReason))
//        }
//        
//        if let reqDate = self.req_date{
//            
//            if let date = reqDate.convertToDate(){
//            
//                returnArray.append(DetailWithCellType(type: .state, key: CellHeader.reqDate, value: date.shortDate()))
//                
//            }
//        }
//        
//        
//        if self.type == DetailCatagory.accept{
//        
//            let today = Date()
//            if let from = self.from?.convertToDate(), let to = self.to?.convertToDate(){
//               
//                 let state = checkLeave(startDate: from, and: to, equalGreaterOrLessTo: today)
//                returnArray.append(DetailWithCellType(type: .state, key: CellHeader.availability, value: state))
//                
//            }
//            
//
//        }
//
//       return returnArray
//    }
//    
//    
//    
//    
//    fileprivate func checkLeave(startDate start:Date, and end:Date, equalGreaterOrLessTo today:Date)->String{
//    
//        
//        var returnState:String?
//        
//        let used = end < today
//        let remain = start > today
//        var using = false
//        
//        let dates = start.rangeOfDays(between: end)
//        
//        for date in dates{
//            
//            if today.shortDate() == date.shortDate(){
//                
//                using = true
//                
//            }
//        }
//        
//        if used{returnState = "used"}
//        if remain{returnState = "remain"}
//        if using{returnState = "using"}
//        
//        return returnState!
// 
//        
//    }
//    
//  
    
}





