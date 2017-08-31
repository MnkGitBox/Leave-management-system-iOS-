//
//  UIImage.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-19.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView{
    
    func image(from urlString:String?){
        
        guard let urlString = urlString else{return}
        if let storeImg = imageCache.object(forKey: urlString as AnyObject){
            self.image = storeImg as? UIImage
            return
        }
        guard let url = URL(string: urlString)else{return}
        URLSession.shared.dataTask(with: url) { (data, responce, err) in
            guard err == nil else{return}
            guard let imgdata = data else{return}
            DispatchQueue.main.async {
                if let downloadedImg = UIImage(data: imgdata){
                    imageCache.setObject(downloadedImg, forKey: urlString as AnyObject)
                    self.image = downloadedImg
                }
            }
        }.resume()
    }
    
}
