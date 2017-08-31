//
//  FilledFormViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-27.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class FilledFormViewController: UIViewController {
    
    var selectedInfo:[String:Any] = [:]{
        didSet{
            leaveRequesrInfo = LeaveRequestInfo(requestInfo: selectedInfo)
        }
    }
    
    var leaveRequesrInfo:LeaveRequestInfo!
    
    let tableViewContainer:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    lazy var summaryApplicationFormTV:UITableView = {
        
        let tv = UITableView()
        //        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
        
    }()
    
    let alertView = CustomAlertWithAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Request Form"
        
        view.backgroundColor = CustomColor.darkBlue
        
        configureTableView()
        
        layoutTableView()
        
        let sendBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "send_ico"), style: .plain, target: self, action: #selector(performSend))
        navigationItem.rightBarButtonItem = sendBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        summaryApplicationFormTV.estimatedRowHeight = 60
        summaryApplicationFormTV.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func configureTableView(){
        
        summaryApplicationFormTV.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        summaryApplicationFormTV.tableFooterView = UIView()
        summaryApplicationFormTV.allowsSelection = false
        
        summaryApplicationFormTV.layer.cornerRadius = 3
        summaryApplicationFormTV.clipsToBounds = true
        
        summaryApplicationFormTV.register(LeaveNameTVCell.self, forCellReuseIdentifier: CellID.summaryLeaveProfileCell)
        summaryApplicationFormTV.register(SelectedDaysTVCell.self, forCellReuseIdentifier: CellID.summaryLeaveDaysCell)
        summaryApplicationFormTV.register(DateCountCell.self, forCellReuseIdentifier: CellID.summaryLeaveDaysCountCell)
        summaryApplicationFormTV.register(SummaryBaseTVCell.self, forCellReuseIdentifier: CellID.defaultCell)
        summaryApplicationFormTV.register(ReasonTVCell.self, forCellReuseIdentifier: CellID.summaryLeaveReasonCell)
        
    }
    
    fileprivate func layoutTableView(){
        
        tableViewContainer.frame = CGRect(x: 16, y: 16, width: self.view.frame.width - 32, height: self.view.frame.height - 32 - (navigationController?.navigationBar.frame.height)! - 20)
        summaryApplicationFormTV.frame = CGRect(x: 0, y: 0, width: tableViewContainer.frame.width, height: tableViewContainer.frame.height)
        
        tableViewContainer.addSubview(summaryApplicationFormTV)
        view.addSubview(tableViewContainer)
        
    }
    
    var isAlertCompleted = false
    
    @objc func performSend() {
        
        leaveRequesrInfo.reactionTime = Date().timeIntervalSince1970 as NSNumber
        
        let leaveRequestDic = leaveRequesrInfo.convertToDic()
        
        alertView.popAlertAndAnimate()
        PostLeaveRequest.performNew(to: leaveRequestDic) { [weak self]err in
            
            guard let isCompleted = self?.isAlertCompleted else{return}
            guard !isCompleted else{return}
            guard let errMsg = err else{
                self?.performAlertViewOperation(alert: "sent", isErr: false)
                return
            }
            self?.performAlertViewOperation(alert: errMsg, isErr: true)
            self?.isAlertCompleted = true
        }
        
    }
    
    fileprivate func performAlertViewOperation(alert:String,isErr fail:Bool){
        
        alertView.setResultAnimation(isFaild: fail, alert: alert) { (completion) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension FilledFormViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeRightCell(for: indexPath, with: leaveRequesrInfo)
        return cell
        
    }
    
}

extension UITableView{
    
    func dequeRightCell(for indexPath:IndexPath,with requestInfo:LeaveRequestInfo?)->UITableViewCell{
        
        var cell:SummaryBaseTVCell!
        
        switch indexPath.item {
        case 0:
            cell = self.dequeueReusableCell(withIdentifier: CellID.summaryLeaveProfileCell, for: indexPath) as! LeaveNameTVCell
        case 1:
            cell = self.dequeueReusableCell(withIdentifier: CellID.summaryLeaveDaysCell, for: indexPath) as! SelectedDaysTVCell
        case 2:
            cell = self.dequeueReusableCell(withIdentifier: CellID.summaryLeaveDaysCountCell, for: indexPath) as! DateCountCell
        case 3:
            cell = self.dequeueReusableCell(withIdentifier: CellID.summaryLeaveReasonCell, for: indexPath) as! ReasonTVCell
        default:
            cell = self.dequeueReusableCell(withIdentifier: CellID.defaultCell, for: indexPath) as? SummaryBaseTVCell
        }
        
        cell.setRequestInfo = requestInfo
        
        return cell
        
    }
    
    
}



