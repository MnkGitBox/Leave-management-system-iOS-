//
//  RejectProLayer.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class RejectProLayer: CABaseLayer {
    
    override init(finalprecentage precentage: Float, drawInRect rect: CGRect) {
        super.init(finalprecentage: precentage, drawInRect: rect)
        
        finalPrecentage = precentage
        let oval:CGPath = UIBezierPath(ovalIn: rect).cgPath
        configureLayers(using: oval)
        
        self.addSublayer(trackBar)
        self.insertSublayer(progressBar, above: trackBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
