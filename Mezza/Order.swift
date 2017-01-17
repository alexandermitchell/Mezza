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
}
class Order {
    
    var uid = String()
    var buyer = "userUID"
    var seller = "sellerUID"
    var size = String()
    var status = OrderStatus.pending
    var product = "productUID"
    
}
