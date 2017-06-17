//
//  MessageViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 16/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MessageViewController: UIViewController, UITextFieldDelegate {
    
    var diver: User? {
        didSet {
            navigationItem.title = diver?.name!
        }
    }
    
    @IBOutlet weak var inputField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.inputField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        
        // Save messages to Firebase.
        let ref = Database.database().reference().child("Messages")
        let childRef = ref.childByAutoId()
        
        let toId = diver!.id!
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = NSDate().timeIntervalSince1970
        let values = ["text": inputField.text!, "toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.view.endEditing(false)
        sendButton(Any)
        
        return true
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
