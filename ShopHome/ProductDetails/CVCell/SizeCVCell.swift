//
//  SizeCVCell.swift
//  ShopHome
//
//  Created by kiran on 3/29/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class SizeCVCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeLbl: UILabel!
    
    func toggleSelected ()
    {
        if (isSelected){
            self.backgroundColor = UIColor.red
            self.sizeLbl.textColor = UIColor.red
        }else {
            self.backgroundColor = UIColor.gray
            self.sizeLbl.textColor = UIColor.gray
        }
    }
    
    
}
