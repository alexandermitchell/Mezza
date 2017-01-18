//
//  User.swift
//  Mezza
//
//  Created by Alex Mitchell on 2017-01-13.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import Foundation
import UIKit


class User {
    
    enum userType {
        case vendor
        case buyer
    }
    
    var uid: String
    var avatar: UIImage
    var email: String
    var name: String
    var location: String
    var bio: String
    var purchases: [String] // orderUID
    var type: userType
    
    init(uid: String, avatar: UIImage, email: String, name: String, location: String, bio: String, purchases: [String], type: userType) {
        
        self.uid = uid
        self.avatar = avatar
        self.email = email
        self.name = name
        self.location = location
        self.bio = bio
        self.purchases = purchases
        self.type = type
        
    }
    
}
