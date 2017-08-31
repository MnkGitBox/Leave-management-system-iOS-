//
//  LeavesTVC.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class LeavesTVC: UITableViewController {
    
    var leaveTypeInfoObs:[LeaveTypeInfo] = []
    
    fileprivate func configTableView() {
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UserColor(withHexValue: "#ECF0F1")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UserColor(withHexValue: "#DBDDE2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leave Types"
        
        //fetch leaves from core DB
        sendLeaveRequest()
        
        configTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.makeVisible(true, isAnimated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 82
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func sendLeaveRequest(){
        
        do {
            
            let leaveTypes  = try LeaveRequest.fetchLeaves()
            convertToLeaveTypeInfoOb(of: leaveTypes)
            
        } catch let err {
            
            print(err.localizedDescription)
            
        }
        
    }
    
    fileprivate func convertToLeaveTypeInfoOb(of leaveTypes:[LeaveType]){
        
        for type in leaveTypes{
            
            leaveTypeInfoObs.append(LeaveTypeInfo(leaveType: type))
            
        }
        
    }
    
    fileprivate func segueLeaveInfoOfSelectCell(for indexPath:IndexPath){
        
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? LeaveCell else{return}
        guard let selectedLeaveTypeInfoOb = selectedCell.leaveTypeInfoOb else{return}
        guard let aboutLeaveTVC = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.aboutLeaveTVC) as? AboutSingleLeave else{return}
        aboutLeaveTVC.leaveTypeInfoOb = selectedLeaveTypeInfoOb
        navigationController?.pushViewController(aboutLeaveTVC, animated: true)
    }
    
}

extension LeavesTVC{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveTypeInfoObs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("LeaveCell", owner: self, options: nil)?.first as! LeaveCell
        
        let leaveTypeInfoOb = leaveTypeInfoObs[indexPath.item]
        cell.leaveTypeInfoOb = leaveTypeInfoOb
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        segueLeaveInfoOfSelectCell(for: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        
        if let cell = tableView.cellForRow(at: indexPath) as? LeaveCell{
            
            UIView.animate(withDuration: 0.2, animations: {
                cell.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                cell.containerView.alpha = 0.8
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LeaveCell{
            
            UIView.animate(withDuration: 0.2, animations: {
                cell.containerView.transform = CGAffineTransform.identity
                cell.containerView.alpha = 1
            })
        }
    }
    
}
