//
//  ChatBubble.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit

class ChatBubble: UITableViewCell {
    
    @IBOutlet var sender: UIImageView!
    @IBOutlet var leftSender: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var messageBubble: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
