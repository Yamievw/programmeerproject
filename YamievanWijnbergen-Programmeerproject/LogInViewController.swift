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
        
        navigationController?.navigationBar.isHidden = false

        // Keep user logged in when closing app.
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "stayLoggedIn", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }
    
    // Let a user login with their email and password
    @IBAction func loginDidTouch(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error != nil {
                self.loginFail()
            }
        }
    }
    
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        resetPassword()
    }

    
    func resetPassword() {

        Auth.auth().sendPasswordReset(withEmail: emailField!.text!, completion: { (error) in
        
            OperationQueue.main.addOperation {
                
                if error != nil {
                    
                    // Error - Unidentified Email
                    //SVProgressHUD.dismiss()
                    let alertController = UIAlertController(title: "Error", message: "Please enter a valid emailadress.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    
                    // Success - Sends recovery email
                    
                    //SVProgressHUD.dismiss()
                    
                    let alertController = UIAlertController(title: "Email Sent", message: "An email has been sent. Please, check your email now.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }})
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
