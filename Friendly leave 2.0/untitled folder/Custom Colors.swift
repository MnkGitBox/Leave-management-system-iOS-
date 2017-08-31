//
//  Custom Colors.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-23.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

struct CustomColor{
    
    static let lightGray:UIColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
    static let pink:UIColor = UIColor(red: 168/255, green: 169/255, blue: 252/255, alpha: 1)
    static let extraLightPink = UIColor(red: 192/255, green: 210/255, blue: 237/255, alpha: 1)
    static let midNightBlue = UIColor(red: 41/255, green: 82/255, blue: 117/255, alpha: 1)
    static let green = UserColor(withHexValue: "#16A085")
    static let lightIndigo = UIColor(red: 130/255, green: 166/255, blue: 220/255, alpha: 1)
    static let blue = UserColor(withHexValue: "31B9F1")
    static let red = UserColor(withHexValue: "#E74C3C")
    static let extraLightIndigo = UIColor(red: 218/255, green: 216/255, blue: 235/255, alpha: 1)
    static let turqueGreen = UserColor(withHexValue: "#3DA4AB")
    static let whiteCream = UserColor(withHexValue: "#ECF0F1")
    static let darkAsh = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    static let ash = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
    static let nightBlue = UIColor(red: 26/255, green: 76/255, blue: 109/255, alpha: 1)
    static let calenderRed = UIColor(red: 254/255, green: 115/255, blue: 118/255, alpha: 1)
    static let darkGreen = UIColor(red: 0/255, green: 136/255, blue: 145/255, alpha: 1)
    static let seperatorColor = UserColor(withHexValue: "#DBDDE2")
    static let placeHolder = UserColor(withHexValue: "#DBDDE2")
    static let subHeadingTxtColor = UserColor(withHexValue: "#60646D")
    static let darkBlue = UIColor(red: 29/255, green: 98/255, blue: 139/255, alpha: 1)
    static let orange = UserColor(withHexValue: "#E67E22")
    static let shadowBlue = UserColor(withHexValue: "#45A4D0")
    static let darkIndigo = UIColor(red: 149/255, green: 49/255, blue: 99/255, alpha: 1)
    
    static let cellBackground = UserColor(withHexValue: "#F5F5F5")
    static let tableBackground = UserColor(withHexValue:"#DBDDE2")
    static let headingTxtColor = UserColor(withHexValue: "#3C415D")
    static let yellow = UserColor(withHexValue: "#F1C40F")
    static let subtitleColor = UserColor(withHexValue: "#B4B9C3")
    
}

class UserColor: UIColor {
    
    convenience init(withHexValue hex:String) {
        
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#"){
            cString.remove(at: cString.startIndex)
        }
        guard cString.characters.count == 6 else{
            self.init(white: 0.5, alpha: 1)
            return
        }
        
        var rgbVal:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbVal)
        
        self.init(red: CGFloat((rgbVal & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbVal & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbVal & 0x0000FF) / 255.0,
                  alpha: 1)
    }
    
}



