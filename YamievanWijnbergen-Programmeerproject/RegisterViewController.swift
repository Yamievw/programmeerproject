//
//  RegisterViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 07/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage
import CoreLocation

class RegisterViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var certificateField: UITextField!
    @IBOutlet weak var experienceField: UITextField!
    @IBOutlet weak var amountdivesField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userImagePicker: UIImageView!

    let ref = Database.database().reference(withPath: "UserInfo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Location.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopMonitoringSignificantLocationChanges()
        
        // Get Profile Image.
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // After each textfield hide keyboard.
        self.nameField.delegate = self;
        self.certificateField.delegate = self;
        self.experienceField.delegate = self;
        self.amountdivesField.delegate = self;
        self.emailField.delegate = self;
        self.passwordField.delegate = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        locationAuthStatus()
    }
    
    // Make keyboard dissapear after hitting Return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Get location authorization status.
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            currentLocation = locationManager.location
//            print(currentLocation.coordinate.latitude)
//            print(currentLocation.coordinate.longitude)
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    // Register a new user to Firebase database with his data.
    @IBAction func registerDidTouch(_ sender: Any) {

        Auth.auth().createUser(withEmail: emailField.text!,password: passwordField.text!) { user, error in
            if error == nil {
                
                Auth.auth().signIn(withEmail: self.emailField.text!,password: self.passwordField.text!)
                
                if Auth.auth().currentUser != nil {
                    self.performSegue(withIdentifier: "registerToMap", sender: self)
                }
            } else {
                self.RegisterFail()
            }
 
            guard let uid = user?.uid else {
                return
            }
            let lat: Double = (self.locationManager.location?.coordinate.latitude)!
            let lon: Double = (self.locationManager.location?.coordinate.longitude)!
            
            // Store user info to Firebase database and storage.
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("\(imageName).png")
            
            if let uploadData = UIImageJPEGRepresentation(self.userImagePicker.image!, 0.1)! as Data? {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    
                        let values = ["name": self.nameField.text!, "email": self.emailField.text!, "certificate": self.certificateField.text!, "experience": self.experienceField.text!, "dives": self.amountdivesField.text!, "latitude": lat, "longitude": lon, "profileImageUrl": profileImageUrl] as [String : AnyObject]
                        
                        self.registerUserIntoDatabase(uid: uid, values: values)
                    }
                })
            }
        }
    }
    
    // Setup Firebase Database.
    private func registerUserIntoDatabase(uid: String, values: [String: AnyObject]){
        let ref = Database.database().reference()
        let userReference = ref.child("Userinfo").child(uid)
        
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error")
                return
            }
            print("User is succesfully saved to Firebase database")
        })
    }

    // Select imageView.
    @IBAction func selectedImagePicker(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Choose an image from Photos.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            userImagePicker.image = image
            imageSelected = true
        }
        else {
            print("Image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // Alert to let user know login failed.
    func RegisterFail() {
        let alertcontroller = UIAlertController(title: "Failed to register. ", message: "Please, try again.",preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        
        alertcontroller.addAction(OKAction)
        self.present(alertcontroller, animated: true, completion:nil)
        
        return
    }
}
