//
//  Hero.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 23/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation
import UIKit

class Hero : Character {
    override init() {
        super.init()

        image = UIImage(named: "player")!
    }
}