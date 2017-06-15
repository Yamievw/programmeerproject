//
//  FindDiversViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 08/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FindDiversViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var divers = [User]()
    var diver: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getUsers() {
        Database.database().reference().child("Userinfo").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let diver = User(dictionary: dictionary)
                self.divers.append(diver)
                print(dictionary)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    // MARK: Create TableView.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.divers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "diversCell", for: indexPath) as! FindDiversTableViewCell
        
        let user = divers[indexPath.row]
        
        cell.diversName.text = user.name
        cell.diversCertificate.text = user.certificate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        diver = divers[indexPath.row]
        self.performSegue(withIdentifier: "diverInfo", sender: nil)
    }
    
    // Segue to next viewcontroller to get info on specific diver
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? UserProfileViewController {
            viewController.diver = self.diver
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

