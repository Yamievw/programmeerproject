//
//  MessageLogViewController.swift
//  YamievanWijnbergen-Programmeerproject
//
//  Created by Yamie van Wijnbergen on 16/06/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MessageLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var messages = [Message]()
    var messagesDict = [String: Message]()
    
    var diver: User?
    
    var timer: Timer?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var NoMessages: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearTable()
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let userId = snapshot.key
            Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                let messageId = snapshot.key
                
                self.fetchMessageWithMessageId(messageId)
                self.attemptReloadTable()
            })
        })
    }
    
    func fetchMessageWithMessageId(_ messageId: String) {
        let messagesReference = Database.database().reference().child("Messages").child(messageId)
        
        messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
 
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message(dictionary: dictionary)
                
                if let chatPartnerId = message.chatPartnerId() {
                    self.messagesDict[chatPartnerId] = message
                }
                self.attemptReloadTable()
            }
        })
    }
    
    // Reload tableview in 0.1 seconds.
    func attemptReloadTable() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    func handleReloadTable() {
        self.messages = Array(self.messagesDict.values)
        self.messages.sort(by: { (message1, message2) -> Bool in
            
            return (message1.timestamp?.int32Value)! > (message2.timestamp?.int32Value)!
        })
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })

    }
    
    // Clear table so it only loads conversations that belong to user.
    func clearTable() {
        messages.removeAll()
        messagesDict.removeAll()
        tableView.reloadData()
        
        observeUserMessages()
    }
    
    // MARK: Create TableView.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages.count == 0 {
            NoMessages.isHidden = false
        } else {
            NoMessages.isHidden = true
        }
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell

        let message = messages[indexPath.row]
        
        // Get info about messges for log.
        if let id = message.chatPartnerId() {
            let ref = Database.database().reference().child("Userinfo").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    cell.nameText?.text = dictionary["name"] as? String
                    
                    if let profileImageUrl = dictionary["profileImageUrl"] as? String {
                        cell.profileImage.imageFromURL(url: profileImageUrl)
                    }
                }
            })
        }
        
        cell.messageLabel?.text = message.text

        // Create timestamp.
        if let seconds = message.timestamp?.doubleValue {
            let timestampDate = Date(timeIntervalSince1970: seconds)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            cell.timeStamp?.text = dateFormatter.string(from: timestampDate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let message = self.messages[indexPath.row]
        
        
        
        if let chatPartnerId = message.chatPartnerId() {
            Database.database().reference().child("user-messages").child(uid).child(chatPartnerId).removeValue(completionBlock: { (error, ref) in
                
                if error != nil {
                    print("Failed to delete message:", error!)
                    return
                }
                
                self.messagesDict.removeValue(forKey: chatPartnerId)
                self.attemptReloadTable()
            })
        }
    }
    
    // Segue to chatInfo with matching conversation.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]

        
        guard let chatPartnerId = message.chatPartnerId() else {
            return
        }
        
        let ref = Database.database().reference().child("Userinfo").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }

            self.diver = User(dictionary: dictionary)
            self.diver?.id = chatPartnerId
            
            self.performSegue(withIdentifier: "chatInfo", sender: self)
            
        })
    }
    
    // Prepare for segue to next viewcontroller to go to chat.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MessageViewController {
            viewController.diver = self.diver
        }
    }
    
}


