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
    var message: Message?
    var messagesDict = [String: Message]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func observeMessages() {
        let ref = Database.database().reference().child("Messages")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:AnyObject] {
                let message = Message(dictionary: dictionary)
                //self.messages.append(message)
                
                if let toId = message.toId {
                    self.messagesDict[toId] = message
                    
                    self.messages = Array(self.messagesDict.values)
//                    self.messages.sort(by: { (message1, message2) -> Bool in
//                        return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
//                    })
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
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
        if let toId = message.toId {
            let ref = Database.database().reference().child("Userinfo").child(toId)
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

//        if let seconds = message.timestamp?.doubleValue {
//            let timestampDate = Date(timeIntervalSince1970: seconds)
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "hh:mm:ss a"
//            cell.timeStamp?.text = dateFormatter.string(from: timestampDate)
//        }
        
        return cell
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


