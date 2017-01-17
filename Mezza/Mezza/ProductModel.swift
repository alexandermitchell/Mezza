//
//  ProductModel.swift
//  Mezza
//
//  Created by Paul Jurczyk on 1/13/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import Foundation
import UIKit

class Product {
    var UID: String
    var description: String
    var sellerUID: String
    var sizes = [Size]()
    var images = [UIImage]()
    
    init(UID: String, description: String, sellerUID: String){
        self.UID = UID
        self.description = description
        self.sellerUID = sellerUID
    }
    
    struct Size {
        var height: Int
        var width: Int
        var price: Int
        var quantity: Int
    }
    
}

