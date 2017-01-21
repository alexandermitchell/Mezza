//
//  ProductModel.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/13/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Product {
    var uid: String
    var description: String
    var sellerUID: String
    var sizes = [Size]()
    var images = [String]()
    var title: String
    
    init(uid: String, description: String, sellerUID: String, title: String){
        self.uid = uid
        self.description = description
        self.sellerUID = sellerUID
        self.title = title
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let dict = snapshot.value as! [String : Any]
        uid = snapshot.key
        title = dict["title"] as! String
        description = dict["description"] as! String
        sellerUID = dict["sellerUID"] as! String
        if let imagesDict = dict["images"] as? [Any] {
        images = imagesDict as! [String]
        }
        if let imagesDict2 = dict["images"] as? [String : Any] {
        
        for (_, value) in imagesDict2 {
            let image = value
            images.append(image as! String)
        }
        }
        let returnSizes = dict["sizes"] as! [String : Any]
        for (key, value) in returnSizes {
            let name = key
            let values = value as! [String : Any]
            let price = values["price"] as! String
            let quantity = values["quantity"] as! Int
            
            let newSize = Size(price: price, quantity: quantity, name: name)
            sizes.append(newSize)
        }
        
    }
    
    struct Size {
        var price: String
        var quantity: Int
        var name: String
    }
    
}

