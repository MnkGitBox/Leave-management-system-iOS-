//
//  Custom.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-07-04.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation
struct Comp{
    var name:String
    var value:String
    init(type:DateComponentType,value:Int) {
        
        name = type.rawValue
        self.value = String(value)
    }
}

