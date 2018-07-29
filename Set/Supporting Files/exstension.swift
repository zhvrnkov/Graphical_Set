//
//  exstension.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 23/06/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
   mutating func removeThis(element: Element) {
        if let indexOfElement = self.index(of: element) {
            self.remove(at: indexOfElement)
        }
    }
}

extension Array {
    mutating func shuffle() {
        var num = self.count
        var array = self
        self.removeAll()
        for _ in array.indices{
            self.append(array.remove(at: num.arc4random))
            num -= 1
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
