//
//  Enemy.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 23/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation
import UIKit

class Enemy : Character {
    override init() {
        super.init()

        image = UIImage(named: "enemy")!
    }

    func move(game: Game) {
        var direction: Direction = .West
        let player = game.player

        if x < player.x && game.board[x+1 + y * game.width] != .Wall {
            direction = .East
        } else if x > player.x && game.board[x-1 + y * game.width] != .Wall {
            direction = .West
        } else if y < player.y && game.board[x + (y+1) * game.width] != .Wall {
            direction = .South
        } else if y > player.y && game.board[x + (y-1) * game.width] != .Wall {
            direction = .North
        }

        game.move(self, direction: direction)
    }
}