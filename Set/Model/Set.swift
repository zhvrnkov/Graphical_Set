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
    
//    func pickThis(_ card: Card) {
//        lastCards.append(card)
//        print(lastCards)
//    }
//
//    func unPickThis(_ card: Card) {
//        lastCards.remove(at: lastCards.index(of: card)!)
//        print(lastCards)
//    }
//
    func isSet(selectedCard: [Card]) -> Bool {
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
    
    func checkSelectedCards() {
        
    }
    
    
//    func chooseCard(at index: Int, cb: (() -> Void)? = nil) {
//        if !board[index]!.isPicked {
//            checkCards(cb: cb)
//
//            board[index]!.isPicked = true
//            lastCards.append(board[index]!)
//
//        } else if lastCards.count < 3 {
//            lastCards.removeThis(element: board[index]!)
//            board[index]!.isPicked = false
//            scoreCount -= 1
//        }
//    }
//
//    func checkCards(cb: (() -> Void)? = nil) {
//        if lastCards.count == 3 {
//            if lastCards.allEqual() {
//                for card in lastCards {
//                    if board.contains(card) {
//                        board[board.index(of: card)!] = nil
//                        lastCards.removeThis(element: card)
//                    }
//                }
//                cb?()
//                scoreCount += 3
//            } else {
//                for index in board.indices {
//                    board[index]?.isPicked = false
//                }
//                scoreCount -= 5
//            }
//            lastCards.removeAll()
//        }
//    }
//    
    func draw(cards amount: Int) {
        for _ in 1...amount {
            if let card = deck.draw() {
                board.append(card)
            }
        }
    }
//    init(cardsToBoard: Int) {
//        draw(cards: cardsToBoard)
//    }
}

protocol SetGameDelegate {
    func updateViewFromModel()
}
