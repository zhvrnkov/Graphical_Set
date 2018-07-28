//
//  Set.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 23/06/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import Foundation

class SetGame {
    private(set) var deck = CardDeck()
    private(set) var board = [Card]() {
        didSet {
            delegate?.updateViewFromModel()
        }
    }
    private(set) var scoreCount = 0 {
        didSet {
            if scoreCount < 0 {
                scoreCount = 0
            }
        }
    }
    
    var delegate: SetGameDelegate?
    
    private(set) var selectedCards = [Card]()
    
    func selectThis(card: Card) {
        selectedCards.append(card)
    }

    func unSelectThisCard(card: Card) {
        selectedCards.removeThis(element: card)    }

    func isSet(in selectedCard: [Card]) -> Bool {
        let color  = Set(selectedCard.map{ $0.color }).count
        let shape  = Set(selectedCard.map{ $0.symbol }).count
        let number = Set(selectedCard.map{ $0.number }).count
        let fill   = Set(selectedCard.map{ $0.shading }).count


        return color != 2 && shape != 2 && number != 2 && fill != 2
    }
    
    func removeSettedCardsFromBoard(selectedCards: [Card]) {
        selectedCards.forEach {
            board.removeThis(element: $0)
        }
    }
    
    func checkSelectedCards(cb: ((Int) -> Void)? = nil) {
        if isSet(in: selectedCards) {
            removeSettedCardsFromBoard(selectedCards: selectedCards)
            cb?(3)
        }
        selectedCards.removeAll()
    }
    
    func draw(cards amount: Int) {
        for _ in 1...amount {
            if let card = deck.draw() {
                board.append(card)
            }
        }
    }
}

protocol SetGameDelegate {
    func updateViewFromModel()
}
