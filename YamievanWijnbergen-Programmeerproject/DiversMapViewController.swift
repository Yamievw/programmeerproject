//
//  DiversMapViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 13/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation
import MapKit

class DiversMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.isZoomEnabled = true

        getUserLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Zoom in to exact location of current user.
    @IBAction func zoomIn(_ sender: Any) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 2000, 2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    // Get only location for each user.
    func getUserLocations() {
        Database.database().reference().child("Userinfo").observe(.value, with: { (snapshot) in
            for item in snapshot.children {
                guard let locationData = item as? DataSnapshot else { continue }
                let locationValue = locationData.value as! [String: Any]
                
                let location = CLLocationCoordinate2D(latitude: locationValue["latitude"] as! Double, longitude: locationValue["longitude"] as! Double)
                let name = locationValue["name"] as! String
                print(location)
                print(name)
                
                // Create a pin for each user-location.
                let pin = MKPointAnnotation()
                pin.coordinate = location
                pin.title = locationValue["name"] as? String
                pin.subtitle = locationValue["certificate"] as? String
                self.mapView.addAnnotation(pin)
            }
        })
    }
    
    // Create button to get more info on user.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"")
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? UserProfileViewController {
            viewController.diver = self.diver
        }
    }
    
    // Segue to UserProfile.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            performSegue(withIdentifier: "diversInfo", sender: self)
        }
    }
}
