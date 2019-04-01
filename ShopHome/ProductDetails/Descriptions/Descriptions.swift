//
//  Descriptions.swift
//  ShopHome
//
//  Created by kiran on 3/31/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class Descriptions: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var textViewWrapper: UIView!
    @IBOutlet weak var txtView: UITextView!
    var fullDescription: String?
    @IBOutlet weak var textViewWrapperHeight: NSLayoutConstraint!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUITextViewHeight(arg: txtView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mainView.addGestureRecognizer(tap)
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func adjustUITextViewHeight(arg : UITextView){
        textViewHeight.constant = arg.contentSize.height
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.attributedText = fullDescription?.htmlAttributed(family: "Avenir", size: 8, color: UIColor.gray)
        arg.textContainer.lineBreakMode = .byTruncatingTail
      //  arg.isScrollEnabled = false
        
        print(" textview height: \(arg.frame.size.height)")
        print("uiscreen height: \(UIScreen.main.bounds.size.height)")
        
        if arg.contentSize.height >= UIScreen.main.bounds.size.height - 500 {
            textViewWrapperHeight.constant = 200
            arg.isScrollEnabled = true
            
        } else {
            textViewWrapperHeight.constant = textViewHeight.constant
            //arg.isScrollEnabled = true
        }
        
    }
    
    
    
}
