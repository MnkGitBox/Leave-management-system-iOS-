//
//  CABaseLayer.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class CABaseLayer: CALayer {
    
    var progressBar = CAShapeLayer()
    var trackBar = CAShapeLayer()
    
    var proBarColor:CGColor = UIColor.turquoise().cgColor{
        didSet{
            progressBar.strokeColor = proBarColor
        }
    }
    var trackBarColor:CGColor = UIColor.turquoise().cgColor{
        didSet{
            trackBar.strokeColor = trackBarColor
        }
    }
    
    var proLineWidth:CGFloat = 10{
        didSet{
            progressBar.lineWidth = proLineWidth
            trackBar.lineWidth = proLineWidth
            //            progressBarShadow.lineWidth = proLineWidth
        }
    }
    var fillColor:CGColor = UIColor.clear.cgColor{
        didSet{
            trackBar.fillColor = fillColor
        }
    }
    
    var animationDuration:TimeInterval = 1
    var finalPrecentage:Float = 0
    
    var timer:Timer?
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(finalprecentage precentage:Float,drawInRect rect:CGRect) {
        super.init()
        
    }
    func configureLayers(using ovalPath: CGPath) {
        progressBar.path = ovalPath
        progressBar.fillColor = fillColor
        progressBar.strokeColor = proBarColor
        progressBar.lineWidth = proLineWidth
        progressBar.strokeStart = 0
        progressBar.strokeEnd = 0
        
        trackBar.path = ovalPath
        trackBar.fillColor = fillColor
        trackBar.strokeColor = proBarColor
        trackBar.strokeStart = 0
        trackBar.strokeEnd = 1
        trackBar.opacity = 1
        trackBar.lineWidth = proLineWidth
    }
    
    fileprivate func animationStrockEnd()->CABasicAnimation{
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = finalPrecentage
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        return animation
        
    }
    
    func animate(complete:@escaping (Bool)->Void){
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            complete(true)
        }
        progressBar.add(animationStrockEnd(), forKey: "progressBarAnimation")
        CATransaction.commit()
        
    }
    
}
