//
//  ViewController.swift
//  Concentration
//
//  Created by Randy on 5/1/18.
//  Copyright © 2018 Randy Jimenez. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    let cardColors: [CardStatus: UIColor] = [.faceUp: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                             .faceDown: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)]
    var deck: CardDeck!

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        deck = CardDeck(numCards: cardButtons.count)
        updateUI()
    }

    func updateUI() {
        for i in 0..<cardButtons.count {
            let button = cardButtons[i]
            let card = deck.getCard(at: i)

            button.backgroundColor = cardColors[card.status]

            if card.status == .faceUp {
                button.setTitle(card.emoji, for: .normal)
            } else {
                button.setTitle(nil, for: .normal)
            }
        }
        scoreLabel.text = "Score: \(deck.score)"
        flipCountLabel.text = "Flips: \(deck.flipCount)"
    }

    @IBAction func cardButtonPressed(_ sender: UIButton) {
        deck.flip(at: cardButtons.index(of: sender)!)
/*        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                for index in self.flippedCards {
                    self.flip(at: index)
                }
                self.flippedCards = []
            }
        }
*/
        updateUI()
    }
}

