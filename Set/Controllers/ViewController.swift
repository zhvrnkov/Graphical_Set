//
//  ViewController.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 22/06/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) var game = Set(cardsToBoard: 12)
    
    private(set) var grid = Grid(layout: .aspectRatio(63.15/88.9))
    
    private(set) var cardViews = [CardView]()
    
    override func viewDidLoad() {
        getViewsForCards()
    }

    @IBOutlet weak var boardView: UIView! {
        didSet {
            grid.frame = boardView.bounds
        }
    }
    
    @IBAction func panGestureOnBoardView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.draw(cards: 3)
            getViewsForCards()
        default:
            break
        }
    }
    
    func getViewsForCards() {
        grid.cellCount = game.board.count
        
        let howManyCardViewsNeedToAdd = game.board.count - cardViews.count
        
        for indexOfAddAction in 0..<howManyCardViewsNeedToAdd {
            let card = game.board[game.board.count - indexOfAddAction - 1]
            let cardView = CardView(symbol: card.symbol, number: card.number, color: card.color, shadings: card.shading)
            cardViews.append(cardView)
            boardView.addSubview(cardView)
        }
        
        for indexOfCardView in cardViews.indices {
            if let newFrame = grid[indexOfCardView] {
                cardViews[indexOfCardView].frame = newFrame
                boardView.setNeedsDisplay()
                boardView.setNeedsLayout()
            }
        }
    }
    
//    func draw(cards amount: Int) {
//        for _ in 1...amount {
//            game.deck.draw()
//        }
//    }

//    @IBOutlet weak var threeMoreCardsButton: UIButton!
    
//    @IBOutlet var cards: [UIButton]! {
//        didSet { updateCards() }
//    }
    
//    func updateCards() {
//        for index in 0..<cards.count {
//            if let card = game.board[index] {
////                associateCardWithAButton(card: card, btn: cards[index])
//            } else {
//                cards[index].backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
//                cards[index].setTitle("", for: .normal)
//                cards[index].isEnabled = false
//            }
//        }
//    }
//    func associateCardWithAButton(card: Card, btn: UIButton) {
//        btn.setTitle(String(card.symbol), for: .normal)
//        btn.isEnabled = true
//
//        if card.isPicked {
//            btn.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
//        } else {
//            btn.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
//        }
//    }
//    func checkPlaceForCards() -> Bool {
//        let howManyNils = game.board.filter { $0 == nil }.count
//        print((game.deck.cards.count < 3) || (howManyNils < 3))
//        return game.deck.cards.count < 3 || howManyNils < 3
//    }
//    func newGame() {
//        game = Set(cardsOnBoard: 12)
//        updateCards()
//        threeMoreCardsButton.isEnabled = true
//        threeMoreCardsButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//    }
//}

//    @IBAction func cardPressed(_ sender: UIButton) {
//        if let cardNumber = cards.index(of: sender) {
//            game.chooseCard(at: cardNumber) {
//                self.game.putCardsOnBoard(amount: 3) {
//                    if !self.checkPlaceForCards() {
//                        self.threeMoreCardsButton.isEnabled = false
//                        self.threeMoreCardsButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
//                    } else {
//                        self.threeMoreCardsButton.isEnabled = true
//                        self.threeMoreCardsButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//                    }
//                }
//            }
//            updateCards()
//        }
//    }

//    @IBAction func threeMoreCardsButtonPressed(_ sender: UIButton) {
//        if game.lastCards.count == 3 {
//            game.checkCards()
//            updateCards()
//        } else {
//            game.putCardsOnBoard(amount: 3) {
//                if self.checkPlaceForCards() {
//                    sender.isEnabled = false
//                    sender.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
//                } else {
//                    sender.isEnabled = true
//                    sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//                }
//            }
//            updateCards()
//        }
}

