//
//  Annotation.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 14/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate : CLLocationCoordinate2D
    var user : User?
    var title : String?
    var subtitle : String?
    
    init(user: User) {
        self.coordinate = user.location
        self.title = user.name!
        self.subtitle = user.certificate!
        self.user = user
    }
}
