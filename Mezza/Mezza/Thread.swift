//
//  Thread.swift
//  Mezza
//
//  Created by Aman Singh on 1/13/17.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

import UIKit
import Foundation


class Thread {

    var threadUID: String
    var message: Message
  
    init(threadUID: String, message: Message) {
        self.threadUID = threadUID
        self.message = message
    }
}

class Message {
    
    var receiver: String
    var sender: String
    var text: String
    var timestamp: String

    init(receiver: String, sender: String, text: String, timestamp: String) {
        self.receiver = receiver
        self.sender = sender
        self.text = text
        self.timestamp = timestamp
    }
}
