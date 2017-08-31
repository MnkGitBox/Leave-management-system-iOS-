//
//  ConfigureViewAnimation.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension SingleLeaveDetailsViewController{
    
    
    //MARK: - Configure Progress Bar Middle Circle Animation
    
    func playAnimation(){
        
        progressBarMiddleCircle.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.progressBarMiddleCircle.alpha = 1
            
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            
            self.progressBarMiddleCircle.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }) { (isComplete) in
            
            if isComplete{
                self.animateProgressBar()
            }
        }
        
    }
    
    fileprivate func animateProgressBar(){
        
        let barWidth:CGFloat = 15
        let contentViewFrame = progresBarContentView.frame
        
        let xSpace:CGFloat = ((contentViewFrame.width - 100) / 2) - (barWidth - 5)
        let ySpace:CGFloat = ((contentViewFrame.height - 100) / 2) - (barWidth - 5)
        
        
        let rect = CGRect(x: xSpace, y: ySpace, width: contentViewFrame.width - xSpace * 2, height: contentViewFrame.height - ySpace * 2)
        
        let progressAnimationLayes = ProgressBarLayer(finalprecentage: usedPrecen, drawInRect:rect)
        
        progressAnimationLayes.proLineWidth = barWidth
        progressAnimationLayes.proBarColor = UIColor.pinkCustom().cgColor
        progressAnimationLayes.trackBarColor = UIColor.pinkCustom().cgColor
        
        self.progresBarContentView.layer.insertSublayer(progressAnimationLayes, below: progressBarMiddleCircle.layer)
        
        progressAnimationLayes.animateProgressBar(currentProgress: { (currentProgress) in
            
            let precentage:Double = currentProgress * 100
            self.progressLabel.text = String(format: "%.0f", precentage) + "%"
            
        }) { (completed) in
            
            if completed{
                self.animateAccProBar()
            }
            
        }
        
    }
    
    fileprivate func animateAccProBar(){
        
        acceptProBarLayer.animate { [weak self]isCompleted in
            
            guard isCompleted else{return}
            guard let count = self?.acceptLeaveCount else{return}
            guard let floatPrecentage = self?.acceptPrecen else{return}
            let doublePrecentage = Double(floatPrecentage) * 100
            
            self?.acceptDays.text = String(describing: count)
            self?.acceptPrecentage.text = String(format: "%.0f", doublePrecentage)
            self?.animatePenProBar()
            
        }
    }
    
    fileprivate func animatePenProBar(){
        
        pendingProLayer.animate { [weak self]isCompleted in
            
            guard isCompleted else{return}
            guard let count = self?.pendingLeaveCount else{return}
            guard let floatPrecentage = self?.pendingPrecen else{return}
            let doublePrecentage = Double(floatPrecentage) * 100
            
            self?.pendingDays.text = String(describing: count)
            self?.pendingPrecentage.text = String(format: "%.0f", doublePrecentage)
            
            self?.animateRejProBar()
            
        }
        
    }
    
    fileprivate func animateRejProBar(){
        rejectProLayer.animate { [weak self]isCompleted in
            
            guard isCompleted else{return}
            guard let count = self?.rejectLeaveCount else{return}
            guard let floatPrecentage = self?.rejectPrecen else{return}
            let doublePrecentage = Double(floatPrecentage) * 100
            
            
            self?.rejectDays.text = String(count)
            self?.rejectPrecentage.text = String(format: "%.0F", doublePrecentage)
            
            
        }
    }
    
    
    
    
    
}
