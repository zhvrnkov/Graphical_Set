//
//  ViewController.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 22/06/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SetGameDelegate {
    
    private(set) var game = SetGame(cooperateMode: true)
    
    private(set) var cardViews = [CardView]()

    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        game.delegate = self
        game.draw(cards: 12)
    }
    
    
    override func viewDidLayoutSubviews() {
        updateViewFromModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func checkCardInVC() {
        game.checkSelectedCards(cb: game.draw)
        cardViews.forEach { $0.state = .unselected }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func panGestureOnBoardView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended:
            if game.selectedCards.count != 3 {
                game.draw(cards: 3)
                game.timeIntreval *= 2
            } else {
                checkCardInVC()
            }
        default:
            break
        }
    }
    
    func updateViewFromModel() {
        var grid = Grid(layout: .aspectRatio(63.15/88.9), frame: boardView.bounds)
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
            }
        }
    }
    
    func updateScoreView(with score: Int) {
        scoreLabel.text = String(score)
    }
    
    @objc func cardTapped(_ recognizer: UITapGestureRecognizer) {
        guard let cardView = recognizer.view as? CardView else { return }
    
        switch cardView.state {
        case .unselected:
            if game.selectedCards.count == 3 {
                checkCardInVC()
            }
            cardView.state = .selected
            game.selectThis(card: cardView.card)
            
        case .selected:
            if game.selectedCards.count < 2 {
                game.unSelectThisCard(card: cardView.card)
                cardView.state = .unselected
            } else {
                break
            }
        }
        print(game.selectedCards.count)
    }
}

