//
//  ViewController.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 23/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var gameView: GameView!

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.game = Game(width: 22, height: 12, density: 0.5)
        let generator = BoardGenerator()
        generator.generate(gameView.game!)
        gameView.game!.placeHero()
        gameView.game!.placeEnemies(1);
        gameView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
