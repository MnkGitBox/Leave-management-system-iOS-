//
//  SingleLeaveDetailsViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-22.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import Lottie

class SingleLeaveDetailsViewController: UIViewController {
    
    @IBOutlet weak var singleLeaveDetailsTableView: UITableView!
    
    @IBOutlet weak var tableViewPanGuesutre: UIPanGestureRecognizer!
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var progresBarContentView: UIView!
    @IBOutlet weak var progressBarMiddleCircle: UIView!
    
    var totalLeaveReservedForPeriod:Int = 0
    
    var leaveType:LeaveTypeInfo!{
        didSet{
            totalLeaveReservedForPeriod = Int(leaveType.reserved)
            title = leaveType.name.capitalized
        }
    }
    
    var isTableOnTop:Bool = false
    var tableViewTopAnchor:NSLayoutConstraint!
    var tVSwiptUpAniStartinPoint:CGFloat{
        return singleLeaveDetailsTableView.rowHeight + singleLeaveDetailsTableView.sectionHeaderHeight
    }
    
    var infoObs:[(key: String, value: [InfoOb])]?{
        didSet{
            guard let infoObects = infoObs else{return}
            for (offset: item ,element: (key: key ,value: info)) in infoObects.enumerated(){
                let sortArray = info.sorted()
                infoObs?.remove(at: item)
                infoObs?.insert((key: key, value: sortArray), at: item)
            }
        }
    }
    
    @IBOutlet weak var usedDays: UILabel!
    @IBOutlet weak var unUsedDays: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var leaveCurrPeriod: UILabel!
    
    @IBOutlet weak var currDetailDescription: UILabel!
    
    @IBOutlet weak var acceptPrecentage: UILabel!
    @IBOutlet weak var acceptProgBarContainer: UIView!
    @IBOutlet weak var acceptDays: UILabel!
    
    @IBOutlet weak var pendingProgBarContainer: UIView!
    @IBOutlet weak var pendingPrecentage: UILabel!
    @IBOutlet weak var pendingDays: UILabel!
    
    @IBOutlet weak var rejectProgBarContainer: UIView!
    @IBOutlet weak var rejectPrecentage: UILabel!
    @IBOutlet weak var rejectDays: UILabel!
    
    
    var pendingLeaveCount:Int = 0
    var rejectLeaveCount:Int = 0
    var acceptLeaveCount:Int = 0
    
    
    var totalUsed:Int = 0{
        didSet{
            usedDays.text = String(totalUsed)
        }
    }
    var totalRemain:Int = 0{
        didSet{
            unUsedDays.text = String(totalRemain)
        }
    }
    var totalRequest:Int = 0
    
    var usedPrecen:Float = 0
    var acceptPrecen:Float = 0
    var pendingPrecen:Float = 0
    var rejectPrecen:Float = 0
    
    
    var acceptProBarLayer:AcceptProLayer!
    var pendingProLayer:PendingProLayer!
    var rejectProLayer:RejectProLayer!
    
    var isProgressBarAnimated:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        computeStatistic()
        
        configureDescription()
        
        configureProgressBar()
        configureSubProgressBars()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if !isProgressBarAnimated{
            playAnimation()
            isProgressBarAnimated = true
        }
        
