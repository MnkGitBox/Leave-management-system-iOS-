
//
//  CircularTransmission.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-15.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class CircularTransmission: NSObject {
    
    fileprivate var circular = UIView()
    
    var startPoint:CGPoint = CGPoint.zero{
        didSet{
            circular.center = startPoint
        }
    }
    
    var circlColour = UIColor.white
    var duration:TimeInterval = 0.4
    
    enum CircularTransmissionMode:Int{
        case present, dismiss, pop
    }
    
    var transmissionMode:CircularTransmissionMode = .present
    
    
}
extension CircularTransmission:UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        if transmissionMode == .present{
            
            guard let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) else{return}
            let viewCenter = presentedView.center
            let viewSize = presentedView.frame.size
            
            circular = UIView()
            
            circular.frame = frameForCircle(withCenter: viewCenter, size: viewSize, start: startPoint)
            
            circular.layer.cornerRadius = circular.frame.size.height / 2
            circular.center = startPoint
            circular.backgroundColor = circlColour
            circular.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
            presentedView.center = startPoint
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedView.alpha = 0
            
            containerView.addSubview(presentedView)
            containerView.addSubview(circular)
            
            UIView.animate(withDuration: duration, animations: {
                self.circular.transform = CGAffineTransform.identity
                presentedView.transform = CGAffineTransform.identity
                presentedView.alpha = 1
                //                self.circular.alpha = 0.9
                presentedView.center = viewCenter
                
            }, completion: nil)
            
            UIView.animate(withDuration: 0.2, delay: 0.4, options: .curveEaseOut, animations: {
                
                self.circular.alpha = 0
                
            }, completion: { (success) in
                self.circular.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
            
            
        }else{
            
            let transitionKey = (transmissionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            guard let returnView = transitionContext.view(forKey: transitionKey)else{return}
            let viewCenter = returnView.center
            let viewSize = returnView.frame.size
            
            circular.frame = frameForCircle(withCenter: viewCenter, size: viewSize, start: startPoint)
            circular.center = startPoint
            circular.alpha = 1
            containerView.insertSubview(circular, aboveSubview: returnView)
            
            UIView.animate(withDuration: duration, animations: {
                
                self.circular.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returnView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returnView.center = self.startPoint
                //                self.circular.alpha = 1
                returnView.alpha = 0
                
                if self.transmissionMode == .pop{
                    containerView.insertSubview(returnView, belowSubview: returnView)
                    containerView.insertSubview(self.circular, belowSubview: returnView)
                }
                
            }, completion: { (success) in
                returnView.center = viewCenter
                returnView.removeFromSuperview()
                self.circular.removeFromSuperview()
                
                transitionContext.completeTransition(success)
                
            })
            
        }
        
    }
    
    fileprivate func frameForCircle(withCenter viewCenter:CGPoint, size viewSize:CGSize,start startPoint:CGPoint)->CGRect{
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offSetVector = sqrt((xLength * xLength) + (yLength * yLength)) * 2
        let size = CGSize(width: offSetVector, height: offSetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
}





















