//
//  HeadImagesCVCell.swift
//  ShopHome
//
//  Created by kiran on 3/29/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class HeadImagesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func getIma(imge: String) {
        img.downloadImages(url: imge)
    }
}
