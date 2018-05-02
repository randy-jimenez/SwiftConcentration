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
    let emojis: [String] = ["😹", "😻", "😼", "🙀", "😾", "😿"]
    var cardValues: [String]!
    var flippedCards: [UIButton] = []
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardValues = emojis + emojis
        cardValues = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cardValues) as! [String]
    }

    func flipCard(card: UIButton) {
        if let senderIndex = cardButtons.index(of: card) {
            card.setTitle(cardValues[senderIndex], for: .normal)
            card.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            flippedCards.append(card)
            flipCount += 1
        }
    }

    func unflipCard(card: UIButton) {
        card.setTitle(nil, for: .normal)
        card.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    }

    @IBAction func cardButtonPressed(_ sender: UIButton) {
        if flippedCards.count < 2 {
            if sender.currentTitle == nil {
                flipCard(card: sender)
            } else {
                unflipCard(card: sender)
            }
        }
        if flippedCards.count == 2 {
            if flippedCards[0].currentTitle == flippedCards[1].currentTitle {
                score += 1
                flippedCards = []
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for card in self.flippedCards {
                        self.unflipCard(card: card)
                    }
                    self.flippedCards = []
                }
            }
        }
    }
}

