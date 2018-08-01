//
//  Player.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 01/08/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import Foundation

class Player {
    var turn = true
    
    var score = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
        }
    }
    
    convenience init(hisTurn: Bool) {
        self.init()
        turn = hisTurn
    }
}
