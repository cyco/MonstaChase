//
//  Game.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 23/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation

typealias Board = [Piece]

enum GameOutcome {
    case None
    case Win
    case Lose
}

class Game {
    var width: Int, height: Int
    var density: Float
    var board: Board = []
    var enemies: [Enemy] = []
    var player: Hero = Hero()

    init(width:Int, height: Int, density: Float) {
        self.width = width
        self.height = height
        self.density = density
    }

    func checkOutcome() -> GameOutcome {
        if player.x == self.width - 1 {
            return .Win
        }

        for enemy in enemies {
            if player.x == enemy.x && player.y == enemy.y {
                return .Lose
            }
        }

        return .None
    }

    func move(character: Character, direction:Direction) -> Bool {
        let targetX = character.x + direction.xDiff()
        let targetY = character.y + direction.yDiff()

        guard board[targetX + targetY * self.width] != .Wall else { return false }

        character.x = targetX
        character.y = targetY
        character.face = direction

        return true
    }

    func placeHero() {
        player.x = 1
        player.y = self.height / 2
        player.face = .East
    }

    func placeEnemies(count: Int){
        enemies.removeAll()

        for i in 0..<count {
            let enemy = Enemy()
            enemy.x = width - 2
            enemy.y = 1 + ((height - 2) / (count + 1)) * (i + 1)
            enemy.face = .West

            enemies.append(enemy)
        }
    }
}
