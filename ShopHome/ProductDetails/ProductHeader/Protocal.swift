//
//  Protocal.swift
//  ShopHome
//
//  Created by kiran on 3/29/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation

protocol SendImageUrl: NSObjectProtocol {
    func didTappedCell(imgUrl: String)
}



protocol SendBool: class {
    func didSeeMoreButtonTapped(isSeeMoreTapped: Int)
    
}


protocol SendHeight: class {
    var height: Int { get set }
}
