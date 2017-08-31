//
//  CustomSearchBar.swift
//  Custom SearchBar
//
//  Created by Malith Nadeeshan on 2017-07-18.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    var prefFont:UIFont!
    var preftextColor:UIColor!
    var defaultLineColor = CustomColor.green.cgColor
    
    
    init(frame: CGRect, font:UIFont, textColor:UIColor) {
        super.init(frame: frame)
        self.frame = frame
        self.prefFont = font
        self.preftextColor = textColor
        
        searchBarStyle = .prominent
        isTranslucent = true
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let index = indexOfSearchFieldOfSubviews() else{return}
        
        guard let searchField = subviews[0].subviews[index] as? UITextField else{return}
        
        var searchBarWidth:CGFloat = 0
        
        if let button = subviews[0].subviews[2] as? UIButton{
            
            searchBarWidth = button.frame.size.width + 8 + 8 + 8
        }
        
        searchField.frame = CGRect(x: 8, y: 6, width: frame.size.width - searchBarWidth, height: frame.size.height - 12)
        searchField.textColor = preftextColor
        searchField.font = prefFont
        searchField.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        super.draw(rect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    fileprivate func indexOfSearchFieldOfSubviews()->Int?{
        
        var index:Int?
        let searchBarViews = subviews[0].subviews
        
        for (item,view) in searchBarViews.enumerated(){
            
            if view.isKind(of: UITextField.self){
                index = item
                break
            }
            
        }
        
        return index
    }
    
}














