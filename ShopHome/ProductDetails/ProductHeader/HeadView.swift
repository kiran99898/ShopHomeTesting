//
//  HeadView.swift
//  ShopHome
//
//  Created by kiran on 3/29/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class HeadView: UIView {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var headImages: UICollectionView!
    var del:SendImageUrl? = nil

    
    var images = [String](){
        didSet{
            headImages.delegate = self
            headImages.dataSource = self
            headImages.reloadData()
        }
    }
    
    func getDetail(img: String, proTit: String, proPric: String){
        productTitle.text = proTit
        productPrice.text = proPric
        
    }
    
}

extension HeadView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headImages.dequeueReusableCell(withReuseIdentifier: "HeadImagesCVCell", for: indexPath) as! HeadImagesCVCell
        let imgg = images[indexPath.row]
        cell.getIma(imge: imgg)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath:  IndexPath) -> CGSize {
        let size = headImages.frame.size
        return CGSize(width: size.width, height:size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let tappedImageUrl = images[indexPath.row]
        
        del!.didTappedCell(imgUrl: tappedImageUrl)
    }
    
    
    
}
