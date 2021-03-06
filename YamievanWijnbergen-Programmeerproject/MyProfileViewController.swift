//
//  MyProfileViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 07/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var myNameText: UITextView!
    @IBOutlet weak var myCertificateText: UITextView!
    @IBOutlet weak var myExperience: UILabel!
    @IBOutlet weak var myDives: UILabel!
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getUserDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Function to get details of current user displayed on profile.
    func getUserDetails() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(logoutDidTouch), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("Userinfo").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    self.myNameText.text = dictionary["name"] as? String
                    self.myExperience.text = dictionary["experience"] as? String
                    self.myCertificateText.text = dictionary["certificate"] as? String
                    self.myDives.text = dictionary["dives"] as? String
                    
                    // Get user profile picture from URL
                    if let profileImageURL = dictionary["profileImageUrl"] as? String {
                        let url = URL(string: profileImageURL)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            DispatchQueue.main.async {
                                self.profileImage.image = UIImage(data: data!)
                            }
                        }).resume()
                    }
                }
            })
        }
    }
    
    
    // Function to log user out.
    @IBAction func logoutDidTouch(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: " Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        let logoutAction = UIAlertAction(title: "Yes",style: .default) { action in
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            self.performSegue(withIdentifier: "logOut", sender: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Nope!", style: .default)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
