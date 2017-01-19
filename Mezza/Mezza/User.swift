//
//  User.swift
//  Mezza
//
//  Created by Alex Mitchell on 2017-01-13.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User {
    
    enum userType: String {
        case vendor = "vendor"
        case buyer = "buyer"
        case unregistered = "unregistered"
    }
    
    var uid: String
    var avatar: String
    var email: String
    var name: String
    var location: String
    var bio: String
    var purchases = [String]() // orderUID
    var type: userType
    
    init(uid: String, avatar: String, email: String, name: String, location: String, bio: String, purchases: [String], type: userType) {
        
        self.uid = uid
        self.avatar = avatar
        self.email = email
        self.name = name
        self.location = location
        self.bio = bio
        self.purchases = purchases
        self.type = type
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value as? [String : Any]
        name = value?["name"] as? String ?? ""
        uid = snapshot.key
        email = value?["email"] as? String ?? ""
        location = value?["location"] as? String ?? ""
        bio = value?["bio"] as? String ?? ""
        let typeRaw = value?["type"] as? String
        type = userType(rawValue: typeRaw!)!
        avatar = value?["avatar"] as? String ?? ""
        let x = value?["purchases"] as? FIRDataSnapshot
        if (x?.hasChildren())! {
            let purchases = value?["purchases"] as? [String : Any]
            for (key, _) in purchases! {
                let newProductUID = key
                self.purchases.append(newProductUID)
            }
        }
    
        

    }
    
}









