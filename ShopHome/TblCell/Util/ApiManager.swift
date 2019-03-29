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

class ApiManager {
    let urlll =    "https://www.ozairamall.com/wp-json/dokan/v1/stores/80/products?page=2&per_page=10"
    
    let checkoutBaseUrl = "https://ozairamall.com/wp-json/wc/v2/orders?consumer_key=ck_1b2b8463a50b1141387266c989d052aee4f62869&consumer_secret=cs_bf9054b968751d8abf8fe409b7213407d3a9543f"
    
    static let api = ApiManager()
    private init(){}
    
    
    func fetchDataRegisterUser() -> Promise<CheckoutOrdersModel> {
        
        return Promise {
            resolver in
            
            Alamofire.request(urlll).responseString{
                response in
                
                switch(response.result){
                case .success(let data):
                    if let json = data.data(using: .utf8){
                        
                        do{
                            let responseData = try JSONDecoder().decode(CheckoutOrdersModel.self, from: json)
                            
                            resolver.fulfill(responseData)
                            
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
    
    func checkOutOrdersNew(jsonString: Data)-> Promise<CheckoutOrdersModel>{
        
        return Promise {
            resolver in
            
            let urlString = checkoutBaseUrl
            let json = jsonString
            
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = json
            
            Alamofire.request(request).responseString {
                (response) in
                
                switch(response.result){
                case .success(let data):
                    if let json = data.data(using: .utf8){
                        do{
                            let responseData = try JSONDecoder().decode(CheckoutOrdersModel.self, from: json)
                            resolver.fulfill(responseData)
                            
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
    
    func fetchProductsDatafromCatagoryId(params:[String: Any]) -> Promise<ProductResponse> {
        
        return Promise {
            resolver in
            
            Alamofire.request(GET_PRODUCTS_FROM_CATID_URL, parameters: params).responseString{
                response in
                
                switch(response.result){
                case .success(let data):
                    
                    var productsArray = ProductResponse()
                    //error response shol be handled
                    
                    if let json = data.data(using: .utf8){
                        
                        do {
                            let productsResponse = try JSONDecoder().decode(ProductResponse.self, from: json)
                            for prRes in productsResponse {
                                productsArray.append(prRes)
                            }
                            
                            resolver.fulfill(productsArray)
                            
                        }catch(let error){
                            print(error)
                            
                        }
                        
                    }
                    
                    
                    // print("my actual response is :- ",data)
                    
                case .failure(let error):
                    resolver.reject(error)
                    print(error)
                }
            }
            
        }
        
    }
    
}

