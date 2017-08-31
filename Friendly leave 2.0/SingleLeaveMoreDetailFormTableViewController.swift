//
//  SingleLeaveMoreDetailFormTableViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit


var currStateImage:UIImage!
class SingleLeaveMoreDetailFormTableViewController: UITableViewController {
    
    
    var info:InfoOb?{
        didSet{
            guard let detailDic = info?.subInfoWithCellType() else{return}
            moreDetails = Array(detailDic)
            
            guard let currState = info?.currentState else{return}
            switch currState{
            case InfoCurrentState.accept:
                currStateImage = #imageLiteral(resourceName: "approved_ico")
            case InfoCurrentState.pending:
                currStateImage = #imageLiteral(resourceName: "pending_ico")
            case InfoCurrentState.reject:
                currStateImage = #imageLiteral(resourceName: "rejected_ico")
            default:break
            }
            
        }
    }
    
    var moreDetails:[(key: String, value: [DetailWithCellType])]?
    
    var leavetypeName:String = ""
    
    let titleView = UIView()
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.5, weight: UIFontWeightMedium)
        label.textColor = .white
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = currStateImage
        titleLabel.text = "\(leavetypeName.capitalized) Info"
        titleView.frame = CGRect(x: 0, y: 0, width: 150, height: 18)
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        titleLabel.frame = CGRect(x: 22, y: 0, width: 128, height: 18)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
        tableView.tableFooterView = UIView()
        
        imageView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.makeVisible(false, isAnimated: true)
        performTitleViewAnimation()
        
    }
    
    fileprivate func performTitleViewAnimation(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.imageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
}
