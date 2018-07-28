//
//  ViewController.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 22/06/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SetGameDelegate {
    
    private(set) var game = SetGame()
    
    private(set) var grid = Grid(layout: .aspectRatio(63.15/88.9))
    
    private(set) var cardViews = [CardView]()
    
    private var isSet: Bool {
        return game.isSet(selectedCard: selectedCardViews.map {$0.card})
    }
    
    private(set) var selectedCardViews = [CardView]() {
        didSet {
            if selectedCardViews.count == 3 {
                print(isSet)
                if isSet {
                    game.removeSettedCardsFromBoard(selectedCards: selectedCardViews.map{ $0.card })
                } else {
                    cardViews.forEach { $0.state = .unselected }
                    selectedCardViews.removeAll()
                }
                
            }
            print(boardView.subviews.count)
        }
    }

    @IBOutlet weak var boardView: UIView! {
        didSet {
            grid.frame = boardView.bounds
        }
    }
    
    override func viewDidLoad() {
        game.delegate = self
        game.draw(cards: 12)
    }
    
    @IBAction func panGestureOnBoardView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.draw(cards: 3)
        default:
            break
        }
    }
    
    func updateViewFromModel() {
        grid.cellCount = game.board.count
        
        let differenceBetweenBoardAndView = game.board.count - cardViews.count
        
        if differenceBetweenBoardAndView >= 0 {
            for indexOfAddAction in 0..<differenceBetweenBoardAndView {
                let card = game.board[game.board.count - indexOfAddAction - 1]
                let cardView = CardView(card: card)
                cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cardTapped)))
                cardViews.append(cardView)
                boardView.addSubview(cardView)
            }
        } else {
            cardViews.forEach {
                if !game.board.contains($0.card) {
                    $0.removeFromSuperview()
                    cardViews.removeThis(element: $0)
                }
            }
        }
        
        
        
        
        for indexOfCardView in cardViews.indices {
            if let newFrame = grid[indexOfCardView] {
                cardViews[indexOfCardView].frame = newFrame
//                boardView.setNeedsDisplay()
//                boardView.setNeedsLayout()
            }
        }
    }
    
    @objc func cardTapped(_ recognizer: UITapGestureRecognizer) {
        guard let cardView = recognizer.view as? CardView else { return }
    
        switch cardView.state {
        case .unselected:
            cardView.state = .selected
            selectedCardViews.append(cardView)
            print(selectedCardViews)
            
        case .selected:
            if selectedCardViews.count < 2 {
                selectedCardViews.removeThis(element: cardView)
                cardView.state = .unselected
                print(selectedCardViews)
            } else {
                break
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

