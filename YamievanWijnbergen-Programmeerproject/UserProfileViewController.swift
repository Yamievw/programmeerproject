//
//  UserProfileViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 07/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class UserProfileViewController: UIViewController {
    
    var diver: User?
    
    
    @IBOutlet weak var diverImage: UIImageView!
    @IBOutlet weak var diverName: UILabel!
    @IBOutlet weak var diverCertificate: UILabel!
    @IBOutlet weak var diverExperience: UILabel!
    @IBOutlet weak var diverDives: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //getDiverDetails()
        updateDiver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDiver() {
        //diverImage.imageFromURL(url: (diver?.profileImageUrl)!)
        print(diver?.profileImageUrl)
        diverName.text = (diver?.name)!
        print(diver?.name)
        diverCertificate.text = (diver?.certificate)!
        print(diver?.certificate)
        //diverExperience.text = (diver?.experience)!
        print(diver?.experience)
        //diverDives.text = (diver?.dives)!
        print(diver?.dives)
    }
//    func getDiverDetails() {
//        let uid = Auth.auth().currentUser?.uid
//        Database.database().reference().child("Userinfo").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            if let dictionary = snapshot.value as? [String: Any] {
//                self.diverName.text = dictionary["name"] as? String
//                self.diverExperience.text = dictionary["experience"] as? String
//                self.diverCertificate.text = dictionary["certificate"] as? String
//                self.diverDives.text = dictionary["dives"] as? String
//                
//                // Get user profile picture from URL
//                if let profileImageURL = dictionary["profileImageUrl"] as? String {
//                    let url = URL(string: profileImageURL)
//                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//                        if error != nil {
//                            print(error!)
//                            return
//                        }
//                        DispatchQueue.main.async {
//                            self.diverImage.image = UIImage(data: data!)
//                        }
//                    }).resume()
//                }
//            }
//        })
//    }
}