        tabBarController?.makeVisible(false, isAnimated: true)
        
    }
    
    fileprivate func configureTableView(){
        
        view.addSubview(singleLeaveDetailsTableView)
        singleLeaveDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        singleLeaveDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        singleLeaveDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableViewTopAnchor = singleLeaveDetailsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topContainer.frame.height)
        tableViewTopAnchor.isActive = true
        singleLeaveDetailsTableView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        singleLeaveDetailsTableView.register(SLDTableViewHeaderCell.self, forCellReuseIdentifier:CellID.sLDTHeaderCell)
        
        //remove unvanted extra cells
        singleLeaveDetailsTableView.tableFooterView = UIView()
        
        //addPanguesture on start
        singleLeaveDetailsTableView.addGestureRecognizer(tableViewPanGuesutre)
        singleLeaveDetailsTableView.backgroundColor = CustomColor.tableBackground
        
        
    }
    
    fileprivate func computeStatistic(){
        
        for infoObsSingleState in infoObs!{
            
            for infoOb in infoObsSingleState.value{
                
                print(infoObsSingleState.key,infoOb.leaveDays)
                
                switch infoObsSingleState.key {
                case LeaveCurrentStateHeadingName.accept:
                    acceptLeaveCount += infoOb.leaveDays
                case LeaveCurrentStateHeadingName.pending:
                    pendingLeaveCount += infoOb.leaveDays
                case LeaveCurrentStateHeadingName.reject:
                    rejectLeaveCount += infoOb.leaveDays
                default:break
                }
                
                
            }
            
            
        }
        
        totalUsed = acceptLeaveCount + pendingLeaveCount
        totalRemain = totalLeaveReservedForPeriod - totalUsed
        
        totalRequest = acceptLeaveCount + pendingLeaveCount + rejectLeaveCount
        
        acceptPrecen = Float(acceptLeaveCount) / Float(totalRequest)
        pendingPrecen = Float(pendingLeaveCount) / Float(totalRequest)
        rejectPrecen = Float(rejectLeaveCount) / Float(totalRequest)
        
        usedPrecen = Float(totalUsed) / Float(totalLeaveReservedForPeriod)
        
    }
    
    fileprivate func configureDescription(){
        
//        let highAttri = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13, weight: .medium),NSAttributedStringKey.foregroundColor:CustomColor.ash]
//        let normalAttri = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12, weight: .regular),NSAttributedStringKey.foregroundColor:CustomColor.ash]
//        
//        let pendinAttribText = NSAttributedString(string: InfoCurrentState.pending + " ", attributes:highAttri)
//        let unusedAttribText = NSAttributedString(string: leaveAvailabilityKey.untouch.rawValue + " ", attributes: highAttri)
//        let reqAttributedText = NSAttributedString(string: "requested ", attributes: highAttri)
//        let reqCountAttribText = NSAttributedString(string: "\(totalRequest)", attributes: highAttri)
//        let usedAttribText = NSAttributedString(string: "Used", attributes: highAttri)
//        let commonAttibText = NSMutableAttributedString(string:" days are contain and leave yet.All  leave days are .", attributes:normalAttri)
//        
//        commonAttibText.insert(usedAttribText, at: 0)
//        commonAttibText.insert(pendinAttribText, at: 22)
//        commonAttibText.insert(unusedAttribText, at: 34)
//        commonAttibText.insert(reqAttributedText, at: 56)
//        commonAttibText.insert(reqCountAttribText, at: 82)
//        
//        currDetailDescription.attributedText = commonAttibText
    }
    
    fileprivate func configureProgressBar(){
        
        progressBarMiddleCircle.backgroundColor = UIColor.pinkCustom()
        progressBarMiddleCircle.alpha = 0
        progressBarMiddleCircle.layer.cornerRadius = 50
        progressBarMiddleCircle.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        switch leaveType.period! {
        case LeaveTypePeriod.month:
            leaveCurrPeriod.text = Date().toString(using: "MMMM")!.capitalized
        case LeaveTypePeriod.year:
            leaveCurrPeriod.text = Date().toString(using: "yyyy")!
        case LeaveTypePeriod.allTime:
            leaveCurrPeriod.text = LeaveTypePeriod.allTime.capitalized
        default:break
        }
        
    }
    
    fileprivate func configureSubProgressBars(){
        let lineWidth:CGFloat = 5
        
        let rect = CGRect(x: lineWidth / 2, y: lineWidth / 2, width: acceptProgBarContainer.frame.width - lineWidth, height: acceptProgBarContainer.frame.height - lineWidth)
        
        configAcceptProBar(rect, lineWidth)
        
        configPendingProgBar(rect, lineWidth)
        
        configRejectProBar(rect, lineWidth)
        
    }
    
    fileprivate func configAcceptProBar(_ rect: CGRect, _ lineWidth: CGFloat) {
        acceptProBarLayer = AcceptProLayer(finalprecentage: acceptPrecen , drawInRect:rect)
        acceptProBarLayer.proLineWidth = lineWidth
        acceptProBarLayer.proBarColor = CustomColor.blue.cgColor
        acceptProBarLayer.trackBarColor = CustomColor.extraLightIndigo.cgColor
        acceptProBarLayer.animationDuration = TimeInterval(acceptPrecen)
        acceptProgBarContainer.layer.addSublayer(acceptProBarLayer)
    }
    
    fileprivate func configPendingProgBar(_ rect: CGRect, _ lineWidth: CGFloat) {
        pendingProLayer = PendingProLayer(finalprecentage: pendingPrecen, drawInRect: rect)
        pendingProLayer.proLineWidth = lineWidth
        pendingProLayer.proBarColor = CustomColor.green.cgColor
        pendingProLayer.trackBarColor = CustomColor.extraLightIndigo.cgColor
        pendingProLayer.animationDuration = TimeInterval(pendingPrecen)
        pendingProgBarContainer.layer.addSublayer(pendingProLayer)
    }
    
    fileprivate func configRejectProBar(_ rect: CGRect, _ lineWidth: CGFloat) {
        rejectProLayer = RejectProLayer(finalprecentage: rejectPrecen, drawInRect: rect)
        rejectProLayer.proLineWidth = lineWidth
        rejectProLayer.proBarColor = CustomColor.red.cgColor
        rejectProLayer.trackBarColor = CustomColor.extraLightIndigo.cgColor
        rejectProLayer.animationDuration = TimeInterval(rejectPrecen)
        rejectProgBarContainer.layer.addSublayer(rejectProLayer)
    }
    
    
    //MARK: - TABLE VIEW SWIFT UP AND AWAY ANIMATION
    var scrollPoint:CGFloat!
    var spaceTableTopToTouchPosition:CGFloat!
    var currTVTopPoint:CGFloat!
    var topContainerAlpha:CGFloat?{
        didSet{
            topContainer.alpha = topContainerAlpha ?? 1
        }
    }
    
    //in viewdidload add panguesture recognizer to table view and make swift up
    @IBAction func tableViewPan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            spaceTableTopToTouchPosition = sender.location(in: self.view).y - tableViewTopAnchor.constant
        case .changed:
            if  !isTableOnTop{
                currTVTopPoint = sender.location(in: self.view).y - spaceTableTopToTouchPosition
                tableViewTopAnchor.constant = currTVTopPoint
                topContainerAlpha = currTVTopPoint / topContainer.frame.height
                view.layoutIfNeeded()
                
            }
        case .ended:
            if !isTableOnTop{
                
                guard (view.frame.height / 2.5) < (sender.location(in: self.view).y - spaceTableTopToTouchPosition)else{
                    
                    tableViewPanGuesutre.isEnabled = false
                    aniamteTableView(to: 0, on: true, topAlpha: 0)
                    return
                }
                aniamteTableView(to: topContainer.frame.height, on: false, topAlpha: 1)
            }
            
        default:break
        }
        
    }
    
    //if table view in top..,it disable the guesture recognizer and if table view scroll down more than view/2.5 space..it come down
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        scrollPoint = scrollView.contentOffset.y
        
        if scrollPoint < (tVSwiptUpAniStartinPoint * -2) && isTableOnTop{
            
            self.aniamteTableView(to: self.topContainer.frame.height, on: false, topAlpha: 1)
            tableViewPanGuesutre.isEnabled = true
            return
        }
        
    }
    
    fileprivate func aniamteTableView(to position:CGFloat,on isTop:Bool,topAlpha alpha:CGFloat){
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.tableViewTopAnchor.constant = position
            self.topContainer.alpha = alpha
            self.view.layoutIfNeeded()
        }, completion: { isComplete in
            if isComplete{
                self.isTableOnTop = isTop
            }
        })
    }
    //
    func pushViewControllerUseObjectFrom(cell indexPath:IndexPath){
        
        guard let cell = singleLeaveDetailsTableView.cellForRow(at: indexPath) as? OneInfoTVCell else{return}
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.sLDFTableViewController) as? SingleLeaveMoreDetailFormTableViewController else{return}
        
        viewController.info = cell.subInfo
        
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
}
