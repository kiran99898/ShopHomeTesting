//
//  Shop.swift
//  ShopHome
//
//  Created by kiran on 3/11/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class Shop: UITableViewController {
    
    var catagory = 15
    var products = ProductResponse() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProductsfromCatId(catId: catagory)
        
    }
    
    func getProductsfromCatId(catId: Int){
        let param = PostPacket.shared.getProductsfromCatId(catId: catId)
        _ = ApiManager.api.fetchProductsDatafromCatagoryId(params: param)
            .done({ (res) in
                self.products = res
            })
        
    }

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopProductCat") as! ShopProductCat
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetails = products[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier:"ProductDetailsTVC") as! ProductDetailsTVC
        vc.productDatas = [productDetails]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

