//
//  CustomSearchController.swift
//  Custom SearchBar
//
//  Created by Malith Nadeeshan on 2017-07-18.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDeligate {
    
    func didStartSearching()
    func didtapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(searchtext:String)
}


class CustomSearchController: UISearchController {
    
    var customDeligate:CustomSearchControllerDeligate!
    
    var customSearchBar:CustomSearchBar!
    
    init(searchResultsController: UIViewController?, searchBarFrame frame:CGRect, font:UIFont, textColor:UIColor, tintColor:UIColor) {
        super.init(searchResultsController: searchResultsController)
        configureSearchbar(useSearchBar: frame, font: font, textColor: textColor, tinitColor: tintColor)
        
        
    }
    
    fileprivate func configureSearchbar(useSearchBar frame:CGRect, font:UIFont, textColor:UIColor, tinitColor:UIColor){
        
        customSearchBar = CustomSearchBar(frame: frame, font: font, textColor: textColor)
        customSearchBar.barTintColor = tinitColor
        
        customSearchBar.showsBookmarkButton = false
        customSearchBar.showsCancelButton = true
        
        customSearchBar.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
}

extension CustomSearchController:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        customDeligate.didStartSearching()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDeligate.didtapOnSearchButton()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customDeligate.didTapOnCancelButton()
        customSearchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        customDeligate.didChangeSearchText(searchtext: searchText)
    }
}



















