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
        diverImage.imageFromURL(url: (diver?.profileImageUrl)!)
        diverName.text = (diver?.name)!
        diverCertificate.text = (diver?.certificate)!
        diverExperience.text = (diver?.experience)!
        diverDives.text = (diver?.dives)!
    }
}
