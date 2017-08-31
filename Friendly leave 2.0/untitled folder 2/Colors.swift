//
//  Colors.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension UIColor{
    
    static func setColor(r:CGFloat, g:CGFloat, b:CGFloat)->UIColor{
        
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func turquoise() -> UIColor {
        return UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 0.9)
    }
    
    static func peterRiver() -> UIColor {
        return UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
    }
    static func alizarin() -> UIColor {
        return UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.8)
    }
    static func belizeHole() -> UIColor {
        return UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
    }
    static func coloud() -> UIColor {
        return UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
    }
    static func emerald() -> UIColor {
        return UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    }
    static func midNightBlue() -> UIColor {
        return UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
    }
    static func wet_asphalt() -> UIColor {
        return UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
    }
    static func silver() -> UIColor {
        return UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    }
    
    static func whiteGlass() -> UIColor {
        return UIColor(white: 1, alpha: 0.8)
    }
    
    static func greenSea() -> UIColor {
        return UIColor(red: 22/255, green: 160/255, blue: 133/255, alpha: 1)
    }
    
    
    static func background() -> UIColor {
        return UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    }
    static func headerBackGround() -> UIColor {
        return UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    }
    static func lineColor() -> UIColor {
        return UIColor(red: 206/255, green: 206/255, blue: 210/255, alpha: 1)
    }
    static func appleNews(alpha:CGFloat) -> UIColor {
        return UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: alpha)
    }
    static func skyBlue(alpha:CGFloat) -> UIColor {
        return UIColor(red: 26/255, green: 198/255, blue: 253/255, alpha: alpha)
    }
    
    static func monthDateColor(alpha:CGFloat) -> UIColor {
        return UIColor(red: 203/255, green: 208/255, blue: 215/255, alpha: alpha)
    }
    static func monthOutDateColor(alpha:CGFloat) -> UIColor {
        return UIColor(red: 226/255, green: 228/255, blue: 232/255, alpha: alpha)
    }
    
    static func calenderHeading(alpha:CGFloat) -> UIColor {
        return UIColor(red: 129/255, green: 131/255, blue: 135/255, alpha: alpha)
    }
    static func calenderHeadingBackground(alpha:CGFloat) -> UIColor {
        return UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: alpha)
    }
    
    static func naviBackground() -> UIColor {
        return UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
    }
    
    static func pinkCustom(using alpha:CGFloat = 1)->UIColor{

        return UIColor(red: 168/255, green: 169/255, blue: 252/255, alpha: alpha)
    
    }
    static func redReject(using alpha:CGFloat = 1)->UIColor{
        
        return UIColor(red: 254/255, green: 115/255, blue: 118/255, alpha: alpha)
        
    }
    static func greenAccept(using alpha:CGFloat = 1)->UIColor{
        
        return UIColor(red: 83/255, green: 232/255, blue: 161/255, alpha: alpha)
        
    }
    static func orangePending(using alpha:CGFloat = 1)->UIColor{
        
        return UIColor(red: 253/255, green: 191/255, blue: 122/255, alpha: alpha)
        
    }
    
    
}
