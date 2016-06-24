//
//  MapGenerator.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 23/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation

class BoardGenerator {
    func generate(game: Game) {
        game.board = Board(count: game.width * game.height, repeatedValue: .Floor)

        for y in 0..<game.height {
            game.board[0 + y * game.width] = .Wall
            game.board[game.width-1 + y * game.width] = .Wall
        }

        for x in 0..<game.width {
            game.board[x + 0 * game.width] = .Wall
            game.board[x + (game.height-1) * game.width] = .Wall
        }

        for y in 2..<game.height-2 {
            for x in 2..<game.width-2 {
                game.board[x + y * game.width] = (rand() % Int32(1/game.density)) == 0 ? .Wall : .Floor
            }
        }

        game.board[game.width-1 + game.width * game.height/2] = .Floor
    }
}
