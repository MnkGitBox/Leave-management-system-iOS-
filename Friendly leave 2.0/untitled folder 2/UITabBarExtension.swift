//
//  UITabBarExtension.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-16.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension UITabBarController{
    
    func makeVisible(_ visible:Bool, isAnimated animated:Bool){
        
        guard visible != isVisible() else {return}
        
        let tabBarFrame = self.tabBar.frame
        let tabBarHeight = tabBarFrame.size.height
        let tabBarOffSetY = (visible ? -tabBarHeight : tabBarHeight)
        let duration:TimeInterval = (animated ? 0.3 : 0)
        
        UIView.animate(withDuration: duration) {
            
            self.tabBar.frame = tabBarFrame.offsetBy(dx: 0, dy: tabBarOffSetY)
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + tabBarOffSetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    func isVisible()->Bool{
        
        return self.tabBar.frame.origin.y < self.view.frame.maxY
        
    }
    
}
