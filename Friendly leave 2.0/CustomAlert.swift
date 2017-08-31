//
//  CustomAlertView.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-14.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class CustomAlert:NSObject{
    
    fileprivate let alertViewContainer:UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var okButton:CustomButton = {
        let btn = CustomButton()
        btn.addTarget(target: self, action: #selector(performClose))
        btn.titleLabel.text = "OK"
        btn.titleLabel.textColor = UserColor(withHexValue: "#31B9F1")
        btn.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isShowShadow = false
        btn.isTopBorder = true
        btn.topBorder.backgroundColor = CustomColor.lightGray
        return btn
    }()
    
    fileprivate let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    fileprivate let alertTitle:UILabel = {
        let label = UILabel();
        label.text = "Heading";
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
        label.textColor = UserColor(withHexValue: "#3C415D")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let alert:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = CustomColor.ash
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
        label.minimumScaleFactor = 0.75
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let blackView = UIView()
    
    override init() {
        super.init()
        layoutSubViews()
    }
    
    //MARK: - Single View AlertView With Ok button
    
    fileprivate func layoutSubViews(){
        
        alertViewContainer.addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: alertViewContainer.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: alertViewContainer.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: alertViewContainer.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: alertViewContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        alertViewContainer.addSubview(alertTitle)
        alertTitle.rightAnchor.constraint(equalTo: alertViewContainer.rightAnchor, constant:-16).isActive = true
        alertTitle.leftAnchor.constraint(equalTo: alertViewContainer.leftAnchor, constant:16).isActive = true
        alertTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4).isActive = true
        alertTitle.heightAnchor.constraint(equalTo: alertViewContainer.heightAnchor, multiplier: 0.1).isActive = true
        alertViewContainer.addSubview(alert)
        alert.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: 4).isActive = true
        alert.leftAnchor.constraint(equalTo: alertViewContainer.leftAnchor, constant: 16).isActive = true
        alert.rightAnchor.constraint(equalTo: alertViewContainer.rightAnchor, constant: -16).isActive = true
        alert.heightAnchor.constraint(lessThanOrEqualTo: alertViewContainer.heightAnchor, multiplier: 0.21).isActive = true
        
        alertViewContainer.addSubview(okButton)
        okButton.leftAnchor.constraint(equalTo: alertViewContainer.leftAnchor, constant:16).isActive = true
        okButton.rightAnchor.constraint(equalTo: alertViewContainer.rightAnchor, constant:-16).isActive = true
        okButton.bottomAnchor.constraint(equalTo: alertViewContainer.bottomAnchor).isActive = true
        okButton.heightAnchor.constraint(equalTo: alertViewContainer.heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    func pop(with alertMessage:String,_ heading:String,_ btnTitle:String,_ image:UIImage){
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        guard let window = appdelegate.window else{return}
        
        blackView.backgroundColor = .black
        blackView.alpha = 0
        blackView.frame = UIScreen.main.bounds
        window.addSubview(blackView)
        
        alertTitle.text = heading.capitalized
        imageView.image = image
        okButton.titleLabel.text = btnTitle.uppercased()
        
        window.addSubview(alertViewContainer)
        alertViewContainer.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 32).isActive = true
        alertViewContainer.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -32).isActive = true
        alertViewContainer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2).isActive = true
        alertViewContainer.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        
        alertViewContainer.alpha = 0
        alertViewContainer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        alert.text = alertMessage
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            
            self.blackView.alpha = 0.5
            self.alertViewContainer.alpha = 1
            self.alertViewContainer.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
    }
    
    @objc fileprivate func performClose(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            self.alertViewContainer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.alertViewContainer.alpha = 0
            
        }) { isCompleted in
            self.alertViewContainer.removeFromSuperview()
            self.blackView.removeFromSuperview()
        }
        
        
    }
    
    
    
    
}
