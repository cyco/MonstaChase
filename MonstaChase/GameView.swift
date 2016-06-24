//
//  GameView.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 23/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation
import UIKit

class GameView: UIView {
    var game: Game?
    @IBOutlet var wonGames: UILabel!
    @IBOutlet var lostGames: UILabel!

    let tileWidth:CGFloat = 64;
    let tileHeight:CGFloat = 64;

    override func drawRect(rect: CGRect) {
        UIColor.blackColor().setFill()
        UIRectFill(rect)

        guard game != nil else { return }

        for y in 0..<game!.height {
            for x in 0..<game!.width {
                let tile = game!.board[x + y * game!.width]
                let imageName = tile == .Floor ? "floor" : "wall"
                let image = UIImage(named: imageName)
                let tileRect = CGRectMake(CGFloat(x)*tileWidth, CGFloat(y)*tileHeight, tileWidth, tileHeight)
                image?.drawInRect(tileRect)
            }
        }

        drawCharacter(game!.player);
        game!.enemies.forEach(self.drawCharacter)
    }

    override func didMoveToWindow() {
        registerGestureRecognizer(UIPressType.DownArrow, selector: #selector(moveDown))
        registerGestureRecognizer(UIPressType.UpArrow, selector: #selector(moveUp))
        registerGestureRecognizer(UIPressType.RightArrow, selector: #selector(moveRight))
        registerGestureRecognizer(UIPressType.LeftArrow, selector: #selector(moveLeft))
    }

    func registerGestureRecognizer(type: UIPressType, selector:Selector) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        gestureRecognizer.allowedPressTypes = [ type.rawValue ]
        self.superview!.addGestureRecognizer(gestureRecognizer)
    }

    func moveLeft(recognizer:UIGestureRecognizer) {
        moveHero(.West)
    }

    func moveRight(recognizer:UIGestureRecognizer) {
        moveHero(.East)
    }

    func moveUp(recognizer:UIGestureRecognizer) {
        moveHero(.North)
    }

    func moveDown(recognizer:UIGestureRecognizer) {
        moveHero(.South)
    }

    func moveHero(direction: Direction) {
        guard game != nil else { return }

        game!.move(game!.player, direction: direction)
        var outcome = game!.checkOutcome()
        if outcome == .None {
            game!.enemies.forEach({ $0.move(game!) })
            outcome = game!.checkOutcome()
        }

        if outcome == .Win {
            wonGames.text = String(format: "%d", Int(wonGames.text!)!+1)
        } else if outcome == .Lose {
            lostGames.text = String(format: "%d", Int(lostGames.text!)!+1)
        }

        if outcome != .None {
            game?.density = 0.1 + Float(rand() % 3) / 10
            let generator = BoardGenerator()
            generator.generate(game!)
            game!.placeHero()
            game!.placeEnemies(1 + random() % 2);
        }
        self.setNeedsDisplay()
    }

    func drawCharacter(char:Character) {
        let image = char.image.imageForDirection(char.face)
        let charRect = CGRectMake(CGFloat(char.x)*tileWidth, CGFloat(char.y)*tileHeight, tileWidth, tileHeight)
        image.drawInRect(charRect)
    }

    override func intrinsicContentSize() -> CGSize {
        guard game != nil else { return CGSizeZero }
        return CGSizeMake(CGFloat(game!.width) * tileWidth, CGFloat(game!.height) * tileHeight)
    }
}