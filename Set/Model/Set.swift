//
//  Set.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 23/06/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import Foundation

class SetGame {
    let players: [Player]
    private(set) var deck = CardDeck()
    private(set) var timer: Timer?
    var timeIntreval: TimeInterval = 10
    private(set) var board = [Card]() {
        didSet {
            delegate?.updateViewFromModel()
        }
    }
    
    var delegate: SetGameDelegate?
    
    private(set) var selectedCards = [Card]()
    
    func selectThis(card: Card) {
        selectedCards.append(card)
    }

    func unSelectThisCard(card: Card) {
        players.filter { $0.turn }[0].score -= 1
        selectedCards.removeThis(element: card)
        
    }

    func isSet(in selectedCard: [Card]) -> Bool {
        let color  = Set(selectedCard.map{ $0.color }).count
        let shape  = Set(selectedCard.map{ $0.symbol }).count
        let number = Set(selectedCard.map{ $0.number }).count
        let fill   = Set(selectedCard.map{ $0.shading }).count


        return color != 2 && shape != 2 && number != 2 && fill != 2
    }
    
    func checkSelectedCards(cb: ((Int) -> Void)? = nil) {
        let player = players.filter { $0.turn }[0]
        if isSet(in: selectedCards) {
            selectedCards.forEach {
                board.removeThis(element: $0)
            }
            player.score += 3
            delegate?.updateScoreView(with: player.score)
            cb?(3)
        } else {
            player.score -= 5
            delegate?.updateScoreView(with: player.score)
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
    
    func switchTurn() {
        print(timeIntreval)
        timer?.invalidate()
        players.forEach {
            $0.turn = !$0.turn
        }
        delegate?.updateScoreView(with: players.filter { $0.turn == true }[0].score)
        timer = Timer.scheduledTimer(withTimeInterval: timeIntreval, repeats: false) { _ in self.switchTurn()
        }
        timeIntreval = 10
    }
    
    init(cooperateMode: Bool) {
        if cooperateMode {
            players = [Player(hisTurn: true), Player(hisTurn: false)]
            timer = Timer.scheduledTimer(withTimeInterval: timeIntreval, repeats: false) {  _ in
                self.switchTurn()
            }
        } else {
            players = [Player()]
        }
        players[1].score = 1
    }
}

protocol SetGameDelegate {
    func updateViewFromModel()
    func updateScoreView(with: Int)
}
