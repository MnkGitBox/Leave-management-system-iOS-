//
//  NotificationTVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-06.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class NotificationTVCell: UITableViewCell {
    
    @IBOutlet weak var leaveTypeName: UILabel!
    
    @IBOutlet weak var infoCurrentStateImg: UIImageView!
    @IBOutlet weak var infoDescription: UILabel!
    
    @IBOutlet weak var timeFromReaction: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var info:Info?{
        didSet{
            
            setCurrentStateImg()
            setTimeFromReaction()
            setCheckState()
            setInfoDescription()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 4
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = false
        
        selectionStyle = .none
        
        backgroundColor = .clear
        
    }
    
    
    fileprivate func setCurrentStateImg(){
        
        guard let curState = info?.currState else{return}
        var image:UIImage!
        
        switch curState {
        case InfoCurrentState.accept:
            image = #imageLiteral(resourceName: "approved_ico")
        case InfoCurrentState.reject:
            image = #imageLiteral(resourceName: "rejected_ico")
        case InfoCurrentState.pending:
            image = #imageLiteral(resourceName: "pending_ico")
        default:break
        }
        
        infoCurrentStateImg.image = image
        
    }
    
    fileprivate func setTimeFromReaction(){
        
        let now = Date()
        guard let info = info else{return}
        let reactionTimeNumberValue = info.reactionTime as NSNumber
        guard let reactionTimeDateValue = reactionTimeNumberValue.convertToDate() else {
            fatalError("NotificationTVC--NotificationCell--setTimeFromReaction--reactionTime--toDate-DowncastErr")
        }
        
        
        let timeFromReactionDetails = reactionTimeDateValue.getTimeWithCorrectDiscription(to: now)
        
        guard let dateComponent = timeFromReactionDetails.component else{
            
            timeFromReaction.text = timeFromReactionDetails.description
            return
        }
        
        timeFromReaction.text = "\(dateComponent) \(timeFromReactionDetails.description) ago"
        
    }
    
    fileprivate func setCheckState(){
        
        guard let info = info else {return}
        guard info.isChecked else {
            
            leaveTypeName.textColor = CustomColor.darkAsh
            infoDescription.textColor = CustomColor.ash
            
            return
        }
        
        leaveTypeName.textColor = CustomColor.ash
        infoDescription.textColor = CustomColor.ash
        timeFromReaction.textColor = CustomColor.ash
        containerView.alpha = 0.6
        
    }
    
    fileprivate func setInfoDescription(){
        
        guard let currState = info?.currState else{return}
        switch currState {
        case InfoCurrentState.accept:
            infoDescription.text = info?.reqReason
        case InfoCurrentState.reject:
            infoDescription.text = info?.rejReason
        case InfoCurrentState.pending:
            infoDescription.text = info?.reqReason
        default:
            infoDescription.text = ""
        }
        
    }
    
    
}
