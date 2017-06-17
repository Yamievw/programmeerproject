//
//  Message.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 16/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class Message: NSObject {
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        //self.timestamp = dictionary["timestamp"] as? NSNumber ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
    }

}
