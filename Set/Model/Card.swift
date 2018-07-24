//
//  Card.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 23/06/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import Foundation

struct Card: Hashable {
// MARK: - Implementation of HASHABLE Protocol
    var hashValue: Int { return identifier }
    private var identifier: Int
    
    private static var identifierFactor = 0
    private static func getUniqueID() -> Int {
        identifierFactor += 1
        return identifierFactor
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.identifier == rhs.identifier)
//                && (lhs.isPicked == rhs.isPicked)
                && (lhs.symbol == rhs.symbol)
                && (lhs.number == rhs.number)
                && (lhs.shading == rhs.shading)
                && (lhs.color == rhs.color)
    }
    
// MARK: - Card attributes
//    var isPicked = false
    
    let number : Int
    let symbol : CardSymbols
    let shading: CardShadings
    let color  : CardColor
    
    
    enum CardSymbols {
        case diamond, squiggle, oval
        
        static var all: [CardSymbols] {
            return [CardSymbols.diamond, .oval, .squiggle]
        }
    }
    
    enum CardShadings {
        case solid, striped, open
        
        static var all: [CardShadings] {
            return [CardShadings.solid, .striped, .open]
        }
    }
    
    enum CardColor {
        case red, green, purple
        
        static var all: [CardColor] {
            return [CardColor.red, .green, .purple]
        }
    }
    
    
    init(number: Int, symbol: CardSymbols, shading: CardShadings, color: CardColor) {
        self.number  = number
        self.symbol  = symbol
        self.shading = shading
        self.color   = color
        self.identifier = Card.getUniqueID()
    }
}
