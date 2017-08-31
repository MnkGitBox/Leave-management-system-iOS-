//
//  CustomAlertWithAnimation.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-15.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import Lottie

class CustomAlertWithAnimation: NSObject {
    
    fileprivate let effect = UIBlurEffect(style: .light)
    fileprivate let effectView = UIVisualEffectView()
    fileprivate let alertLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = CustomColor.nightBlue
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    fileprivate var springAnimationView:LOTAnimationView?
    
    override init() {
        super.init()
    }
    
    func popAlertAndAnimate(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        guard let window = appDelegate.window else{return}
        
        let mainBound = UIScreen.main.bounds
        
        effectView.frame = mainBound
        window.addSubview(effectView)
        
        springAnimationView = LOTAnimationView(name: "spring_boll")
        springAnimationView?.contentMode = .scaleAspectFit
        springAnimationView?.loopAnimation = true
        springAnimationView?.clipsToBounds = true
        
        guard let animationView = springAnimationView else{return}
        
        window.addSubview(animationView)
        animationView.frame.size = mainBound.size
        animationView.center = CGPoint(x: window.center.x, y: window.center.y - 32)
        
        animationView.alpha = 0
        
        UIView.animate(withDuration: 1, animations: {
            self.effectView.effect = self.effect
            animationView.alpha = 1
        }, completion: {(_) in
            self.springAnimationView?.play()
        })
        
    }
    
    func setResultAnimation(isFaild:Bool,alert:String, completion:@escaping (Bool)->Void){
        
        let animationName = isFaild ? "send_fail" : "send_succesfully"
        let labelTxtColor = isFaild ? CustomColor.red : CustomColor.blue
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        guard let window = appDelegate.window else{return}
        
        let mainBound = UIScreen.main.bounds
        
        springAnimationView?.pause()
        springAnimationView?.removeFromSuperview()
        springAnimationView = nil
        
        springAnimationView = LOTAnimationView(name: animationName)
        springAnimationView?.contentMode = .scaleAspectFit
        springAnimationView?.clipsToBounds = true
        
        guard let animationView = springAnimationView else{return}
        
        window.addSubview(animationView)
        animationView.frame.size = mainBound.size
        animationView.center = CGPoint(x: window.center.x, y: window.center.y - 32)
        
        alertLabel.alpha = 0
        alertLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        alertLabel.frame.size = CGSize(width: animationView.frame.size.width, height: 100)
        let alertLabelCenterY:CGFloat = (animationView.frame.size.height / 2) * 1.25
        alertLabel.center = CGPoint(x: window.center.x, y: alertLabelCenterY)
        window.addSubview(alertLabel)
        alertLabel.textColor = labelTxtColor
        alertLabel.text = alert.capitalized
        
        springAnimationView?.play(completion: { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.alertLabel.transform = CGAffineTransform.identity
                self.alertLabel.alpha = 1
            }, completion: { (_) in
                
                UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseInOut, animations: {
                    self.springAnimationView?.alpha = 0
                    self.alertLabel.alpha = 0
                }, completion: { (completed) in
                    self.effectView.effect = nil
                    self.effectView.removeFromSuperview()
                    self.springAnimationView?.removeFromSuperview()
                    self.alertLabel.removeFromSuperview()
                    completion(completed)
                })
                
            })
        })
        
        
    }
    
}
