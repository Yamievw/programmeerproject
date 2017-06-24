//
//  LogInViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 07/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keep user logged in when closing app.
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "stayLoggedIn", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Let a user login with their email and password
    @IBAction func loginDidTouch(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil {
                if Auth.auth().currentUser != nil {
                    self.performSegue(withIdentifier: "loginToMap", sender: self)
                }
            } else {
                 self.loginFail()
            }
        }
    }
    
    // Alert to let user know login failed.
    func loginFail() {
        let alertcontroller = UIAlertController(title: "Failed to login.", message: "Please, try again.",preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        
        alertcontroller.addAction(OKAction)
        self.present(alertcontroller, animated: true, completion:nil)
        
        return
    }
}
