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
    
    var diverss = [Annotation]()
    var divers = [User]()
    var diver: User?
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Map.
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.isZoomEnabled = true

        getUserLocations()
        navigationController?.navigationBar.isHidden = true
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
        Database.database().reference().child("Userinfo").observe(.childAdded, with: { (snapshot) in
            let dictionary = snapshot.value as! [String: Any]
            let location = CLLocationCoordinate2D(latitude: dictionary["latitude"] as! Double, longitude: dictionary["longitude"] as! Double)
            let user = User(dictionary: dictionary)
            let diversss = Annotation(user: user)
            user.id = snapshot.key
            
            self.diverss.append(diversss)
            
            self.mapView.addAnnotation(diversss)
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
    
    // Segue to UserProfile.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            self.diver = (view.annotation! as? Annotation)?.user
            performSegue(withIdentifier: "diversInfo", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? UserProfileViewController {
            viewController.diver = self.diver!
        }
    }
}
