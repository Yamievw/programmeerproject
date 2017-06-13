//
//  User.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 10/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var name: String?
    var profileImageUrl: String?
    var experience: String?
    var dives: String?
    var certificate: String?
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.certificate = dictionary["certificate"] as? String ?? ""
    }
}