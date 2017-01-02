//
//  GameStats.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 12/22/16.
//  Copyright © 2016 Mattkx4. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameStats: SKScene {
    /* Array that contains all the text nodes */
    var textObjects: [SKNode] = []
    
    /* Set up the scene here */
    override func didMove(to view: SKView) {
        /* Set the label references */
        textObjects = [self.childNode(withName: "allTimeHighScoreNode")!]
        textObjects.append(self.childNode(withName: "allTimeScoreNode")!)
        textObjects.append(self.childNode(withName: "allTimeJumpsNode")!)
        textObjects.append(self.childNode(withName: "mostJumpsInOneGameNode")!)
        textObjects.append(self.childNode(withName: "totalGamesPlayedNode")!)
        textObjects.append(self.childNode(withName: "numOfCostumesDiscoveredNode")!)
        textObjects.append(self.childNode(withName: "favCostumeNode")!)
        textObjects.append(self.childNode(withName: "numOfTimesScorePrec1Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc25Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc50Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc100Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc250Node")!)
        textObjects.append(self.childNode(withName: "backLabel")!)
        
        /* Make the text of all the stat labels = to what they actually are in the defaults */
        (self.childNode(withName: "//allTimeHighScore") as! SKLabelNode).text = String(StoredStats.allTimeHighScore)
        (self.childNode(withName: "//allTimeScore") as! SKLabelNode).text = String(StoredStats.allTimeScore)
        (self.childNode(withName: "//allTimeJumps") as! SKLabelNode).text = String(StoredStats.allTimeJumps)
        (self.childNode(withName: "//mostJumpsInOneGame") as! SKLabelNode).text = String(StoredStats.mostJumpsInOneGame)
        (self.childNode(withName: "//totalGamesPlayed") as! SKLabelNode).text = String(StoredStats.totalGamesPlayed)
        (self.childNode(withName: "//numOfCostumesDiscovered") as! SKLabelNode).text = String(StoredStats.numOfCostumesDiscovered)
        (self.childNode(withName: "//favCostume") as! SKLabelNode).text = StoredStats.favCostume
        (self.childNode(withName: "//numOfTimesScorePrec1") as! SKLabelNode).text = String(StoredStats.numOfTimesScorePrec1)
        (self.childNode(withName: "//numOfTimesScoreExc25") as! SKLabelNode).text = String(StoredStats.numOfTimesScoreExc25)
        (self.childNode(withName: "//numOfTimesScoreExc50") as! SKLabelNode).text = String(StoredStats.numOfTimesScoreExc50)
        (self.childNode(withName: "//numOfTimesScoreExc100") as! SKLabelNode).text = String(StoredStats.numOfTimesScoreExc100)
        (self.childNode(withName: "//numOfTimesScoreExc250") as! SKLabelNode).text = String(StoredStats.numOfTimesScoreExc250)
        
        /* Slide the text onto the screen */
        slideOnText()
    }
    
    /* Slide on all the text */
    func slideOnText() {
        /* This variable increases by 0.1 every time a new object has been slid on */
        var startTime = 0.0
        
        /* Duration goes down by 0.01 every time an object slides in. This makes the animation a little snappier. */
        var duration = 0.5
        
        /* This action is what slides the objects onto the screen. */
        let slideIn: SKAction = SKAction.moveBy(x: CGFloat(0.0), y: CGFloat(466.0), duration: duration)
        
        /* Run the action on every object in the textObjects[] */
        for node in textObjects {
            /* Create an action to delay the start of the slideIn action */
            let wait = SKAction.wait(forDuration: startTime)
            
            /* Create a sequence that first has the delay and then the slideIn function. */
            let waitSlide = SKAction.sequence([wait, slideIn])
            
            /* This changes the duration of slideIn to whatever the duration variable is. */
            slideIn.duration = duration
            
            /* Run the animation on whatever node is being run through. */
            node.run(waitSlide)
            
            /* Increment the start time. */
            startTime += 0.1
            
            /* Decrement the duration. */
            duration -= 0.01
        }
    }
    
    /* If the screen is tapped, return to the game! */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Grab reference to our SpriteKit view */
        let skView = self.view as SKView!
        
        /* Load Game scene */
        let scene = InfiniteGameScene(fileNamed:"InfiniteGameScene") as InfiniteGameScene!
        
        /* Ensure correct aspect mode */
        scene!.scaleMode = .aspectFill
        
        /* Restart game scene */
        skView!.presentScene(scene)
    }
    
    /* This func updates all game stats in one function. Move this function from the main InfiniteGameScene page to clean things up a bit. */
    static func updateGameStats(score: Int, jumps: Int) {
        /* Set new high score if the score is higher than the current high score. */
        if score > StoredStats.allTimeHighScore {
            StoredStats.defaults.set(score, forKey: "allTimeHighScore")
        }
        
        /* Add the score onto the allTimeHighScore stat */
        StoredStats.allTimeScore! += score
        StoredStats.defaults.set(StoredStats.allTimeScore, forKey: "allTimeScore")
        
        /* Add the jumps onto the allTimeJumps stats */
        StoredStats.allTimeJumps! += jumps
        StoredStats.defaults.set(StoredStats.allTimeJumps, forKey: "allTimeJumps")
        
        /* Check to see if the jumps is greater than the mostJumpsInOneGame stat */
        if jumps > StoredStats.mostJumpsInOneGame! {
            /* If yes, set the value of mostJumpsInOneGame to the number of jumps */
            StoredStats.mostJumpsInOneGame = jumps
            StoredStats.defaults.set(StoredStats.mostJumpsInOneGame, forKey: "mostJumpsInOneGame")
        }
        
        /* Add one to the total games played */
        StoredStats.totalGamesPlayed! += 1
        StoredStats.defaults.set(StoredStats.totalGamesPlayed, forKey: "totalGamesPlayed")
        
        /* Check to see the score and increment the appropriate game stats. */
        if score < 1 {
            StoredStats.numOfTimesScorePrec1! += 1
            StoredStats.defaults.set(StoredStats.numOfTimesScorePrec1, forKey: "numOfTimesScorePrec1")
        } else if score > 25 {
            StoredStats.numOfTimesScoreExc25! += 1
            StoredStats.defaults.set(StoredStats.numOfTimesScoreExc25, forKey: "numOfTimesScoreExc25")
            
            if score > 50 {
                StoredStats.numOfTimesScoreExc50! += 1
                StoredStats.defaults.set(StoredStats.numOfTimesScoreExc50, forKey: "numOfTimesScoreExc50")
                
                if score > 100 {
                    StoredStats.numOfTimesScoreExc100! += 1
                    StoredStats.defaults.set(StoredStats.numOfTimesScoreExc100, forKey: "numOfTimesScoreExc100")
                    
                    if score > 250 {
                        StoredStats.numOfTimesScoreExc250! += 1
                        StoredStats.defaults.set(StoredStats.numOfTimesScoreExc250, forKey: "numOfTimesScoreExc250")
                    }
                }
            }
        }
    }
}

