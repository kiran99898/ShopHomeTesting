//
//  ProductDetailsTVC.swift
//  ShopHome
//
//  Created by kiran on 3/27/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class ProductDetailsTVC: UITableViewController, SendImageUrl{
    func didTappedCell(imgUrl: String) {
        getIm(ur: imgUrl)
    }
    

    
    @IBOutlet weak var productHead: HeadView!

    
    var productDatas = ProductResponse(){
        didSet{
            descript = productDatas[0].description
            
            
            
            
            
            if productDatas[0].attributes.count != 0 {
                
                for productAttribute in productDatas[0].attributes{
                    productAttributes.append(productAttribute)
                    
                }
                
                for imgs in productDatas[0].images{
                    imges.append(imgs.src)
                }
                
                
            } else {
                print("no data in the array ")
            }
        }
    }
    
    var productAttributes = [Attribute]() {
        didSet{
            for prod in productAttributes {
                if prod.name == "Size"{
                    for size in prod.options {
                        sizes.append(size)
                    }
                }
                
                if prod.name == "Brands"{
                    for brand in prod.options {
                        brands.append(brand)
                    }
                }
                
                if prod.name == "Color" {
                    for color in prod.options {
                        colors.append(color)
                    }
                }
            }
            
        }
    }
    
    
    var sizes = [String]()
    var brands = [String]()
    var colors = [String]()
    var descript: String?
    var imges = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableView.automaticDimension


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        productHead.getDetail(img: productDatas[0].images[0].src, proTit: productDatas[0].name, proPric: productDatas[0].salePrice)
        productHead.images = imges
        productHead.del = self
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        if productDatas[0].attributes.count == 0 {
            if index == 0{
                return 0
            } else if index == 1 {
                return 0
            } else if index == 2 {
                return 0
            } else if index == 3 {
                return 0
            } else {
                return 100
            }
        } else {
            if index == 0 && sizes.count != 0{
                return 65
            } else if index == 1 && brands.count != 0 {
                return 50
            } else if index == 2 && colors.count != 0 {
                return 50
            } else if index == 3 && productDatas[0].description != ""{
                return  200
                
            } else if index == 4 {
                return 150
            } else {
                return 0
            }
            
        }
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SizeTVCell", for: indexPath) as! SizeTVCell
            if !sizes.isEmpty{
                cell.sizes = sizes
            }
            
            return cell
        } else if index == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Brand", for: indexPath)
            if !brands.isEmpty{
                cell.textLabel?.text = brands[0]
                
            }
            return cell
            
        } else if index == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Color", for: indexPath)
            if !colors.isEmpty{
                cell.textLabel?.text = colors[0]
            }
            return cell
            
        } else if index == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescTVC", for: indexPath) as! DescTVC
            if descript != "" {
                cell.htmlString = descript
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Recom", for: indexPath)
            return cell
            
        }
    }
    
    func getIm(ur: String) {
        _ = ApiManager.api.fetchImage(imageUrl: ur)
            .done({ (res) in
                let imageInfo = GSImageInfo(image: res, imageMode: .aspectFill)
                let transitationInfo = GSTransitionInfo(fromView: self.view)
                let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitationInfo)
                imageViewer.dismissCompletion = {
                    print("dismissed")
                }
                self.present(imageViewer, animated: true, completion: nil)
                

            })
        
        
        
    }

    
    
    
    
}
