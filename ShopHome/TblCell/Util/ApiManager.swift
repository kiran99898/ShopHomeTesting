//
//  ApiManager.swift
//  ShopHome
//
//  Created by kiran on 3/11/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class ApiManager{
let urlll =    "https://www.ozairamall.com/wp-json/dokan/v1/stores/80/products?page=1&per_page=10"
    
 
    static let api = ApiManager()
    private init(){}


func fetchDataRegisterUser() -> Promise<ShopProductsRootModel> {
    
    return Promise {
        resolver in
        
        Alamofire.request(urlll).responseString{
            response in
            
            switch(response.result){
            case .success(let data):
                var arr = ShopProductsRootModel()
                if let json = data.data(using: .utf8){
                    
                    do{
                        let responseData = try JSONDecoder().decode(ShopProductsRootModel.self, from: json)
                        
                        for res in responseData{
                            arr.append(res)
                        }
                        resolver.fulfill(arr)
                        
                    }catch(let error){
                        print(error)
                        
                    }
                    
                }
                
                
              //  print("my actual response is :- ",data)
                
            case .failure(let error):
                resolver.reject(error)
                print(error)
            }
        }
        
    }
    
    
    
}
    
    
}