struct StoredStats {
    static let defaults = UserDefaults.standard
    static var allTimeHighScore: Int!
    static var allTimeScore: Int!
    static var allTimeJumps: Int!
    static var mostJumpsInOneGame: Int!
    static var totalGamesPlayed: Int!
    static var numOfCostumesDiscovered: Int!
    static var favCostume: String = "Not Implemented"
    static var numOfTimesScorePrec1: Int!
    static var numOfTimesScoreExc25: Int!
    static var numOfTimesScoreExc50: Int!
    static var numOfTimesScoreExc100: Int!
    static var numOfTimesScoreExc250: Int!
    
    /* Initialize defaults */
    static func initDefaults() {
        /* Get the high score value */
        allTimeHighScore = defaults.integer(forKey: "allTimeHighScore")
        allTimeScore = defaults.integer(forKey: "allTimeScore")
        allTimeJumps = defaults.integer(forKey: "allTimeJumps")
        mostJumpsInOneGame = defaults.integer(forKey: "mostJumpsInOneGame")
        totalGamesPlayed = defaults.integer(forKey: "totalGamesPlayed")
        numOfCostumesDiscovered = defaults.integer(forKey: "numOfCostumesDiscovered")
        if numOfCostumesDiscovered == 0 {
            numOfCostumesDiscovered = 1
        }
        //favCostume = defaults.string(forKey: "favCostume")
        numOfTimesScorePrec1 = defaults.integer(forKey: "numOfTimesScorePrec1")
        numOfTimesScoreExc25 = defaults.integer(forKey: "numOfTimesScoreExc25")
        numOfTimesScoreExc50 = defaults.integer(forKey: "numOfTimesScoreExc50")
        numOfTimesScoreExc100 = defaults.integer(forKey: "numOfTimesScoreExc100")
        numOfTimesScoreExc250 = defaults.integer(forKey: "numOfTimesScoreExc250")
    }
}
