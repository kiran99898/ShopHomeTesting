//
//  DescTVC.swift
//  ShopHome
//
//  Created by kiran on 3/29/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class DescTVC: UITableViewCell {
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var seeMoreLabel: UILabel!
    
    
    
    var messageTextViewMaxHeight = 150
    
    var htmlString: String? {
        didSet{
            txtView.attributedText = htmlString?.htmlAttributed(family: "Avenir", size: 10, color: UIColor.gray)
            txtView.delegate = self
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
}

extension DescTVC: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView)
    {
        if Int(textView.contentSize.height) >= self.messageTextViewMaxHeight
        {
            txtView.isScrollEnabled = true
            seeMoreLabel.isHidden = false
        }else{
            txtView.isScrollEnabled = false
            seeMoreLabel.isHidden = false
            
        }
    }
    
    
}
