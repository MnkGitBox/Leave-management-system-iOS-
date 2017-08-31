//
//  AllDetailsTableViewProtocols.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-22.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    // MARK: - Implement TableView Data Sourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = leaveTypeFetchResultController?.sections, sections.count > 0{
            
            return sections[section].numberOfObjects
            
        }else{
            
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.leaveDetailTVCell, for: indexPath)
            as! LeavesDetailTVCell
        if let leaveType = leaveTypeFetchResultController?.object(at: indexPath){
            
            let typeWithInfo = LeaveTypeInfo(leaveType: leaveType)
            cell.leaveTypeInfo = typeWithInfo
            
        }
        
        return cell
        
    }
    
    //     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 84
    //    }
    
    
    // MARK: -Implement Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? LeavesDetailTVCell else{return}
        guard let getInfoDic = cell.leaveTypeInfo?.setAndReturnLeavesInfo()else{return}
        segueToLeaveInfo(using: getInfoDic, andLeaveType: cell.leaveTypeInfo!)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LeavesDetailTVCell else{return}
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            cell.alpha = 0.7
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LeavesDetailTVCell else{return}
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: nil)
        
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//        guard let sections = leaveTypeFetchResultController?.sections else{
//            setEmptyLabel(in: tableView)
//            return 0
//        }
//        
//        if sections.count > 0{
//            setEmptyLabel(in: tableView)
//            return 0
//        }else{
//            tableView.backgroundView = nil
//            tableView.separatorStyle = .singleLine
//            return 1
//        }
//        
//    }
//    
//    func setEmptyLabel(in tableView:UITableView){
//        
//        let frame = CGRect(x: 0, y: 0, width: self.leavesDetailTV.bounds.size.width, height: self.leavesDetailTV.bounds.size.height)
//        let noDataLabel = UILabel(frame: frame)
//        noDataLabel.text = "No Data to show"
//        noDataLabel.textColor = CustomColor.subtitleColor
//        noDataLabel.textAlignment = .center
//        noDataLabel.sizeToFit()
//        tableView.backgroundView = noDataLabel
//        tableView.separatorStyle = .none
//    
//    }
    
    
}
