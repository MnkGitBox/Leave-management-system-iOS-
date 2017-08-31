
//
//  Date Extension.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-30.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation
import JTAppleCalendar

extension String{
    
    func toDate(ofFormat format:String)->Date{
    
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar.current
        
        return formatter.date(from: self)!
 
    }

}
extension Date{
    
    func toString(using formatString:String)->String?{
        
        let format = DateFormatter()
        format.dateFormat = formatString
        format.calendar = Calendar.current
        
        return format.string(from: self)
    
        
    }
    
    func isWeek()->Bool{
        
        let format = DateFormatter()
        format.calendar = Calendar.current
        format.dateFormat = "EEEE"
        let dateOfWeek = format.string(from: self)
        
        guard dateOfWeek != "Sunday" else{return false}
        
        return true
        
    }
    
    func shortDate()->String{
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
        
    }
    
    func dateOfMonth()->String{
        
        let formattter = DateFormatter()
        formattter.dateFormat = "dd"
        return formattter.string(from: self)
        
    }
    func dateOfWeek()->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
        
    }
    func year()->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y"
        return formatter.string(from: self)
    }
    func month()->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    func range(between to:Date)->Int{
        
        let calender = Calendar.current
        let start = calender.startOfDay(for: self)
        let end = calender.startOfDay(for: to)
        
        let component = calender.dateComponents([.weekday], from: start, to: end)
        guard let count = component.weekday else{return 0}
        return  count
    }
    
    func rangeOfDays(between to:Date)->[Date]{
        
        var arrayDate:[Date] = []
        
        let calender = Calendar.current
        var start = self
        let end = to
        
        while start < end {
            
            arrayDate.append(start)
            start = calender.date(byAdding: .day, value: 1, to: start)!
            
        }
        
        return arrayDate
        
    }
    
    func getTimeWithCorrectDiscription(to end:Date)->(component:Int?,description:String){
        

        let currCalender = Calendar.current
        var disString:String
        
        let component = currCalender.dateComponents([.weekOfYear,.month,.day,.hour,.minute], from: self, to: end)
        
        guard component.month == 0 else {
            var month = component.month!
            disString =  month > 1 ? "months" : "month"
            if month < 1 { month *= -1 }
            return (month,disString)
        }
        guard component.weekOfYear == 0 else {
            var week = component.weekOfYear!
            disString =  week > 1 ? "weeks" : "week"
            if week < 1 { week *= -1 }
            return (week,disString)
        }
        guard component.day == 0 else {
            var day = component.day!
            disString =  day > 1 ? "days" : "day"
            if day < 1 { day *= -1 }
            return (day,disString)
        }
        guard component.hour == 0 else {
            var hour = component.hour!
            disString =  hour > 1 ? "ours" : "our"
            if hour < 1 { hour *= -1 }
            return (hour,disString)
        }
        guard component.minute == 0 else {
            var minute = component.minute!
            disString =  minute > 1 ? "mins" : "min"
             if minute < 1 { minute *= -1 }
            return (minute,disString)
        }
        
        disString = "now"
        
        return (nil,disString)

    }
    
    func getFullTimeDescription(to end:Date)->(comp1:Comp,comp2:Comp,comp3:Comp){
            
            let calender = Calendar.current
            let component = calender.dateComponents([.month,.weekOfMonth,.day,.hour,.minute], from: self, to: end)
            
            let month = component.month ?? 0
            let week = component.weekOfMonth ?? 0
            let day = component.day ?? 0
            let hour = component.hour ?? 0
            let minite = component.minute ?? 0
            
            if month == 0 && week == 0{
                
                return ( Comp(type: .day, value: day), Comp(type: .hour, value: hour), Comp(type: .minute, value: minite))
                
            }else{
                
                return (Comp(type: .month, value: month), Comp(type: .week, value: week), Comp(type: .day, value: day))
                
            }
            
        }
    
    func startDayOf(timePeriod period:TimePeriod)->Date{
        
        var component = DateComponents()
        let calender = Calendar.current
        
        switch period {
        case .month:
            component = calender.dateComponents([.year, .month], from: self)
        case .year:
            component = calender.dateComponents([.year], from: self)
        case .allTime:
            component = calender.dateComponents([.year, .month], from: self)
        }
        
        guard let start = Calendar.current.date(from: component) else{
            fatalError("SelectDaysViewController--calenderStartDate--getValueFromCompErr")
        }
        return start
        
    }
    
    func endDateOf(timePeriod period:TimePeriod)->Date{
        
        let calender = Calendar.current
        var addDayComponent = DateComponents()
        var currDayComponent = DateComponents()
        currDayComponent = calender.dateComponents([.month], from: self)
        let remainMonth = 12 - currDayComponent.month!
        
        addDayComponent.day = -1
        
        switch period {
        case .month:
            addDayComponent.month = 1
        case .year:
            addDayComponent.month = remainMonth + 1
        case .allTime:
            addDayComponent.month = remainMonth
            addDayComponent.year = 5
        }
        
        guard let end = calender.date(byAdding: addDayComponent, to: self) else{
            fatalError("SelectDaysViewController--calenderEndDate--endDayOptionaBindingErr")
        }
        
        return end
        
        
    }
    
    

}
