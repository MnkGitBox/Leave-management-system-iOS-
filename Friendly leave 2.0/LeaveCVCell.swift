//
//  LeaveCVCell.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-29.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class LeaveCVCell: UICollectionViewCell {
    
    var leaveTypeInfoOb:LeaveTypeInfo?{
        
        didSet{
            
            guard let typeInfoOb = leaveTypeInfoOb else {return}
            name.text = typeInfoOb.name.capitalized
            
            if let imgName = typeInfoOb.profileImg {
                leaveIconImgView.image = UIImage(named: imgName)
            }
            
            findTimePeriod(usingCurr: typeInfoOb)
            
            remainNumber.text = String(typeInfoOb.remain)
            allocateNumber.text = String(typeInfoOb.reserved)
            
        }
    }
    var openCellHeight:CGFloat!
    var icoTopConstant:CGFloat!
    var defaultCellHeight:CGFloat!
    
    //    var icoImgSize:CGFloat{
    //        return 50 + (icoTopConstant * 2)
    //    }
    
    let normalTabSize:CGFloat = 44
    
    var  topTabHeight:CGFloat{
        return ((openCellHeight - defaultCellHeight) - (normalTabSize * 2))
    }
    
    let leaveIconImgView:UIImageView = {
        
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "default_ico")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    let name:UILabel = {
        let label = UILabel()
        label.text = "Default name"
        label.textColor = CustomColor.headingTxtColor
        label.font = UIFont.systemFont(ofSize: 16.5, weight:UIFontWeightRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seperator:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.seperatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let seperator2:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.seperatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let seperator3:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.seperatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellContainer:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.cellBackground
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0
        view.layer.masksToBounds = false
        return view
    }()
    
    let leaveNumbersContainer:UIView = {
        
        let view = UIView()
        view.backgroundColor = CustomColor.cellBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    let leaveSelectButtonContainer:UIView = {
        
        let view = UIView()
        view.backgroundColor = CustomColor.tableBackground
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leaveMoreDetailButtonContainer:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.cellBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let moredetail:UILabel = {
        let label = UILabel()
        label.textColor = CustomColor.blue
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        label.text = "More details"
        return label
    }()
    
    let disclosureIndicator:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Disclosure Indicator_Black").withRenderingMode(.alwaysTemplate)
        iv.tintColor = CustomColor.blue
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let pickLeaveBtn:CustomButton = {
        
        let btn = CustomButton()
        btn.titleLabel.text = "PICK THIS ONE"
        btn.titleLabel.textColor = CustomColor.whiteCream
        btn.backgroundColor = CustomColor.green
        btn.layer.cornerRadius = 3
        btn.clipsToBounds = true
        btn.titleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightRegular)
        btn.isShowShadow = false
        return btn
    }()
    
    let period:UILabel = {
        let label = UILabel()
        label.textColor = CustomColor.headingTxtColor
        label.text = "Month"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        return label
    }()
    
    let allocateContainer:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.lightIndigo
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    let remainContainer:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.lightIndigo
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    let remainName:UILabel = {
        let label = UILabel()
        label.text = "Left days"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        return label
    }()
    
    let allocateName:UILabel = {
        let label = UILabel()
        label.text = "Allocate days"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight:UIFontWeightRegular)
        return label
    }()
    
    let remainNumber:UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightRegular)
        return label
    }()
    
    let allocateNumber:UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight:UIFontWeightSemibold)
        return label
    }()
    
    let remainContainerSV:UIStackView = {
        
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let allocateContainerSV:UIStackView = {
        
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        defaultCellHeight = self.frame.height
        icoTopConstant =  (defaultCellHeight - 36) / 2
        
        cellContainer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        mainContainer.addSubview(cellContainer)
        
        addSubview(mainContainer)
        mainContainer.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainContainer.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        mainContainer.addSubview(leaveIconImgView)
        leaveIconImgView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 16).isActive = true
        leaveIconImgView.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: icoTopConstant).isActive = true
        
        leaveIconImgView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        leaveIconImgView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        mainContainer.addSubview(name)
        name.leftAnchor.constraint(equalTo: leaveIconImgView.rightAnchor, constant: 16).isActive = true
        name.centerYAnchor.constraint(equalTo: leaveIconImgView.centerYAnchor).isActive = true
        
        mainContainer.addSubview(seperator)
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperator.widthAnchor.constraint(equalToConstant: frame.width - 16).isActive = true
        seperator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seperator.topAnchor.constraint(equalTo: leaveIconImgView.bottomAnchor, constant: icoTopConstant - 1).isActive = true
        
    }
    
    fileprivate func findTimePeriod(usingCurr typeInfoOb:LeaveTypeInfo){
        
        if let timePeriod = typeInfoOb.period{
            switch timePeriod{
            case LeaveTypePeriod.year:
                guard let year = Date().toString(using: "yyyy")else{return}
                period.text = year
            case LeaveTypePeriod.month:
                guard let month = Date().toString(using: "MMMM")else{return}
                period.text = month.capitalized
            case LeaveTypePeriod.allTime:
                period.text = LeaveTypePeriod.allTime.capitalized
            default:break
            }
            
        }
    }
    
    var leaveNumTopAnchor:NSLayoutConstraint!
    var leaveNumHeightAnchor:NSLayoutConstraint!
    var leaveNumWidthAnchor:NSLayoutConstraint!
    var leaveNumCenterX:NSLayoutConstraint!
    
    var leaveMoreTopAnchor:NSLayoutConstraint!
    var leaveMoreHeightAnchor:NSLayoutConstraint!
    var leaveMoreWidthAnchor:NSLayoutConstraint!
    var leaveMoreCenterX:NSLayoutConstraint!
    
    var leaveMoreLabelLeftAnchor:NSLayoutConstraint!
    var leaveMoreLabelCenterX:NSLayoutConstraint!
    
    var leaveSelectTopAnchor:NSLayoutConstraint!
    var leaveSelectHeightAnchor:NSLayoutConstraint!
    var leaveSelectWidthAnchor:NSLayoutConstraint!
    var leaveSelectCenterX:NSLayoutConstraint!
    
    
    func layoutBigView(){
        
        //        mainContainer.addSubview(leaveNumbersContainer)
        mainContainer.insertSubview(leaveNumbersContainer, belowSubview: cellContainer)
        leaveNumTopAnchor =  leaveNumbersContainer.topAnchor.constraint(equalTo: seperator.bottomAnchor)
        leaveNumHeightAnchor = leaveNumbersContainer.heightAnchor.constraint(equalToConstant: topTabHeight)
        leaveNumWidthAnchor =  leaveNumbersContainer.widthAnchor.constraint(equalToConstant: self.frame.width)
        leaveNumCenterX = leaveNumbersContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
        leaveNumTopAnchor.isActive = true
        leaveNumHeightAnchor.isActive = true
        leaveNumWidthAnchor.isActive = true
        leaveNumCenterX.isActive = true
        
        period.frame = CGRect(x: 16, y: 8, width: 200, height: 16)
        leaveNumbersContainer.addSubview(period)
        
        allocateContainer.frame = CGRect(x: 32, y: 8 + 16 + 8, width: (frame.width / 2) - (32 + 8), height: topTabHeight - (8 + 16 + 8 + 8))
        leaveNumbersContainer.addSubview(allocateContainer)
        
        allocateContainerSV.addArrangedSubview(allocateNumber)
        allocateContainerSV.addArrangedSubview(allocateName)
        allocateContainer.addSubview(allocateContainerSV)
        allocateContainerSV.centerXAnchor.constraint(equalTo: allocateContainer.centerXAnchor).isActive = true
        allocateContainerSV.centerYAnchor.constraint(equalTo: allocateContainer.centerYAnchor).isActive = true
        
        
        remainContainer.frame = CGRect(x: (frame.width / 2) + 8, y: 8 + 16 + 8, width: (frame.width / 2) - (32 + 8), height: topTabHeight - (8 + 16 + 8 + 8))
        leaveNumbersContainer.addSubview(remainContainer)
        
        
        remainContainerSV.addArrangedSubview(remainNumber)
        remainContainerSV.addArrangedSubview(remainName)
        remainContainer.addSubview(remainContainerSV)
        remainContainerSV.centerXAnchor.constraint(equalTo: remainContainer.centerXAnchor).isActive = true
        remainContainerSV.centerYAnchor.constraint(equalTo: remainContainer.centerYAnchor).isActive = true
        
        
        seperator2.frame = CGRect(x: 8, y: topTabHeight - 1, width: frame.width - 16, height: 1)
        leaveNumbersContainer.addSubview(seperator2)
        
        mainContainer.addSubview(leaveMoreDetailButtonContainer)
        leaveMoreTopAnchor = leaveMoreDetailButtonContainer.topAnchor.constraint(equalTo: seperator.bottomAnchor)
        leaveMoreHeightAnchor = leaveMoreDetailButtonContainer.heightAnchor.constraint(equalToConstant: topTabHeight)
        leaveMoreWidthAnchor = leaveMoreDetailButtonContainer.widthAnchor.constraint(equalToConstant: self.frame.width)
        leaveMoreCenterX = leaveMoreDetailButtonContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
        leaveMoreTopAnchor.isActive = true
        leaveMoreHeightAnchor.isActive = true
        leaveMoreWidthAnchor.isActive = true
        leaveMoreCenterX.isActive = true
        
        moredetail.frame = CGRect(x: 16, y: 0, width: (frame.width / 4) * 3, height: normalTabSize)
        leaveMoreDetailButtonContainer.addSubview(moredetail)
        
        disclosureIndicator.frame = CGRect(x: frame.width - 25, y: 0, width: 9, height: normalTabSize)
        leaveMoreDetailButtonContainer.addSubview(disclosureIndicator)
        
        //        seperator3.frame = CGRect(x: 8, y: normalTabSize - 1, width: frame.width - 16, height: 1)
        //        leaveMoreDetailButtonContainer.addSubview(seperator3)
        
        
        mainContainer.addSubview(leaveSelectButtonContainer)
        leaveSelectTopAnchor = leaveSelectButtonContainer.topAnchor.constraint(equalTo: cellContainer.bottomAnchor)
        leaveSelectHeightAnchor = leaveSelectButtonContainer.heightAnchor.constraint(equalToConstant: topTabHeight)
        leaveSelectWidthAnchor =  leaveSelectButtonContainer.widthAnchor.constraint(equalToConstant: self.frame.width)
        leaveSelectCenterX = leaveSelectButtonContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
        leaveSelectTopAnchor.isActive = true
        leaveSelectHeightAnchor.isActive = true
        leaveSelectWidthAnchor.isActive = true
        leaveSelectCenterX.isActive = true
        
        pickLeaveBtn.frame = CGRect(x: 32, y: 8, width: frame.width - 64 , height: normalTabSize - 16)
        leaveSelectButtonContainer.addSubview(pickLeaveBtn)
        
    }
    
    func removeViewAfterCloseCell(){
        leaveNumbersContainer.removeConstraints([leaveNumTopAnchor,leaveNumHeightAnchor,leaveNumWidthAnchor,leaveNumCenterX])
        leaveMoreDetailButtonContainer.removeConstraints([leaveMoreCenterX,leaveMoreWidthAnchor,leaveMoreTopAnchor,leaveMoreHeightAnchor])
        leaveSelectButtonContainer.removeConstraints([leaveSelectCenterX,leaveSelectWidthAnchor,leaveSelectTopAnchor,leaveSelectHeightAnchor])
        
        leaveNumbersContainer.removeFromSuperview()
        leaveMoreDetailButtonContainer.removeFromSuperview()
        leaveSelectButtonContainer.removeFromSuperview()
        
    }
    
    
    func animatingOpenCell(){
        
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
            self.leaveSelectTopAnchor.constant = self.topTabHeight + self.normalTabSize
            self.leaveMoreTopAnchor.constant = self.topTabHeight
            
            self.cellContainer.backgroundColor = CustomColor.tableBackground
            self.cellContainer.layer.shadowOpacity = 0.35
            self.seperator.alpha = 0
            
            self.leaveSelectButtonContainer.layer.shadowOpacity = 0.3
            
            self.layoutIfNeeded()
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.4, options: .curveEaseOut, animations: {
            
            self.leaveSelectHeightAnchor.constant = self.normalTabSize
            self.leaveMoreHeightAnchor.constant = self.normalTabSize
            
            self.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    func animationCloceCell(){
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.cellContainer.backgroundColor = CustomColor.cellBackground
            self.cellContainer.layer.shadowOpacity = 0
            self.seperator.alpha = 1
            
            self.leaveSelectButtonContainer.layer.shadowOpacity = 0
            
            self.leaveNumHeightAnchor.constant = 0
            self.leaveSelectHeightAnchor.constant = 0
            self.leaveSelectTopAnchor.constant = 0
            self.leaveMoreHeightAnchor.constant = 0
            self.leaveMoreTopAnchor.constant = 0
            
            self.layoutIfNeeded()
            
        }, completion: nil)}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
