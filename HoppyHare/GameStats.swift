//
//  GameStats.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/7/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class GameStats {
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
    static let scoreboardSwitcher = "scoreboardSwitcher"
    
    /* Gets a specific game stat */
    static func getStat(statName: String) -> Int {
        let defaults = UserDefaults.standard
        
        if statName == GameStats.gameDiff && defaults.integer(forKey: GameStats.gameDiff) == 0 {
            return 1
        }
        
        return defaults.integer(forKey: statName)
    }
    
    /* Sets a specific game stat */
    static func setStat(statName: String, value: Int) {
        let defaults = UserDefaults.standard
        
        if statName == GameStats.avgScore {
            if defaults.array(forKey: "avgScoreArray") == nil {
                let avgScoreArray: [Int] = [value]
                
                defaults.set(avgScoreArray, forKey: "avgScoreArray")
            } else {
                var avgScoreArray = defaults.array(forKey: "avgScoreArray") as! [Int]
                avgScoreArray.append(value)
                
                defaults.set(avgScoreArray, forKey: "avgScoreArray")
            }
            
            defaults.set(findAvg(array: defaults.array(forKey: "avgScoreArray") as! [Int]), forKey: "avgScore")
            return
        }
        
        if statName == GameStats.avgJumps {
            if defaults.array(forKey: "avgJumpsArray") == nil {
                let avgJumpsArray: [Int] = [value]
                
                defaults.set(avgJumpsArray, forKey: "avgJumpsArray")
            } else {
                var avgJumpsArray = defaults.array(forKey: "avgJumpsArray") as! [Int]
                avgJumpsArray.append(value)
                
                defaults.set(avgJumpsArray, forKey: "avgJumpsArray")
            }
            
            defaults.set(findAvg(array: defaults.array(forKey: "avgJumpsArray") as! [Int]), forKey: "avgJumps")
            return
        }
        
        defaults.set(value, forKey: statName)
    }
    
    /* Updates the game stats */
    static func updateStats(score: Int, jumps: Int) {
        GameStats.setStat(statName: GameStats.avgScore, value: score) // Sets the average score stat
        
        /* Set the jump record game stat */
        if jumps > GameStats.getStat(statName: GameStats.jumpRecord) {
            GameStats.setStat(statName: GameStats.jumpRecord, value: jumps)
        }
        
        GameStats.setStat(statName: GameStats.avgJumps, value: jumps) // Sets the average jumps stat
        
        GameStats.setStat(statName: GameStats.totalJumps, value: GameStats.getStat(statName: GameStats.totalJumps) + jumps) // Sets the total jumps stat
        GameStats.setStat(statName: GameStats.totalGames, value: GameStats.getStat(statName: GameStats.totalGames) + 1) // Sets the total games stat
    }
    
    /* Find the average of an array of integers */
    static func findAvg(array: [Int]) -> Int {
        var total = 0
        
        for i in array {
            total += i
        }
        
        return Int(total / array.count)
    }
}
