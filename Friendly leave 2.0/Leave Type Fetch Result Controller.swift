//
//  LeaveTypeFetchResultController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-14.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension HomeViewController:NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        leavesDetailTV.beginUpdates()
        
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:break
        case .insert:
            guard let newIndexPath = newIndexPath else {
                fatalError("try to insert new rows, new indexpath is nil")
            }
            
            leavesDetailTV.insertRows(at: [newIndexPath], with: .fade)
            setNotificationBadgeValue()
            
            DispatchQueue.global().async {
                if let object = self.leaveTypeFetchResultController?.object(at: newIndexPath){
                    self.selectedHotInfo.check(infoIn: LeaveTypeInfo(leaveType: object))
                }
            }
            
        case .move:break
        case .update:
            guard let oldIndex = indexPath else {
                fatalError("try to update exiting rows, old indexpath is nil")
            }
            
            leavesDetailTV.reloadRows(at: [oldIndex], with: .fade)
            setNotificationBadgeValue()
            DispatchQueue.global().async {
                if let object = self.leaveTypeFetchResultController?.object(at: oldIndex){
                    self.selectedHotInfo.check(infoIn: LeaveTypeInfo(leaveType: object))
                }
            }
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        leavesDetailTV.endUpdates()
        
    }
    
    
    
}
