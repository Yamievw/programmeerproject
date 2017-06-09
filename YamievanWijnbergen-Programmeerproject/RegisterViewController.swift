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

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var certificateField: UITextField!
    @IBOutlet weak var experienceField: UITextField!
    @IBOutlet weak var amountdivesField: UITextField!

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let ref = Database.database().reference(withPath: "UserInfo")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Register a new user to Firebase database
    @IBAction func registerDidTouch(_ sender: Any) {

        Auth.auth().createUser(withEmail: emailField.text!,password: passwordField.text!) { user, error in
            if error == nil {
                
                Auth.auth().signIn(withEmail: self.emailField.text!,password: self.passwordField.text!)
                
                if Auth.auth().currentUser != nil {
                    self.performSegue(withIdentifier: "RegisterToFindDivers", sender: self)
                }

            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // Store user info to Firebase database
            let ref = Database.database().reference(fromURL: "https://programmeerproject-820ae.firebaseio.com/")
            let userReference = ref.child("Userinfo").child(uid)
            
            let values = ["name": self.nameField.text, "email": self.emailField.text, "certificate": self.certificateField.text, "experience": self.experienceField.text, "dives": self.amountdivesField.text]
            
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print("Error")
                    return
                }
                print("User is succesfully saved to Firebase database")
            })
            
        }
    }
}
