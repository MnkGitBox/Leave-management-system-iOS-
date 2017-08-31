//
//  NSNumber Ext.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-11.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation

extension NSNumber{
    
    func convertToDate()->Date?{
        
        let date = Date(timeIntervalSince1970: self.doubleValue)
        return date
    }

    
}
