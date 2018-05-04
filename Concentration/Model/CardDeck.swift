//
//  CardDeck.swift
//  Concentration
//
//  Created by Randy on 5/2/18.
//  Copyright © 2018 Randy Jimenez. All rights reserved.
//

import Foundation
import GameplayKit

class CardDeck {
    var cards: [Card] = []
    var flippedCards: [Int] = []
    var flipCount: Int = 0
    var scoredCards: [Int] = []
    var score: Int = 0

    init(numCards: Int) {
        let numEmojis = numCards / 2
        var all_emojis: [String] = []

        for i in 0x1F601...0x1F64F {
            all_emojis.append(String(UnicodeScalar(i)!))
        }

        all_emojis = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: all_emojis) as! [String]

        var emojis = [String](all_emojis[..<numEmojis])
        emojis = emojis + emojis
        emojis = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: emojis) as! [String]

        for i in 0..<numCards{
            let emoji = emojis[i]
            cards.append(Card(cardEmoji: emoji))
        }
    }

    func getCard(at index: Int) -> Card {
        return cards[index]
    }

    func flip(at index: Int) {
        if scoredCards.index(of: index) != nil {
            return
        } else if flippedCards.index(of: index) != nil || flippedCards.count < 2 {
            let card = getCard(at: index)
            card.flip()
            flipCount += 1
            
            if card.status == .faceUp {
                flippedCards.append(index)
            } else {
                flippedCards.remove(at: flippedCards.index(of: index)!)
            }

            if flippedCards.count == 2 && getCard(at: flippedCards[0]).emoji == getCard(at: flippedCards[1]).emoji {
                score += 1
                scoredCards.append(flippedCards[0])
                scoredCards.append(flippedCards[1])
                flippedCards = []
            }
        }
    }
}
