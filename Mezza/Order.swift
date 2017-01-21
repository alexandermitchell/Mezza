//
//  Order.swift
//  Mezza
//
//  Created by Edward Han on 1/13/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import Foundation
import Firebase


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
    
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value as? [String : Any]
        self.buyerUID = value?["buyer"] as? String ?? ""
        self.price = value?["price"] as? Double ?? 0.0
        self.sellerUID = value?["seller"] as? String ?? ""
        self.size = value?["size"] as? String ?? ""
        self.uid = snapshot.key
        self.product = value?["productUID"] as? String ?? ""
        let statusRawValue = value?["status"] as? String ?? ""
        self.status = OrderStatus(rawValue: statusRawValue)!
    }
    
    
}
