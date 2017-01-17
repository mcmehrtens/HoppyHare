//
//  GameStats.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/7/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class GameStats {
    /* Make the constant defaults variable */
    static let defaults = UserDefaults.standard
    
    /* Game statistic default names */
    static let highScore = "highScore"
    static let avgScore = "avgScore"
    static let totalJumps = "jumps"
    static let avgJumps = "avgJumps"
    static let jumpRecord = "jumpRecord"
    static let totalGames = "totalGames"
    
    static let gameDiff = "gameDiff"
    
    static let soundEnabled = "soundEnabled"
    static let musicEnabled = "musicEnabled"
    
    static let scoreboardSide = "scoreboardSide"
    
    static let loadedBefore = "loadedBefore"
    
    /* Find the average of an array of integers */
    static func findAvg(array: [Int]) -> Int {
        var total = 0
        
        /* Adds up all the values in the array */
        for i in array {
            total += i
        }
        
        /* Find the average by taking the total divided by the number of values in the array */
        return Int(total / array.count)
    }
}
