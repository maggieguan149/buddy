//
//  HabitBubble.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit

class HabitBubble: UITableViewCell {

    @IBOutlet weak var habitLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet var lavenderView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lavenderView.layer.cornerRadius = lavenderView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
