//
//  AcceptProLayer.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class AcceptProLayer: CABaseLayer {
    
    override init(finalprecentage precentage: Float, drawInRect rect: CGRect) {
        super.init(finalprecentage: precentage, drawInRect: rect)
        
        self.finalPrecentage = precentage
        let ovalPath:CGPath = UIBezierPath(ovalIn: rect).cgPath
        
        configureLayers(using: ovalPath)
        
        self.addSublayer(trackBar)
        self.insertSublayer(progressBar, above: trackBar)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
