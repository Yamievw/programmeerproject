//
//  EditProfileViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 27/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var diver = [User]()
    var diverss: User?
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var certificateField: UITextField!
    @IBOutlet weak var experienceField: UITextField!
    @IBOutlet weak var amountdivesField: UITextField!
    @IBOutlet weak var userImagePicker: UIImageView!
    
    let ref = Database.database().reference(withPath: "Userinfo")
 

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(afterEdit), name: Notification.Name("afterEdit"), object: nil)
        navigationController?.navigationBar.isHidden = false

        // Get Profile Image.
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // After each textfield hide keyboard.
        self.nameField.delegate = self;
        self.certificateField.delegate = self;
        self.experienceField.delegate = self;
        self.amountdivesField.delegate = self;
        
        getUserDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Make sure user can go back to previous viewcontroller.
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }

    
    // Make keyboard dissapear after hitting Return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func updateProfile() {
        if let userId = Auth.auth().currentUser?.uid {
            
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
                        
                        let values = ["name": self.nameField.text!,  "certificate": self.certificateField.text!, "experience": self.experienceField.text!, "dives": self.amountdivesField.text!, "profileImageUrl": profileImageUrl] as [String : AnyObject]
                        
                        self.updateUserInDatabase(uid: userId, values: values)

                    }
                })
            }
        }
    }

    func afterEdit() {
        print("afterEdit")
        self.performSegue(withIdentifier: "afterEdit", sender: nil)
    }
    
    // Setup Firebase Database.
    private func updateUserInDatabase(uid: String, values: [String: AnyObject]){
        let ref = Database.database().reference()
        let userReference = ref.child("Userinfo").child(uid)
        
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error")
                return
            }
            NotificationCenter.default.post(name: Notification.Name("afterEdit"), object: nil)
            print("User is succesfully saved to Firebase database")
        })
    }
    
    // Function to get details of current user displayed on profile.
    func getUserDetails() {
        if Auth.auth().currentUser?.uid != nil {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("Userinfo").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    self.nameField.text = dictionary["name"] as? String
                    self.experienceField.text = dictionary["experience"] as? String
                    self.certificateField.text = dictionary["certificate"] as? String
                    self.amountdivesField.text = dictionary["dives"] as? String
                    
                    // Get user profile picture from URL
                    if let profileImageURL = dictionary["profileImageUrl"] as? String {
                        let url = URL(string: profileImageURL)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            DispatchQueue.main.async {
                                self.userImagePicker.image = UIImage(data: data!)
                            }
                        }).resume()
                    }
                }
            })
        }
    }
    
    @IBAction func saveData(_ sender: Any) {
        self.updateProfile()
//        self.performSegue(withIdentifier: "afterEdit", sender: nil)
    }
    
    
    //Segue to next viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.updateProfile()
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
}
