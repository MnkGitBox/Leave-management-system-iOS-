//
//  CoreData Operation.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-13.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import CoreData

extension HomeViewController{
    
    //MARK:- CLEAR ALL LOCAL DATA
    func clearLocalData(){
        
        guard let context = container?.viewContext else{return}
        
        let infoFetch:NSFetchRequest<NSFetchRequestResult> = Info.fetchRequest()
        let leaveTypeFetch:NSFetchRequest<NSFetchRequestResult> = LeaveType.fetchRequest()
        
        let infoRequest = NSBatchDeleteRequest(fetchRequest: infoFetch)
        let leaveTypeRequest = NSBatchDeleteRequest(fetchRequest: leaveTypeFetch)
        
        do {
            try context.execute(infoRequest)
            try context.execute(leaveTypeRequest)
        } catch let err{
            print("err in delete all data when sign out: ",err.localizedDescription)
        }
        
    }
    //MARK: - Get Leaves From DB And Update To CoreData, This only happen When First Time Launch
    
    func updateOnce(of leaves:[(String, LeaveTypeOb)]){
        
        guard let context = container?.viewContext else{
            return}
        for leave in leaves{
            try? LeaveType.createLeave(of: leave, in: context)
        }
        try? context.save()
    }
    
    
    //MARK: - Fetch Leave Info Data From FireBase
    
    func  getDataFromFireBase(){
        FireRequestInfo.fetchLeaveInfoForType { (InfoOb) in
            
            self.info.append(InfoOb)
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateDBWithLeaveInfo), userInfo: nil, repeats: false)
        }
    }
    
    //    @objc func throwDatatoUpdate(){
    //
    //        updateDBWithLeaveInfo(infoOb: info)
    //
    //    }
    
    //MARK: Update Core Database with New Fetch Info Objects
    
    @objc func updateDBWithLeaveInfo(){
        
        //if i remove object from main array after save...it might be remove the all unsaved data  beacause, i had assign new value to the same old array...to prevent that i  assigned current operation data in to temp array and save that data first
        infoObTemp.append(contentsOf: info)
        info.removeAll()
        
        if let context = container?.viewContext{
            
            for (i, ob) in infoObTemp.enumerated().reversed(){
                Info.createOrUpdateLeaveInfoAndSetToType(using: ob, in: context)
                infoObTemp.remove(at: i)
            }
            try? context.save()
        }
        
    }
    
    
    //MARK: - Fetch Data From Core Database and Set to FetchResult controller
    
    func fetchDataAndUpdateUI(){
        
        var predicate:NSPredicate!
        
        predicate = (isSearChBegan) ? NSPredicate(format: "name contains[cd] %@", searchString) : NSPredicate(format: "any info != %@", 0)
        
        if let context = container?.viewContext{
            
            let request:NSFetchRequest<LeaveType> = LeaveType.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            request.predicate = predicate
            
            leaveTypeFetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            leaveTypeFetchResultController?.delegate = self
            
            do{
                
                try leaveTypeFetchResultController?.performFetch()
                
            }catch let err{
                
                print("NSFetch Leave Type Err: ",err.localizedDescription)
                
                
            }
            leavesDetailTV.reloadData()
        }
        
    }
    
    
}
