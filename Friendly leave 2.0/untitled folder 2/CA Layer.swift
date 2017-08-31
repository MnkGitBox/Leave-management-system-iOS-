//
//  CA Layer.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-01.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension CALayer{
    
    func addBorder(of edge:UIRectEdge,to color:UIColor,borderThickness thickness:CGFloat){
        
        let borderMask = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            borderMask.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
            
        case UIRectEdge.bottom:
            borderMask.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
            
        case UIRectEdge.left:
            borderMask.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
            
        case UIRectEdge.right:
            borderMask.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
        default:break
        }
        
        borderMask.backgroundColor = color.cgColor
        self.addSublayer(borderMask)
        
    }

}
