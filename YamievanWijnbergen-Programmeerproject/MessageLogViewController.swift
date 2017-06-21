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
    //var message: Message?
    var messagesDict = [String: Message]()
    
    var diver: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clearTable()
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
            
            let messageId = snapshot.key
            let messagesReference = Database.database().reference().child("Messages").child(messageId)
            
            messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    let message = Message(dictionary: dictionary)
                    
                    if let toId = message.toId {
                        self.messagesDict[toId] = message
                        
                        self.messages = Array(self.messagesDict.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                        })
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
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
        
        cell.nameText?.text = message.toId
        cell.messageLabel?.text = message.text

        if let seconds = message.timestamp?.doubleValue {
            let timestampDate = Date(timeIntervalSince1970: seconds)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            cell.timeStamp?.text = dateFormatter.string(from: timestampDate)
        }
        
        return cell
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
    
    // Segue to next viewcontroller to get info on specific book
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MessageViewController {
            viewController.diver = self.diver
        }
    }

    
//    // Delete book from tableview and database.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let removeBook = books[indexPath.row].id
//            //removeBook.books_database?.removeValue()
//        }
//        self.tableView.reloadData()
//    }
}


