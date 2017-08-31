//
//  Dashboard Configuration .swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-16.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController{
    
    func findHotLeave(){
        DispatchQueue.global().async {
            
            guard let section = self.leaveTypeFetchResultController?.sections else{return}
            let numberOfObject = section[0].numberOfObjects
            var i = 0
            while i < numberOfObject {
                let indexPath = IndexPath(item: i, section: 0)
                guard let object = self.leaveTypeFetchResultController?.object(at: indexPath)else{continue}
                self.selectedHotInfo.check(infoIn: LeaveTypeInfo(leaveType: object))
                i += 1
            }
        }
    }
    
    func runTimer(){
        
        DispatchQueue.main.async {
            guard let currSelected = self.selectedHotInfo.currHot else{return}
            self.updateStaticElement(use: currSelected)
            self.updateAcordingTo(timer: Date(), use: currSelected)
            
            self.updateTimer?.invalidate()
            self.updateTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self]timer in
                let fireDate = timer.fireDate
                self?.updateAcordingTo(timer: fireDate, use: currSelected)
                
            })
        }
    }
    
    fileprivate func updateStaticElement(use currSelected:LeaveInfoSimple){
        

        
        if currSelected.isAccept{
            mainBackgroundImg.image = #imageLiteral(resourceName: "accept_banner")
        }
        if currSelected.isPending{
            mainBackgroundImg.image = #imageLiteral(resourceName: "pending_banner")
        }
        if currSelected.isReject{
            mainBackgroundImg.image = #imageLiteral(resourceName: "reject_banner")
        }
        
        leaveTypeName.text = currSelected.typeName.capitalized
        actionState.text = currSelected.text?.action.capitalized
        timeState.text = currSelected.text?.tail.capitalized
    }
    
    fileprivate func updateAcordingTo(timer realTime:Date,use currSelected:LeaveInfoSimple){
        
        let actionTime = currSelected.actionDate
        
        var timeInfo:(comp1: Comp, comp2: Comp, comp3: Comp){
            switch currSelected.availability {
            case .inleave:
                return realTime.getFullTimeDescription(to: actionTime)
            case .untouch:
                return realTime.getFullTimeDescription(to: actionTime)
            default:
                return actionTime.getFullTimeDescription(to: realTime)
            }
        }
        
        self.headLabelName.text = timeInfo.comp1.name
        self.headLabelValue.text = timeInfo.comp1.value
        
        self.middleLabelName.text = timeInfo.comp2.name
        self.middleLabelValue.text = timeInfo.comp2.value
        
        self.lastLabelName.text = timeInfo.comp3.name
        self.lastLabelValue.text = timeInfo.comp3.value
        
    }
    
}
