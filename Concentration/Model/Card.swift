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
    var emoji: String!

    init(cardEmoji: String) {
        emoji = cardEmoji
    }

    func flip() {
        status = status == .faceDown ? .faceUp : .faceDown
    }
}
