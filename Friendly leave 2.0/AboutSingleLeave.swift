//
//  AboutSingleLeave.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class AboutSingleLeave: UITableViewController {
    
    var leaveTypeInfoOb:LeaveTypeInfo?{
        didSet{
            customTitle.text = leaveTypeInfoOb?.name
            if let imgName = leaveTypeInfoOb?.profileImg{
                titleImageView.image = UIImage(named: imgName)
            }
            
        }
    }
    
    let customTitleView:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 22)
        return view
    }()
    let customTitle:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        return label
    }()
    
    let titleImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "default_ico")
        iv.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        iv.contentMode = .scaleAspectFit
        iv.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate func configNavBarTitleView() {
        customTitle.frame = CGRect(x: 26, y: 1, width: customTitleView.frame.width - 26, height: 17)
        customTitleView.addSubview(titleImageView)
        customTitleView.addSubview(customTitle)
        navigationItem.titleView = customTitleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        configNavBarTitleView()
        
        
        setupTableView()
        
    }
    
    
    
    fileprivate func performNavBarImgViewAnimation() {
        return UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.titleImageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.makeVisible(false, isAnimated: true)
        
        performNavBarImgViewAnimation()
        
    }
    
    
    fileprivate func setupTableView(){
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        
    }
    
    
    fileprivate func dequeRightDetailCell(for indexPath:IndexPath)->UITableViewCell{
        
        
        let item = indexPath.item
        
        if item == 0{
            
            let cell = Bundle.main.loadNibNamed("WhatIsThisLeave", owner: self, options: nil)?.first as! WhatIsThisLeave
            cell.leaveInfoLabel.text = leaveTypeInfoOb?.descrip
            return cell
            
        }else if item == 1{
            
            let cell = Bundle.main.loadNibNamed("WhoCanApplyCell", owner: self, options: nil)?.first as! WhoCanApplyCell
            return cell
            
        }else{
            
            let cell = Bundle.main.loadNibNamed("TotalReservedCell", owner: self, options: nil)?.first as! TotalReservedCell
            
            if let leaveReserved = leaveTypeInfoOb?.reserved{
                
                cell.reservedTimePeriod.text = String(leaveReserved)
                
            }
            
            cell.period = leaveTypeInfoOb?.period
            return cell
            
        }
        
        
    }
    
    
}

extension AboutSingleLeave{
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeRightDetailCell(for: indexPath)
        return cell
        
    }
    
}




