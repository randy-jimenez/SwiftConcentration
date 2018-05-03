//
//  CardDeck.swift
//  Concentration
//
//  Created by Randy on 5/2/18.
//  Copyright © 2018 Randy Jimenez. All rights reserved.
//

import Foundation
import GameplayKit
import UIKit

class CardDeck {
    var cards: [UIButton: Card] = [:]
    var flippedCards: [Card] = []

    init(buttons: [UIButton]) {
        let numEmojis = buttons.count / 2
        var all_emojis: [String] = []

        for i in 0x1F601...0x1F64F {
            all_emojis.append(String(UnicodeScalar(i)!))
        }

        all_emojis = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: all_emojis) as! [String]

        var emojis = [String](all_emojis[..<numEmojis])
        emojis = emojis + emojis
        emojis = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: emojis) as! [String]

        for i in 0..<buttons.count{
            let button = buttons[i]
            let emoji = emojis[i]
            cards[button] = Card(cardButton: button, cardEmoji: emoji)
        }
    }

    func flip(button: UIButton) {
        if let card = cards[button] {
            card.flip()
            if card.status == .faceUp {
                flippedCards.append(card)
            }
        }
    }

    func checkForMatch() -> Bool {
        if flippedCards[0].emoji == flippedCards[1].emoji {
            flippedCards = []
            return true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                for card in self.flippedCards {
                    self.flip(button: card.button)
                }
                self.flippedCards = []
            }
            return false
        }
    }
}
