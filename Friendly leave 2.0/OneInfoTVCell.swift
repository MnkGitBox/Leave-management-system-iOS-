//
//  OneInfoTVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-05.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class OneInfoTVCell: UITableViewCell {
    
    //background views
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var roundIco: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    //data show outlet
    @IBOutlet weak var daysCount: UILabel!
    @IBOutlet weak var startDay: UILabel!
    @IBOutlet weak var reasonSummary: UILabel!
    @IBOutlet weak var currStateAccept: UILabel!
    
    var mainColor:UIColor!
    
    var subInfo:InfoOb?{
        
        didSet{
            
            guard let info = subInfo else{return}
            
            if let from = info.beginDate.convertToDate(){
                startDay.text = from.toString(using: "E, dd MMMM yyyy")
            }
            
            let numerOfDays = info.leaveDays
            
            if numerOfDays > 1{
                
                daysCount.text = String(numerOfDays)
                dayLabel.text = "Days"
                
            }else{
                
                daysCount.text = String(numerOfDays)
                dayLabel.text = "Day"
            }
            
            setDetailAcording(to: info)
            
            
        }
        
    }
    
    fileprivate func setDetailAcording(to info: InfoOb) {
        switch info.currentState {
        case InfoCurrentState.accept:
            
            mainColor = CustomColor.green
            
            let currStateOfAccept = info.checkLeave(startDate: info.beginDate.convertToDate()!, and: info.returnDate.convertToDate()!, equalGreaterOrLessTo: Date())
            
            currStateAccept.isHidden = false
            currStateAccept.text = currStateOfAccept.rawValue
            currStateAccept.backgroundColor = CustomColor.yellow
            currStateAccept.textColor = CustomColor.whiteCream
            
        case InfoCurrentState.pending:
            
            mainColor = CustomColor.orange
            
        case InfoCurrentState.reject:
            
            mainColor = CustomColor.red
            
        default:break
        }
        
        daysCount.textColor = mainColor
        dayLabel.textColor = mainColor
        roundIco.textColor = mainColor
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        currStateAccept.isHidden = true
        currStateAccept.layer.cornerRadius = 3
        currStateAccept.layer.masksToBounds = true
        containerView.backgroundColor = CustomColor.cellBackground
        
    }
    
    
}
