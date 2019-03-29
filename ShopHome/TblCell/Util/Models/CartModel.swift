//
//  CartModel.swift
//  ShopHome
//
//  Created by kiran on 3/22/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation

class CartModel {
    var cartProductId: Int?
    var cartProductTitle: String?
    var cartProductPrice: String?
    var cartProductImageUrl: String?
    var cartProductQuantity: String?
    var cartProductColor: String?
    var cartProductDescription: String?
    var cartProductTotalPrice:String?
    var cartProductSize: String?
    
    init(cartPId: Int, cartPtitle: String, cartPPrice: String, cartPImageUrl: String, cartPQuantity: String, cartPColor: String, cartPDescription: String, cartPTotalPrice: String , cartProductSize: String) {
        self.cartProductId = cartPId
        self.cartProductColor = cartPColor
        self.cartProductTitle = cartPtitle
        self.cartProductPrice = cartPPrice
        self.cartProductImageUrl = cartPImageUrl
        self.cartProductQuantity = cartPQuantity
        self.cartProductDescription = cartPDescription
        self.cartProductTotalPrice = cartPTotalPrice
        self.cartProductSize = cartProductSize
    }
    
    
}
