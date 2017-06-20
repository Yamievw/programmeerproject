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

class MessageViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var messages = [Message]()
    
    var diver: User? {
        didSet {
            navigationItem.title = diver?.name!
            observeMessages()
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
    
    func observeMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let userMessageref = Database.database().reference().child("user-messages").child(uid)
        userMessageref.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let messagesRef = Database.database().reference().child("Messages").child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String:AnyObject] else {
                    return
                }
                
                let message = Message(dictionary: dictionary)
                    
                // Only show messages that belong in that conversation.
                print("self: \(message.chatPartnerId()) diverId: \(self.diver?.id)")
                if message.chatPartnerId() == self.diver?.id {
                    self.messages.append(message)
//                    DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    //}
                }
            })
        })
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        // Save messages to Firebase.
        let ref = Database.database().reference().child("Messages")
        let childRef = ref.childByAutoId()
        
        let toId = diver!.id!
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = NSDate().timeIntervalSince1970
        let values = ["text": inputField.text!, "toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            
            let userMessagseRef = Database.database().reference().child("user-messages").child(fromId)
            
            let messageId = childRef.key
            userMessagseRef.updateChildValues([messageId: 1])
            
            // Store message also in database for recipient
            let recipientMessagesRef = Database.database().reference().child("user-messages").child(toId)
            recipientMessagesRef.updateChildValues([messageId:1] )
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.view.endEditing(false)
        sendButton(Any)
        
        return true
    }
    
    // MARK: Create Collection View.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MessageCollectionViewCell
        
        let message = messages[indexPath.item]
        print(message)
        cell.messageText.text = message.text
        
        return cell
    }

}
