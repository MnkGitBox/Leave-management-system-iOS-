//
//  SelectLeaveTypeViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-26.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Lottie

class SelectLeaveTypeViewController: UIViewController{
    
    var targetCellItem:Int = 0
    var leaveTypeInfoObs:[LeaveTypeInfo] = []
    let notificationCenter = NotificationCenter.default
    var selectedInfo:[String:Any] = [:]
    var targetLeaveTypeInfoOb:LeaveTypeInfo?
    var targetIndexPath:IndexPath?
    var isEmptySelection:Bool = true
    var isCellOpen:Bool = false
    let customAlert = CustomAlert()
    
    var viewSize:CGSize!
    var topSectionHeight:CGFloat{
        return (viewSize.height / 2) - (navigationController?.navigationBar.frame.height)!
    }
    
    var bottomSectioHeight:CGFloat{
        return viewSize.height - (navigationController?.navigationBar.frame.height)! - topSectionHeight - 20
    }
    
    var selectedIndexPath:IndexPath?
    var cellItemSize:CGSize{
        return CGSize(width: viewSize.width, height: 60)
    }
    
    let transform = CGAffineTransform(translationX: -20, y: -10)
    var stretchAndTransform:CGAffineTransform{
        return transform.scaledBy(x: 0.8, y: 0.8)
    }
    
    
    let nextButton = CustomButton()
    
    var currentUserID:String?{
        return FIRAuth.auth()?.currentUser?.uid
    }
    
    lazy var leaveCV:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let remainDays:UILabel = {
        let label = UILabel()
        label.text = "199"
        label.textColor = CustomColor.whiteCream
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayOrDays:UILabel = {
        let label = UILabel()
        label.text = "Days"
        label.textColor = CustomColor.whiteCream
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let remainMonth:UILabel = {
        let label = UILabel()
        label.text = "Left in period"
        label.textColor = CustomColor.whiteCream
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currSelectTopBackground:UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    let headerCurrentSelect:UILabel = {
        let label = UILabel()
        label.text = "Current Picked"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightSemibold)
        label.textColor = CustomColor.whiteCream
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let backgroundCurrentSelect:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.darkGreen
        return view
    }()
    
    let leaveTypeIcoContainer:UIView = {
        
        let view = UIView()
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = false
        return view
    }()
    
    let currSelectLeaveTypeIco:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "default_ico")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 32
        iv.clipsToBounds = true
        return iv
    }()
    
