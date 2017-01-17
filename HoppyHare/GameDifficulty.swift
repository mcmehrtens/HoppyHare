//
//  GameDifficulty.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/7/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

/* Struct that has the variables with the different game difficulty */
struct GameDifficulty {
    static var goalHeight: CGFloat!
    static var maxHeight: CGFloat!
    static var minHeight: CGFloat!
    
    static func setDifficulty() {
        switch GameStats.defaults.integer(forKey: GameStats.gameDiff) {
        case 0:
            GameStats.defaults.set(1, forKey: GameStats.gameDiff)
            GameDifficulty.setDifficulty()
        case 1:
            self.goalHeight = 103.5
            self.maxHeight = 161.0
            self.minHeight = -36.0
        case 2:
            self.goalHeight = 102.0
            self.maxHeight = 162.0
            self.minHeight = -37.0
        case 3:
            self.goalHeight = 100.5
            self.maxHeight = 163.0
            self.minHeight = -38.0
        case 4:
            self.goalHeight = 99.0
            self.maxHeight = 164.0
            self.minHeight = -39.0
        case 5:
            self.goalHeight = 97.5
            self.maxHeight = 165.0
            self.minHeight = -40.0
        case 6:
            self.goalHeight = 96.0
            self.maxHeight = 166.0
            self.minHeight = -41.0
        case 7:
            self.goalHeight = 94.5
            self.maxHeight = 167.0
            self.minHeight = -42.0
        case 8:
            self.goalHeight = 93.0
            self.maxHeight = 168.0
            self.minHeight = -43.0
        case 9:
            self.goalHeight = 91.5
            self.maxHeight = 169.0
            self.minHeight = -44.0
        case 10:
            self.goalHeight = 90.0
            self.maxHeight = 170.0
            self.minHeight = -45.0
        default:
            print("[Error] Difficulty level out of bounds.")
        }
    }
}
