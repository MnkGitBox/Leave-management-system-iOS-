//
//  NotificationTVC.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-06.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import CoreData

class NotificationTVC: UITableViewController {
    
    let container:NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var fetchResultController:NSFetchedResultsController<Info>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
        fetchInfo()
        
        title = "Notification"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.makeVisible(true, isAnimated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func fetchInfo(){
        
        let customAlert = CustomAlert()
        
        if let context = container?.viewContext{
            
            let request:NSFetchRequest<Info> = Info.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "reactionTime", ascending: false)]
            
            fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController?.delegate = self
            
            do {
                try fetchResultController?.performFetch()
            } catch let err {
                customAlert.pop(with: "System error: "+err.localizedDescription, "core_data_error", "Will Connect", #imageLiteral(resourceName: "system_error"))
            }
            tableView.reloadData()
            
        }
        
    }
    
    fileprivate func settingTableView(){
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
    }
    
    func performSegue(withInfo infoOb:InfoOb, of leaveType:String){
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.sLDFTableViewController) as? SingleLeaveMoreDetailFormTableViewController else{return}
        
        viewController.info = infoOb
        viewController.leavetypeName = leaveType
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func performIsCheckedWrite(using infoOb:InfoOb){
        
        guard !infoOb.isChecked else{return}
        var ob = infoOb
        ob.isChecked = true
        
        CoreInfoRequest.writeIsChecked(inInfoOb: ob)
        FirPostInfoRequest.writeIsChecked(state: true, inInfoID: ob.id)
        
    }
    
}

extension NotificationTVC:NSFetchedResultsControllerDelegate{
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            
            guard let newIndex = newIndexPath else {
                tableView.reloadData()
                return
            }
            tableView.insertRows(at: [newIndex], with: .fade)
            
        case .update:
            
//            guard let currentIndex = indexPath else{
//                fatalError("NotificationTVC--NSFetchedResultsControllerDelegate--didChange-anObject-indexPath-optionalUwrapingErr")
//            }
            
//            tableView.reloadRows(at: [currentIndex], with: .fade)
            
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
            
           
            
        default:break
        }
        
        
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
}



extension NotificationTVC{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let fetchResultControllerSection = fetchResultController?.sections, fetchResultControllerSection.count > 0{
            
            return fetchResultControllerSection[section].numberOfObjects
            
        }else{
            
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("NotificationTVCell", owner: self, options: nil)?.first as! NotificationTVCell
        if let info = fetchResultController?.object(at: indexPath){
            
            guard let leaveType = LeaveRequest.fetchLeave(using: info.leaveTypeID!)else{return cell}
            cell.leaveTypeName.text = leaveType.name?.capitalized
            cell.info = info
            
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! NotificationTVCell
        guard let info = cell.info else{return}
        let infoOb = InfoOb(InfoCoOb: info)
        
        performSegue(withInfo: infoOb, of: (cell.leaveTypeName.text) ?? "")
        performIsCheckedWrite(using: infoOb)
        
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? NotificationTVCell{
            
            UIView.animate(withDuration: 0.2, animations: {
                cell.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? NotificationTVCell{
            UIView.animate(withDuration: 0.2, animations: {
                cell.containerView.transform = CGAffineTransform.identity
            })
        }
        
    }
    
}
