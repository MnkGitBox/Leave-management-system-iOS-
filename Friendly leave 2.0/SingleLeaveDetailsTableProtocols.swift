//
//  SingleLeaveDetailsTableProtocols.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-22.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//


import UIKit

extension SingleLeaveDetailsViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    // MARK: - Implement Table View Data Sourse
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return infoObs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let infoObSection = infoObs?[section] else {return 0}
        
        return infoObSection.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = Bundle.main.loadNibNamed("OneInfoTVCell", owner: self, options: nil)?.first as! OneInfoTVCell
        
        if let infoObSection = infoObs?[indexPath.section]{
            
            cell.subInfo = infoObSection.value[indexPath.item]
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: CellID.sLDTHeaderCell) as! SLDTableViewHeaderCell
        
        let name = infoObs?[section].key
        
        headerCell.header.text = name?.uppercased()
        
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pushViewControllerUseObjectFrom(cell: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
}



