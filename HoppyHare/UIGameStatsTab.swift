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
    var nodes: [SKNode] = []
    var labels: [SKLabelNode] = []
    
    /* Adds the Game Stats Tab */
    override func addElement() {
        super.addElement()
        setButtonHandlers()
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
    
    /* Updates the values of the labels in the gameStatsTab */
    func updateLabels() {
        /* Make the text of all the stat labels = to what they actually are in the defaults */
        labels[0].text = String(GameStats.getStat(statName: GameStats.highScore))
        labels[1].text = String(GameStats.getStat(statName: GameStats.avgScore))
        labels[2].text = String(GameStats.getStat(statName: GameStats.jumpRecord))
        labels[3].text = String(GameStats.getStat(statName: GameStats.avgJumps))
        labels[4].text = String(GameStats.getStat(statName: GameStats.totalJumps))
        labels[5].text = String(GameStats.getStat(statName: GameStats.totalGames))
    }
    
    /* Animates the gameStatsTab */
    func animate() {
        /* Wait for 0.45 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.45))
        
        /* Animated the referenceNode */
        self.referenceNode.run(SKAction.sequence([wait, SKAction.run { self.labels[0].isHidden = false }, wait, SKAction.run { self.labels[1].isHidden = false }, wait, SKAction.run { self.labels[2].isHidden = false }, wait, SKAction.run { self.labels[3].isHidden = false }, wait, SKAction.run { self.labels[4].isHidden = false }, wait, SKAction.run { self.labels[5].isHidden = false }]))
    }
    
    /* Sets the button handlers for the game stats tab*/
    override func setButtonHandlers() {
        /* Set the references to the buttons in the gameStatsTab */
        let backButton = referenceNode.childNode(withName: ".//backButton") as! MSButtonNode
        let replayButton = referenceNode.childNode(withName: ".//replayButton") as! MSButtonNode
        //let gameStatsTabShareButton_1 = referenceNode.childNode(withName: "//gameStatsTabShareButton_1") as! MSButtonNode
        
        /* Handler for the back button */
        backButton.selectedHandler = {
            self.removeElement()
        }
        
        /* Handler for the replay button. Same as the gameOverMenuReplayButton_1 handler */
        replayButton.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.baseScene.view as SKView!
            
            /* Load Game scene */
            let scene = InfiniteGameScene(fileNamed: "InfiniteGameScene") as InfiniteGameScene!
            
            /* Ensure correct aspect mode */
            scene!.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView!.presentScene(scene)
        }
    }
}

class UIGameStats: UIElement {
    var nodes: [SKNode] = []
    var labels: [SKLabelNode] = []
    
    /* Override the addElement method and remove the setButtonhandlers function call */
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
    
    /* Updates the values of the labels in the gameStatsTab */
    func updateLabels() {
        /* Make the text of all the stat labels = to what they actually are in the defaults */
        labels[0].text = String(GameStats.getStat(statName: GameStats.highScore))
        labels[1].text = String(GameStats.getStat(statName: GameStats.avgScore))
        labels[2].text = String(GameStats.getStat(statName: GameStats.jumpRecord))
        labels[3].text = String(GameStats.getStat(statName: GameStats.avgJumps))
        labels[4].text = String(GameStats.getStat(statName: GameStats.totalJumps))
        labels[5].text = String(GameStats.getStat(statName: GameStats.totalGames))
    }
    
    /* Animates the gameStatsTab */
    func animate() {
        /* Wait for 0.45 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.45))
        
        /* Animated the referenceNode */
        self.referenceNode.run(SKAction.sequence([wait, SKAction.run { self.labels[0].isHidden = false }, wait, SKAction.run { self.labels[1].isHidden = false }, wait, SKAction.run { self.labels[2].isHidden = false }, wait, SKAction.run { self.labels[3].isHidden = false }, wait, SKAction.run { self.labels[4].isHidden = false }, wait, SKAction.run { self.labels[5].isHidden = false }]))
    }
}
