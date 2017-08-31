//
//  CustomButton.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-25.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class CustomButton: UIView {
    
    fileprivate let tapGesture = UITapGestureRecognizer()
    
    var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Button"
        return label
    }()
    
    var isEnabled:Bool{
        get{
            guard self.isUserInteractionEnabled else{return false}
            return true
        }
        set{
            if newValue{
                self.isUserInteractionEnabled = true
                self.alpha = 1
                self.layer.shadowOpacity = 0.3
            }else{
                self.isUserInteractionEnabled = false
                self.alpha = 0.6
                guard !isShadowNeedDisabled else{return}
                self.layer.shadowOpacity = 0
            }
        }
    }
    
    var isShadowNeedDisabled:Bool = false
    var isShowShadow:Bool = true{
        didSet{
            if !isShowShadow{
                self.layer.shadowColor = UIColor.clear.cgColor
            }
        }
    }
    var isTopBorder:Bool = false{
        didSet{
            if isTopBorder{
                
                topBorder.isHidden = false
            }
        }
    }
    var topBorder:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var borderThikness:CGFloat = 1{
        didSet{
            topBorder.heightAnchor.constraint(equalToConstant: borderThikness).isActive = true
        }
    }
    
    var imageTintColor:UIColor = .blue{
        didSet{
            imageView.tintColor = imageTintColor
        }
    }
    
    
    
    var imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var springWithDumpingVal:CGFloat = 0.2
    var initialSpringVelocityVal:CGFloat = 20
    fileprivate var titleLabeleLeading:NSLayoutXAxisAnchor!
    fileprivate var titleLabelLeadingConstrain:NSLayoutConstraint!
    fileprivate var titleLabelTrailing:NSLayoutXAxisAnchor!
    fileprivate var titleLabelTrailingConstant:NSLayoutConstraint!
    fileprivate var titleLabelCenterX:NSLayoutConstraint!
    
    fileprivate var imageLeadingConstraint:NSLayoutConstraint!
    fileprivate var imageTrailingConstraint:NSLayoutConstraint!
    fileprivate var imageTopConstraint:NSLayoutConstraint!
    
    var titleLeftInset:CGFloat = 8{
        didSet{
            titleLabelLeadingConstrain.constant = titleLeftInset
        }
    }
    var titleRightInset:CGFloat = -8{
        didSet{
            titleLabelTrailingConstant.constant = titleRightInset
        }
    }
    var imageLeftInset:CGFloat = 8{
        didSet{
            imageLeadingConstraint.constant = imageLeftInset
        }
    }
    var imageRightInset:CGFloat = 8{
        didSet{
            imageTrailingConstraint.constant = imageRightInset
        }
    }
    var imageTopInset:CGFloat = 8{
        didSet{
            imageTopConstraint.constant = imageTopInset
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func defaultSetting() {
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
        
        self.backgroundColor = .clear
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
        
        self.addSubview(topBorder)
        topBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        topBorder.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: borderThikness).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabelCenterX =  titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        titleLabeleLeading = titleLabel.leftAnchor
        titleLabelTrailing = titleLabel.rightAnchor
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabelCenterX.isActive = true
        
        
    }
    
    func addTarget(target:Any,action:Selector){
        tapGesture.addTarget(target, action: action)
    }
    
    fileprivate func animateButton(){
        
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.alpha = 0.8
        }
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: springWithDumpingVal, initialSpringVelocity: initialSpringVelocityVal, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 1
        }, completion: nil)
    }
    
    func setImageButton(of image:UIImage,in size:CGSize, shapeUsingButtonRadius cornerRadius:CGFloat){
        titleLabel.removeFromSuperview()
        
        imageView.image = image
        self.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        
        self.layer.cornerRadius = cornerRadius
        imageView.layer.cornerRadius = cornerRadius
    }
    
    
    func setImage(image:UIImage,to side:Side, in size:CGSize = CGSize(width: 28, height: 28)){
        
        titleLabelCenterX.isActive = false
        imageView.image = image
        self.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        
        switch side {
        case .left:
            imageLeadingConstraint = imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: imageLeftInset)
            titleLabelLeadingConstrain =  titleLabeleLeading.constraint(equalTo: imageView.rightAnchor, constant: titleLeftInset)
            titleLabelTrailingConstant = titleLabelTrailing.constraint(equalTo: self.rightAnchor, constant: titleRightInset)
            
            imageLeadingConstraint.isActive = true
            titleLabelLeadingConstrain.isActive = true
            titleLabelTrailingConstant.isActive = true
        case .right:
            imageTrailingConstraint =  imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: imageRightInset)
            titleLabelTrailingConstant =  titleLabelTrailing.constraint(equalTo: imageView.leftAnchor, constant: titleRightInset)
            titleLabelLeadingConstrain =  titleLabeleLeading.constraint(equalTo: self.leftAnchor, constant: titleLeftInset)
            
            imageTrailingConstraint.isActive = true
            titleLabelLeadingConstrain.isActive = true
            titleLabelTrailingConstant.isActive = true
        }
        
    }
    
}


extension CustomButton:UIGestureRecognizerDelegate{
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        animateButton()
        return true
    }
    
}













