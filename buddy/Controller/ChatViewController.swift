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
    
    var messageArray = [Message]()
    
//    var database = firebase.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
    
    
//MARK: - Tableview datasource methods

    extension ChatViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messageArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let message = messageArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
            cell.textLabel?.text = message.text
            return cell
        }
    }
    
    
//MARK: - Tableview delegate methods

    extension ChatViewController: UITableViewDelegate{
        
    }

