//
//  ChatViewController.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messageArray = [Message]()
    
//    var database = firebase.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Buddy"
        navigationItem.hidesBackButton = true
        
        tableView.rowHeight = 65
        
        tableView.register(UINib(nibName: "ChatBubble", bundle: nil), forCellReuseIdentifier: "ChatCell")
        
        loadMessages()
    }
    
    func loadMessages() {
        db.collection("message").order(by: "date").addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print("error retrieving data from firestore, \(e)")
            } else {
                self.messageArray = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let messageBody = data["text"] as? String, let messageSender = data["sender"] as? String{
                        let message = Message(text: messageBody, sender: messageSender)
                        self.messageArray.append(message)
                        
                        self.tableView.reloadData()
                        let indexPath = IndexPath(row: self.messageArray.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageSender = Auth.auth().currentUser?.email, let messageBody = messageTextfield.text{
            self.messageTextfield.text = ""
            db.collection("message").addDocument(data: [
                "sender": messageSender,
                "text": messageBody,
                "date": Date().timeIntervalSince1970
            ])
            { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data")
                }
            }
        }
    }
    
    
}
    
    
//MARK: - Tableview datasource methods

    extension ChatViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messageArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatBubble
            let currentMessage = messageArray[indexPath.row]
            if Auth.auth().currentUser?.email == currentMessage.sender{
                cell.leftSender.isHidden = true
                cell.sender.isHidden = false
            } else {
                cell.sender.isHidden = true
                cell.leftSender.isHidden = false
            }
            cell.label.text = currentMessage.text
            return cell
        }
    }
    
    
//MARK: - Tableview delegate methods

    extension ChatViewController: UITableViewDelegate{
        
    }

