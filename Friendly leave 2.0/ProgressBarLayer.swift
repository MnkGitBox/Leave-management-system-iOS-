//
//  ProgressBarLayer.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class ProgressBarLayer: CABaseLayer {
    
    override init(finalprecentage precentage:Float,drawInRect rect:CGRect) {
        super.init(finalprecentage: precentage, drawInRect: rect)
        
        let circlePath:CGPath = UIBezierPath(ovalIn: rect).cgPath
        self.finalPrecentage = precentage
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            
            self.configureLayers(withPath: circlePath)
            
            DispatchQueue.main.async {
                
                self.progressBar.add(self.animatioOpacityProgBar(), forKey: "bar_opacity")
                
                self.trackBar.add(self.animationOpacity(), forKey: "track_opacity")
                self.insertSublayer(self.trackBar, below: self.progressBar)
                
                
            }
            
            
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func configureLayers(withPath path:CGPath){
        
        progressBar.path = path
        progressBar.fillColor = fillColor
        progressBar.strokeColor = proBarColor
        progressBar.lineWidth = proLineWidth
        progressBar.strokeStart = 0
        progressBar.strokeEnd = 0
        progressBar.opacity = 1
        
        trackBar.path = path
        trackBar.fillColor = fillColor
        trackBar.strokeColor = trackBarColor
        trackBar.opacity = 0.4
        trackBar.lineWidth = proLineWidth
        trackBar.strokeStart = 0
        trackBar.strokeEnd = 1
        
    }
    
    
    fileprivate func animatioOpacityProgBar()->CABasicAnimation{
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        
        return animation
    }
    
    fileprivate func animationOpacity()->CAKeyframeAnimation{
        
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.keyTimes = [0,1]
        animation.values = [0,0.4]
        animation.duration = animationDuration
        animation.timingFunction =  CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        return animation
        
    }
    
    func animateProgressBar(currentProgress:@escaping (Double)->(),complted:@escaping (Bool)->()){
        
        addSublayer(progressBar)
        var currentPro:TimeInterval = 0.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self]fireTime in
            
            currentPro = currentPro + fireTime.timeInterval
            
            guard self?.finalPrecentage != 0.0 else{
                currentProgress(0)
                complted(true)
                self?.timerInvalidate()
                return
            }
            
            guard !(self?.isCompletedCheck(usingCurrent: currentPro))! else{
                currentProgress(Double(currentPro))
                complted(true)
                return
            }
            
            self?.progressBar.strokeEnd = CGFloat(currentPro)
            currentProgress(Double(currentPro))
            
        })
        
        
    }
    
    
    fileprivate func isCompletedCheck(usingCurrent progress:TimeInterval )->Bool{
        
        let endpro:String = String(format: "%.2f", Double(finalPrecentage))
        
        if String(format: "%.2f", Double(progress)) == endpro{
            
            progressBar.strokeEnd = CGFloat(progress)
            timerInvalidate()
            return true
            
        }
        
        
        return false
        
    }
    
    fileprivate func timerInvalidate(){
        
        timer?.invalidate()
        timer = nil
        
    }
    
    
    
    
}
