//
//  PostPacket.swift
//  ShopHome
//
//  Created by kiran on 3/22/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation


extension String {
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


class PostPacket {
    typealias packet = [String: Any]
    static let shared = PostPacket()
    private init(){}
    
    func getProductsfromCatId(catId: Int) -> packet{
        var dict = packet()
        dict["category"] = catId
        dict["consumer_key"] = "ck_1b2b8463a50b1141387266c989d052aee4f62869"
        dict["consumer_secret"] = "cs_bf9054b968751d8abf8fe409b7213407d3a9543f"
        return dict
        
    }
    
    
}

