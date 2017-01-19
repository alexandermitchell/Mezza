//
//  Order.swift
//  Mezza
//
//  Created by Edward Han on 1/13/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import Foundation


enum OrderStatus: String {
    case delivered = "delivered"
    case pending = "pending"
    case sent = "sent"
    case cancelled = "cancelled"
}

class Order {
    
    var uid: String
    var buyerUID: String
    var sellerUID: String
    var size: String
    var status = OrderStatus.pending
    var product: String
    var price: Double
    
    init(uid: String, buyerUID: String, sellerUID: String, size: String, product: String, price: Double) {
        self.uid = uid
        self.buyerUID = buyerUID
        self.sellerUID = sellerUID
        self.size = size
        self.product = product
        self.price = price
    }
    
}
