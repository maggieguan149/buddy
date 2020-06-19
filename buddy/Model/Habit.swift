//
//  Habit.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import Foundation

struct Habit: Codable {
    var name: String = ""
    var done: Bool = false
    var streak: Int = 0
}
