//
//  DownloadImg.swift
//  ShopHome
//
//  Created by kiran on 3/29/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func downloadImages(url: String) {
        let url = URL(string: url)
        image = nil
        if let imagesFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imagesFromCache
            return
        }
        if url != nil {
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.sync {
                    if let imageToCache = UIImage(data: data!) {
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                        self.image = imageToCache
                    }
                }
                }.resume()
            
            
        }
        
    }
}
