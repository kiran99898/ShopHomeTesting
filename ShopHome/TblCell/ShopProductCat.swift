//
//  ShopProductCat.swift
//  ShopHome
//
//  Created by kiran on 3/11/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class ShopProductCat: UITableViewCell {
    @IBOutlet weak var shopCatCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shopCatCV.delegate = self
        shopCatCV.dataSource = self
    }


}

extension ShopProductCat: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shopCatCV.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    
    
    
    
    
    
    
}
