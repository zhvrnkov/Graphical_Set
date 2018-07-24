//
//  Deck.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 25/07/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import Foundation

struct CardDeck {
    private(set) var cards = [Card]()
    static var count = 81
    
    init() {
        for number in 1...3 {
            for symbol in Card.CardSymbols.all {
                for shading in Card.CardShadings.all {
                    for color in Card.CardColor.all {
                        cards.append(Card(number: number, symbol: symbol, shading: shading, color: color))
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    mutating func draw() -> Card? {
        if let lastCard = cards.last, let lastCardIndex = cards.index(of: lastCard) {
            return cards.remove(at: lastCardIndex)
        } else {
            return nil
        }
    }
}
