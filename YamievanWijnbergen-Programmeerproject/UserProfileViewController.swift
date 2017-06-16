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
    @IBOutlet weak var diverNameText: UITextView!
    @IBOutlet weak var diverCertificateText: UITextView!
    @IBOutlet weak var diverExperience: UILabel!
    @IBOutlet weak var diverDives: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateDiver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDiver() {
        diverImage.imageFromURL(url: (diver?.profileImageUrl)!)
        diverNameText.text = (diver?.name)!
        diverCertificateText.text = (diver?.certificate)!
        diverExperience.text = (diver?.experience)!
        diverDives.text = (diver?.dives)!
    }

    @IBAction func messageButton(_ sender: Any) {
        performSegue(withIdentifier: "sendMessage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MessageViewController {
            viewController.diver = self.diver!
            print(self.diver?.name)
        }
    }
}

// Function to create image from url.
extension UIImageView {
    
    func imageFromURL(url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print ("Cant load imagesURL \(error)")
                } else {
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }).resume()
        }
    }
}

