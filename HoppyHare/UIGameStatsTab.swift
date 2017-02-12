//
//  UIGameStatsTab.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIGameStatsTab: UIElement {
    var labels: [SKLabelNode]! // Array that contains all the label references
    
    /* Adds the Game Stats Tab element to the screen as well as sets the button handlers, populates the labels array, updates the labels with the new information, and animates the whole thing. */
    override func addElement() {
        super.addElement()
        setButtonHandlers()
        populateLabels()
        updateLabels()
        animate()
    }
    
    /* Populates the label array */
    func populateLabels() {
        labels = [referenceNode.childNode(withName: ".//highScore") as! SKLabelNode]
        labels.append(referenceNode.childNode(withName: ".//avgScore") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//jumpRecord") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//avgJumps") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//totalJumps") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//totalGames") as! SKLabelNode)
    }
    
    /* Updates the values of the labels in the gameStatsTab */
    func updateLabels() {
        /* Make the text of all the stat labels = to what they actually are in the defaults */
        labels[0].text = String(GameStats.defaults.integer(forKey: GameStats.highScore))
        labels[1].text = String(GameStats.findAvg(array: GameStats.defaults.array(forKey: GameStats.avgScore) as! [Int])) // Finds the average of all the games in the avgScore array
        labels[2].text = String(GameStats.defaults.integer(forKey: GameStats.jumpRecord))
        labels[3].text = String(GameStats.defaults.integer(forKey: GameStats.avgJumps))
        labels[3].text = String(GameStats.findAvg(array: GameStats.defaults.array(forKey: GameStats.avgJumps) as! [Int])) // Finds the average of all the games in the avgJumps array
        labels[4].text = String(GameStats.defaults.integer(forKey: GameStats.totalJumps))
        labels[5].text = String(GameStats.defaults.integer(forKey: GameStats.totalGames))
    }
    
    /* Animates the gameStatsTab */
    func animate() {
        /* Wait for 0.45 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.45))
        
        /* Animates the gameStatsTab:
         1. Display high score
         2. Wait 0.45s
         3. Display the average score
         4. Wait 0.45s
         5. Display the jump record
         6. Wait 0.45s
         7. Display the average jumps
         8. Wait 0.45s
         9. Display the total jumps
         10. Wait 0.45s
         11. Display the total games
         */
        referenceNode.run(SKAction.sequence([wait, SKAction.run { self.labels[0].isHidden = false }, wait, SKAction.run { self.labels[1].isHidden = false }, wait, SKAction.run { self.labels[2].isHidden = false }, wait, SKAction.run { self.labels[3].isHidden = false }, wait, SKAction.run { self.labels[4].isHidden = false }, wait, SKAction.run { self.labels[5].isHidden = false }]))
    }
    
    /* Sets the button handlers for the game stats tab */
    func setButtonHandlers() {
        /* Set the references to the buttons in the gameStatsTab */
        let backButton = referenceNode.childNode(withName: ".//backButton") as! MSButtonNode
        let replayButton = referenceNode.childNode(withName: ".//replayButton") as! MSButtonNode
        
        /* Share button hasn't been implemented yet. It's an iffy feature anyway. We'll see about this */
        //let gameStatsTabShareButton_1 = referenceNode.childNode(withName: "//gameStatsTabShareButton_1") as! MSButtonNode
        
        /* Handler for the back button - Removes the GameStatsTab from the screen */
        backButton.selectedHandler = {
            self.removeElement()
        }
        
        /* Handler for the replay button. Restarts the game ;) */
        replayButton.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.baseScene.view as SKView!
            
            /* Load Game scene */
            let scene = InfiniteGameScene()
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView!.presentScene(scene)
        }
    }
}

class UIGameStats: UIElement {
    var labels: [SKLabelNode]! // Array that contains all the label references
    
    /* Adds the Game Stats element to the screen as well populates the labels array, updates the labels with the new information, and animates the whole thing. */
    override func addElement() {
        super.addElement()
        populateLabels()
        updateLabels()
        animate()
    }
    
    /* Populates the label arrary */
    func populateLabels() {
        labels = [referenceNode.childNode(withName: ".//highScore") as! SKLabelNode]
        labels.append(referenceNode.childNode(withName: ".//avgScore") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//jumpRecord") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//avgJumps") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//totalJumps") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//totalGames") as! SKLabelNode)
    }
    
    /* Updates the values of the labels in the gameStats element */
    func updateLabels() {
        /* Make the text of all the stat labels = to what they actually are in the defaults */
        labels[0].text = String(GameStats.defaults.integer(forKey: GameStats.highScore))
        labels[1].text = String(GameStats.findAvg(array: GameStats.defaults.array(forKey: GameStats.avgScore) as! [Int])) // Finds the average of all the games in the avgScore array
        labels[2].text = String(GameStats.defaults.integer(forKey: GameStats.jumpRecord))
        labels[3].text = String(GameStats.findAvg(array: GameStats.defaults.array(forKey: GameStats.avgJumps) as! [Int])) // Finds the average of all the games in the avgJumps array
        labels[4].text = String(GameStats.defaults.integer(forKey: GameStats.totalJumps))
        labels[5].text = String(GameStats.defaults.integer(forKey: GameStats.totalGames))
    }
    
    /* Animates the gameStats element and it's values onto the screen */
    func animate() {
        /* Wait for 0.45 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.45))
        
        /* Animates the gameStats element:
         1. Display high score
         2. Wait 0.45s
         3. Display the average score
         4. Wait 0.45s
         5. Display the jump record
         6. Wait 0.45s
         7. Display the average jumps
         8. Wait 0.45s
         9. Display the total jumps
         10. Wait 0.45s
         11. Display the total games
         */
        referenceNode.run(SKAction.sequence([wait, SKAction.run { self.labels[0].isHidden = false }, wait, SKAction.run { self.labels[1].isHidden = false }, wait, SKAction.run { self.labels[2].isHidden = false }, wait, SKAction.run { self.labels[3].isHidden = false }, wait, SKAction.run { self.labels[4].isHidden = false }, wait, SKAction.run { self.labels[5].isHidden = false }]))
    }
}