    let currentSelectLeaveType:UILabel = {
        let label = UILabel()
        label.text = "Leave Name"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seperator:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seperator2:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seperator3:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var clearButton:CustomButton = {
        let btn = CustomButton()
        btn.backgroundColor = CustomColor.lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isUserInteractionEnabled = true
        
        btn.titleLabel.text = "Clear Selection"
        btn.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        btn.titleLabel.textColor = CustomColor.red
        
        btn.setImage(image: #imageLiteral(resourceName: "clear btn"), to: .left, in: CGSize(width: 20, height: 20))
        btn.titleLeftInset = 16
        btn.imageLeftInset = 16
        
        
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.masksToBounds = false
        
        btn.addTarget(target: self, action: #selector(clearSelectedInfo))
        
        return btn
    }()
    
    lazy var tapGestureCloseCell:UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 2
        gesture.addTarget(self, action: #selector(closeCell))
        return gesture
    }()
    lazy var tapGestureMoreDetail:UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.addTarget(self, action: #selector(segueToMoreDetail))
        return gesture
    }()
    //    lazy var tapGesturePickLeave:UITapGestureRecognizer = {
    //        let gesture = UITapGestureRecognizer()
    //        gesture.numberOfTapsRequired = 1
    //        gesture.addTarget(self, action: #selector(performSelectedLeaveTypeOperation))
    //        return gesture
    //    }()
    
    var emptySelectionAnimationView:LOTAnimationView?
    let notselectedBackground:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.darkGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let remainDayStackView:UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Leave Type"
        
        viewSize = view.frame.size
        
        sendLeaveRequest()
        
        view.backgroundColor = CustomColor.lightGray
        
        layoutLeaveCV()
        layoutCurrentSelectSection()
        
        configureLeaveTypeCollectioView()
        
        //        clearButton.addGestureRecognizer(tapGuestureRecognizer)
        
        configNavbarBtn()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimationViewAnimation()
    }
    
    fileprivate func configNavbarBtn(){
        
        let icoSize = CGSize(width: 22, height: 22)
        nextButton.setImageButton(of: #imageLiteral(resourceName: "next_ico"), in: icoSize, shapeUsingButtonRadius: 0)
        nextButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        nextButton.addTarget(target: self, action: #selector(segueToNextPage))
        nextButton.isEnabled = false
        
        let barBtnItem = UIBarButtonItem(customView: nextButton)
        navigationItem.rightBarButtonItem = barBtnItem
        
    }
    
    
    @IBAction func cancelTap(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    fileprivate func sendLeaveRequest(){
        
        do {
            
            let leaveTypes =  try LeaveRequest.fetchLeaves()
            convertToLeaveTypeInfoOb(of: leaveTypes)
            
        } catch let err {
            
            print(err)
        }
        
        
    }
    
    fileprivate func convertToLeaveTypeInfoOb(of leaveTypes:[LeaveType]){
        
        for type in leaveTypes{
            
            leaveTypeInfoObs.append(LeaveTypeInfo(leaveType: type))
            
        }
        
    }
    
    fileprivate func configureLeaveTypeCollectioView(){
        
        leaveCV.register(LeaveCVCell.self, forCellWithReuseIdentifier: CellID.leaveCell)
        
        leaveCV.showsHorizontalScrollIndicator = false
        
    }
    
    fileprivate func layoutLeaveCV(){
        
        leaveCV.frame = CGRect(x: 0, y: topSectionHeight, width: viewSize.width , height: bottomSectioHeight)
        view.addSubview(leaveCV)
        
    }
    
    fileprivate func layoutCurrentSelectSection(){
        
        backgroundCurrentSelect.frame = CGRect(x: 0, y: 0, width: viewSize.width, height: topSectionHeight)
        view.addSubview(backgroundCurrentSelect)
        
        currSelectTopBackground.frame = CGRect(x: 0, y: 0, width: viewSize.width, height: topSectionHeight - 44)
        backgroundCurrentSelect.addSubview(currSelectTopBackground)
        
        currSelectTopBackground.addSubview(headerCurrentSelect)
        headerCurrentSelect.leftAnchor.constraint(equalTo: currSelectTopBackground.leftAnchor, constant: 16).isActive = true
        headerCurrentSelect.topAnchor.constraint(equalTo: currSelectTopBackground.topAnchor, constant: 16).isActive = true
        
        leaveTypeIcoContainer.frame =  CGRect(x: viewSize.width - (viewSize.width / 2) - 32, y: 56, width: 64, height: 64)
        currSelectLeaveTypeIco.frame = CGRect(x:0, y:0, width: 64, height: 64)
        
        //configure shadow path for the rounded leave type ico
        let rect = CGRect(x: 0, y: 0, width: leaveTypeIcoContainer.frame.width, height: leaveTypeIcoContainer.frame.height)
        let icoOvalPath:CGPath = UIBezierPath(ovalIn: rect).cgPath
        leaveTypeIcoContainer.layer.shadowPath =  icoOvalPath
        
        //
        leaveTypeIcoContainer.addSubview(currSelectLeaveTypeIco)
        currSelectTopBackground.addSubview(leaveTypeIcoContainer)
        
        currSelectTopBackground.addSubview(currentSelectLeaveType)
        currentSelectLeaveType.centerXAnchor.constraint(equalTo: leaveTypeIcoContainer.centerXAnchor).isActive = true
        currentSelectLeaveType.topAnchor.constraint(equalTo: leaveTypeIcoContainer.bottomAnchor, constant: 8).isActive = true
        
        remainDayStackView.addArrangedSubview(remainDays)
        remainDayStackView.addArrangedSubview(dayOrDays)
        remainDayStackView.addArrangedSubview(remainMonth)
        
        currSelectTopBackground.addSubview(remainDayStackView)
        remainDayStackView.topAnchor.constraint(equalTo: currentSelectLeaveType.bottomAnchor, constant: 8).isActive = true
        remainDayStackView.centerXAnchor.constraint(equalTo: currSelectTopBackground.centerXAnchor).isActive = true
        remainDayStackView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        backgroundCurrentSelect.addSubview(clearButton)
        clearButton.topAnchor.constraint(equalTo: currSelectTopBackground.bottomAnchor).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        clearButton.leftAnchor.constraint(equalTo: backgroundCurrentSelect.leftAnchor).isActive = true
        clearButton.rightAnchor.constraint(equalTo: backgroundCurrentSelect.rightAnchor).isActive = true
        
        
        backgroundCurrentSelect.addSubview(notselectedBackground)
        notselectedBackground.topAnchor.constraint(equalTo: backgroundCurrentSelect.topAnchor, constant: 44).isActive = true
        notselectedBackground.leftAnchor.constraint(equalTo: backgroundCurrentSelect.leftAnchor).isActive = true
        notselectedBackground.rightAnchor.constraint(equalTo: backgroundCurrentSelect.rightAnchor).isActive = true
        notselectedBackground.bottomAnchor.constraint(equalTo: backgroundCurrentSelect.bottomAnchor, constant: -44).isActive = true
        
        
    }
    
    fileprivate func performAnimationViewAnimation(){
        
        if emptySelectionAnimationView != nil{
            emptySelectionAnimationView?.removeFromSuperview()
        }
        emptySelectionAnimationView = LOTAnimationView(name: "empty_animation")
        
        guard let animationView = emptySelectionAnimationView else{return}
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: 16, y: 0, width: view.frame.size.width - 32, height:topSectionHeight - (80  + 44) )
        
        notselectedBackground.addSubview(animationView)
        animationView.play()
    }
    
    @objc func clearSelectedInfo(){
        
        guard !isEmptySelection else{return}
        
        selectedInfo.removeAll()
        
        animateInNotSelectedBackground()
        
        nextButton.isEnabled = false
        
        isEmptySelection = true
    }
    
    fileprivate func animateOffNotSelecedBackground() {
        
        UIView.animate(withDuration: 0.2) {
            
            self.headerCurrentSelect.transform = self.stretchAndTransform
            self.notselectedBackground.alpha = 0
            
        }
    }
    
    fileprivate func animateInNotSelectedBackground(){
        
        UIView.animate(withDuration: 0.2) {
            
            self.notselectedBackground.alpha = 1
            self.headerCurrentSelect.transform = .identity
            
        }
        performAnimationViewAnimation()
    }
    
    fileprivate func gatherSelectedInfo(_ leaveTypeInfoOb: LeaveTypeInfo) {
        selectedInfo[dbAttributename.leaveType] = leaveTypeInfoOb
        selectedInfo[dbAttributename.userID] = currentUserID
        selectedInfo[dbAttributename.isChecked] = false
    }
    
    fileprivate func updateUICurrSelected(_ leaveTypeInfoOb: LeaveTypeInfo) {
        
        currentSelectLeaveType.text = leaveTypeInfoOb.name.capitalized
        remainDays.text = String(leaveTypeInfoOb.remain)
        
        if let imgName = leaveTypeInfoOb.profileImg{
            currSelectLeaveTypeIco.image = UIImage(named: imgName)
        }
        
        if leaveTypeInfoOb.remain > 1{
            dayOrDays.text = "Days"
        }else{
            dayOrDays.text = "Day"
        }
        
        guard let period = leaveTypeInfoOb.period else{return}
        switch period {
        case LeaveTypePeriod.month:
            guard let month = Date().toString(using: "MMMM")else{return}
            remainMonth.text = "left in \(month)"
        case LeaveTypePeriod.year:
            guard let year = Date().toString(using: "yyyy")else{return}
            remainMonth.text = "left in \(year)"
        case LeaveTypePeriod.allTime:
            remainMonth.text = "left"
        default:break
        }
        
    }
    
    @objc func performSelectedLeaveTypeOperation(){
        
        guard let cell = targetCell else{return}
        guard let leaveTypeInfoOb = cell.leaveTypeInfoOb else{return}
        
        guard leaveTypeInfoOb.remain > 0 else{
            customAlert.pop(with: "No Leave Remain", "empty bucket", "select another", #imageLiteral(resourceName: "empty_buket"))
            return
        }
        
        animateOffNotSelecedBackground()
        
        gatherSelectedInfo(leaveTypeInfoOb)
        
        updateUICurrSelected(leaveTypeInfoOb)
        
        nextButton.isEnabled = true
        isEmptySelection = false
        
    }
    
    //MARK: - OPEN CLOSE CELL ANIMATION
    func openCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? LeaveCVCell else{return}
        cell.layoutBigView()
        self.isCellOpen = true
        
        collectionView.performBatchUpdates(nil, completion: { isCompleted in
            
            if isCompleted{
                
                collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                self.selectedIndexPath = indexPath
                collectionView.isScrollEnabled = false
                collectionView.showsVerticalScrollIndicator = false
                cell.mainContainer.addGestureRecognizer(self.tapGestureCloseCell)
                //                cell.leaveSelectButtonContainer.addGestureRecognizer(self.tapGesturePickLeave)
                cell.pickLeaveBtn.addTarget(target: self, action: #selector(self.performSelectedLeaveTypeOperation))
                cell.leaveMoreDetailButtonContainer.addGestureRecognizer(self.tapGestureMoreDetail)
                cell.animatingOpenCell()
                self.clearButton.layer.shadowOpacity = 0
            }
        })
    }
    
    @objc func closeCell() {
        
        if isCellOpen{
            
            guard let indexPath = selectedIndexPath else{return}
            
            leaveCV.deselectItem(at: indexPath, animated: true)
            guard let cell = leaveCV.cellForItem(at: indexPath) as? LeaveCVCell else{return}
            cell.animationCloceCell()
            self.clearButton.layer.shadowOpacity = 0.3
            
            leaveCV.performBatchUpdates(nil, completion: { isCompleted in
                cell.removeViewAfterCloseCell()
                self.leaveCV.isScrollEnabled = true
                self.leaveCV.showsVerticalScrollIndicator = true
                cell.mainContainer.removeGestureRecognizer(self.tapGestureCloseCell)
                cell.leaveMoreDetailButtonContainer.removeGestureRecognizer(self.tapGestureMoreDetail)
                self.isCellOpen = false
            })
            
        }
    }
    
    var targetCell:LeaveCVCell?{
        guard let indexPath = targetIndexPath else {return nil}
        guard let cell = leaveCV.cellForItem(at: indexPath) as? LeaveCVCell else{return nil}
        return cell
    }
    
    // MARK: - Navigation
    
    @objc fileprivate func segueToMoreDetail(){
        
        guard let cell = targetCell else{return}
        cell.leaveMoreDetailButtonContainer.buttonAnimation()
        
        guard let aboutLeaveTVC = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.aboutLeaveTVC) as? AboutSingleLeave else{return}
        aboutLeaveTVC.leaveTypeInfoOb = targetLeaveTypeInfoOb
        navigationController?.pushViewController(aboutLeaveTVC, animated: true)
        
    }
    
    
    
    @objc fileprivate func segueToNextPage(){
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.selectDatePage) as? SelectDaysViewController else{
            customAlert.pop(with: "System error happend.Error code is VC_Null:SE_DAY.Please connect with softwear provider.", "will concern", "Opps..!", #imageLiteral(resourceName: "system_error"))
            return
        }
        
        guard !selectedInfo.isEmpty else{
            customAlert.pop(with: "You don't have selected leave type.Please select before go to next.", "empty leave", "select one", #imageLiteral(resourceName: "empty_buket"))
            return
        }
        
        destinationViewController.selectedInfo = selectedInfo
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}

extension SelectLeaveTypeViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return leaveTypeInfoObs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.leaveCell, for: indexPath) as! LeaveCVCell
        
        let leaveTypeInfoOb = leaveTypeInfoObs[indexPath.item]
        cell.leaveTypeInfoOb = leaveTypeInfoOb
        cell.openCellHeight = bottomSectioHeight
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? LeaveCVCell else{return}
        targetLeaveTypeInfoOb = cell.leaveTypeInfoOb
        targetIndexPath = indexPath
        
        guard !isCellOpen else{return}
        openCell(collectionView, indexPath)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.indexPathsForSelectedItems?.first{
        case .some(indexPath):
            guard let cell = collectionView.cellForItem(at: indexPath)else{return cellItemSize}
            cell.frame.size = CGSize(width: cellItemSize.width, height: bottomSectioHeight)
            return  cell.frame.size
        default:return cellItemSize
            
        }
    }
}

struct SegueIdentifier {
    
    static let showSelectDays = "showSelectDays"
    static let showFillReason = "showFillReason"
    static let showFinalRequestForm = "showFinalRequestForm"
    static let enterApp = "enterApp"
    
}

