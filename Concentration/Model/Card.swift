//
//  Card.swift
//  Concentration
//
//  Created by Randy on 5/2/18.
//  Copyright © 2018 Randy Jimenez. All rights reserved.
//

import Foundation
import UIKit

enum CardStatus {
    case faceUp
    case faceDown
}

class Card {
    var status: CardStatus = .faceDown
    var faceColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var backColor: UIColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    var button: UIButton!
    var emoji: String!

    init(cardButton: UIButton, cardEmoji: String) {
        button = cardButton
        emoji = cardEmoji
    }

    func flip() {
        if status == .faceDown {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = faceColor
            status = .faceUp
        } else {
            button.setTitle(nil, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            status = .faceDown
        }
    }
}
