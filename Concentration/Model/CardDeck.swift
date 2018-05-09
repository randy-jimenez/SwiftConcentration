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
    var cards = Array<Card>()//var cards = [Card]() //var cards: [Card] = [] //var cards: Array<Card> = []
    var flipCount: Int = 0
    var score: Int = 0

    init(numPairs: Int) {
        var all_emojis = (0x1F601...0x1F64F).map({ String(UnicodeScalar($0)!) })
        all_emojis = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: all_emojis) as! [String]
        let emojis = [String](all_emojis[..<numPairs])

        for emoji in emojis {
            cards += [Card(emoji: emoji), Card(emoji: emoji)]
        }

        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
    }

    func getFlippedCards() -> [Card] {
        return cards.filter({ $0.status == .faceUp && $0.isMatched == false })
    }

    func flip(at index: Int) {
        let card = cards[index]

        if !card.isMatched {
            if card.status == .faceUp || getFlippedCards().count < 2 {
                card.flip()
                flipCount += 1

                if card.status == .faceUp {
                    let flippedCards = getFlippedCards()
                    if flippedCards.count == 2 && flippedCards[0].emoji == flippedCards[1].emoji {
                        score += 1
                        flippedCards[0].isMatched = true
                        flippedCards[1].isMatched = true
                    }
                }
            }
        }
    }
}
