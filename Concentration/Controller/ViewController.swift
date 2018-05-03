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
    var deck: CardDeck!
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
        deck = CardDeck(buttons: cardButtons)
    }

    @IBAction func cardButtonPressed(_ sender: UIButton) {
        if deck.flippedCards.count < 2 {
            deck.flip(button: sender)
            flipCount += 1
        }
        if deck.flippedCards.count == 2 {
            let didScore = deck.checkForMatch()

            if didScore {
                score += 1
            }
        }
    }
}

