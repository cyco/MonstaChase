//
//  Direction.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 23/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation

enum Direction {
    case North
    case South
    case East
    case West

    func xDiff() -> Int {
        guard self != .North else { return 0 }
        guard self != .South else { return 0 }

        return self == .East ? 1 : -1
    }

    func yDiff() -> Int {
        guard self != .East else { return 0 }
        guard self != .West else { return 0 }

        return self == .South ? 1 : -1
    }
}