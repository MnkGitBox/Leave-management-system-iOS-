//
//  SingleLeaveMoreDetailFormTableViewControllerProtocol.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension SingleLeaveMoreDetailFormTableViewController{
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return moreDetails?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let correctSection = moreDetails?[section] else{return 0}
        
        return correctSection.value.count
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailOB = moreDetails?[indexPath.section].value[indexPath.item]
        let cell = tableView.dequeueReusableCellAndSet(object: detailOB, for: indexPath)
        return cell
        
    }
    
    
}

//MARK: - Select the Correct Cell Using Cell Type Associalt With DetailOB Detail Array....
extension UITableView{
    
    func dequeueReusableCellAndSet(object ob:DetailWithCellType?, for indexPath:IndexPath) -> UITableViewCell {
        
        guard let detailOb = ob else{
            return UITableViewCell(frame: .zero)
        }
        
        switch detailOb.type {
            
        case .state:
            let cell = self.dequeueReusableCell(withIdentifier: CellID.stateCell, for: indexPath) as!StateTableViewCell
            cell.title = detailOb.key.capitalized
            cell.value = detailOb.value as? String
            return cell
            
        case .doubleDate:
            let cell = self.dequeueReusableCell(withIdentifier: CellID.fromToDateCell, for: indexPath) as! FromToDateTableViewCell
            
            cell.valuesDic = detailOb.value as? [ValuesKey:String]
            return cell
            
        case .reason:
            let cell = self.dequeueReusableCell(withIdentifier: CellID.reasonCell, for: indexPath) as! ReasonsTableViewCell
            cell.title = detailOb.key.capitalized
            cell.value = detailOb.value as? String
            return cell
            
        case .profile:
            let cell = self.dequeueReusableCell(withIdentifier: CellID.profileCell, for: indexPath) as! ProfileTableViewCell
            cell.respondedUsrId = detailOb.value as? String
            cell.header.text = detailOb.key.capitalized
            return cell
        case .dateTime:
            let cell = self.dequeueReusableCell(withIdentifier: CellID.singleDateTime, for: indexPath) as! SingleDateTimeTableViewCell
            cell.title.text = detailOb.key.capitalized
            cell.valueDic = detailOb.value as? [ValuesKey:Any]
            return cell
        }
        
    }
    
}
