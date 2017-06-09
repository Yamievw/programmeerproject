//
//  HomeViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 08/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.stopMonitoringSignificantLocationChanges()

        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        
//        locationAuthStatus()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func locationAuthStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            currentLocation = locationManager.location
//            print(currentLocation.coordinate.latitude)
//            print(currentLocation.coordinate.longitude)
//        }
//        else {
//            locationManager.requestWhenInUseAuthorization()
//            locationAuthStatus()
//        }
//    }
}
