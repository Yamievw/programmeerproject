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

class MessageViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sendMessage: UIButton!
    
    var messages = [Message]()
    var message: Message?
    
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
        navigationController?.navigationBar.isHidden = false
    }
    
//    // Make sure user can go back to previous viewcontroller.
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
//        super.viewWillDisappear(animated)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -210, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -210, up: false)
    }
    
    // Move the text field up when editing textfield.
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func observeMessages() {
        guard let uid = Auth.auth().currentUser?.uid, let toId = diver?.id else {
            return
        }
        let userMessageref = Database.database().reference().child("user-messages").child(uid).child(toId)
        userMessageref.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let messagesRef = Database.database().reference().child("Messages").child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String:AnyObject] else {
                    return
                }
                
                let message = Message(dictionary: dictionary)
                    
                // Only show messages that belong in that conversation.
                if message.chatPartnerId() == self.diver?.id {
                    self.messages.append(message)
                    
                    DispatchQueue.main.async {
                    self.collectionView.reloadData()
                        
                        // Scroll to the last message in chat.
                        let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                    }
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
        
        // User can't send empty messages.
        if inputField.text?.isEmpty == true {
            return
        }
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            
            self.inputField.text = nil
            
            let userMessagseRef = Database.database().reference().child("user-messages").child(fromId).child(toId)
            
            let messageId = childRef.key
            userMessagseRef.updateChildValues([messageId: 1])
            
            // Store message also in database for recipient
            let recipientMessagesRef = Database.database().reference().child("user-messages").child(toId).child(fromId)
            recipientMessagesRef.updateChildValues([messageId:1] )
        }
    }
    
    // MARK: Create Collection View.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let message = messages[indexPath.item]
        
        // Check who sends the message.
        if message.fromId == Auth.auth().currentUser?.uid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMe", for: indexPath) as! MessageCollectionViewCell
            cell.messageText.text = message.text
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellYou", for: indexPath) as! MessageCollectionViewCell
            
            cell.messageText.text = message.text
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    // Make cell height dynamic based on height textview.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 60
        
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text).height + 30
        }
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sendMessage") {
            viewWillDisappear(true)
                   }
        if (segue.identifier == "chatInfo") {
            viewWillDisappear(false)
        }
    }
}
