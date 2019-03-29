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
    let messageTextViewMaxHeight: CGFloat = 300
    var htmlString: String? {
        didSet{
        txtView.attributedText = htmlString?.htmlAttributed(family: "Avenir", size: 10, color: UIColor.gray)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtView.delegate = self
        
    }


}

extension DescTVC: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView)
    {
        if textView.contentSize.height >= self.messageTextViewMaxHeight
        {
            txtView.isScrollEnabled = true
        }
        else
        {
            textView.frame.size.height = textView.contentSize.height
            txtView.isScrollEnabled = false
        }
    }
    
    
}
