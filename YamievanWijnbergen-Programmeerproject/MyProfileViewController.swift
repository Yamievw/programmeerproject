//
//  MyProfileViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 07/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreLocation

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var userImagePicker: UIImageView!
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    // function to log user out.
    @IBAction func logoutDidTouch(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: " Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        let logoutAction = UIAlertAction(title: "Yes",style: .default) { action in
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            self.performSegue(withIdentifier: "logout", sender: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Nope!", style: .default)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
