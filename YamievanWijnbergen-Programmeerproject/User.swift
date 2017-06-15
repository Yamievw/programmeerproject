//
//  User.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 10/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import CoreLocation

class User: NSObject {
    var name: String?
    var profileImageUrl: String?
    var experience: String?
    var dives: String?
    var certificate: String?
    var location: CLLocationCoordinate2D
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.certificate = dictionary["certificate"] as? String ?? ""
        self.experience = dictionary["experience"] as? String ?? ""
        self.dives = dictionary["dives"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.location = CLLocationCoordinate2D(latitude: dictionary["latitude"] as! Double, longitude: dictionary["longitude"] as! Double)
    }
}
