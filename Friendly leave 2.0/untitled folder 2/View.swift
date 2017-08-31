//
//  View.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-24.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    
//MARK: - Constrint Methods
    func addConstainWith(visualFormat:String, views: UIView...){
        
        var viewsDictionary = [String:UIView]()
        
        for (index,view) in views.enumerated(){
            
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            
        }
    }
    
   
//MARK: - Corner Radius To Selected Sides
    
    func setRadius(of value:CGFloat,to corners:UIRectCorner){
        
        let rectShapeLayer = CAShapeLayer()
        rectShapeLayer.bounds = self.frame
        rectShapeLayer.position = self.center
        rectShapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: value, height: value)).cgPath
        
        self.layer.mask = rectShapeLayer
    }
    
    func buttonAnimation() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    

}
