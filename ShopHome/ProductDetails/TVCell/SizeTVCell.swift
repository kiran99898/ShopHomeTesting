//
//  SizeTVCell.swift
//  ShopHome
//
//  Created by kiran on 3/29/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class SizeTVCell: UITableViewCell {
    
    var previousSelected : IndexPath?
    var currentSelected : Int?
    
    @IBOutlet weak var sizeCV: UICollectionView!
    var sizes = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeCV.allowsMultipleSelection = false;
        
        sizeCV.delegate = self
        sizeCV.dataSource = self
        sizeCV.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension SizeTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sizeCV.dequeueReusableCell(withReuseIdentifier: "SizeCVCell", for: indexPath) as! SizeCVCell
        cell.sizeLbl.text = sizes[indexPath.row]

        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 24)
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = sizeCV.cellForItem(at: indexPath) as! SizeCVCell
        cell.toggleSelected()
        print("selected \(sizes[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = sizeCV.cellForItem(at: indexPath) as! SizeCVCell
        cell.toggleSelected()
    }
    
    
    
}




