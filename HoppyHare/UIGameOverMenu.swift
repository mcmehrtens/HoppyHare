//
//  UIGameOverMenu.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIGameOverMenu: UIElement {
    var score: Int!
    var jumps: Int!
    var highScore: Int!
    var isNewHighScore: Bool = false
    
    var gameStatsTab: UIGameStatsTab!
    
    init(baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, resourcePath: String, resourceType: String, score: Int, jumps: Int, highScore: Int, isNewHighScore: Bool) {
        self.score = score
        self.jumps = jumps
        self.highScore = highScore
        self.isNewHighScore = isNewHighScore
        
        super.init(baseScene: baseScene, pos: pos, zPos: zPos, referenceName: referenceName, resourcePath: resourcePath, resourceType: resourceType)
    }
    
    override func addElement() {
        super.addElement()
        setButtonHandlers()
        updateValues()
        animate()
    }
    
    /* Set the button handlers for the GameOverMenu */
    override func setButtonHandlers() {
        let gameStatsButton = referenceNode.childNode(withName: "//gameStatsButton") as! MSButtonNode
        let replayButton = referenceNode.childNode(withName: "//replayButton") as! MSButtonNode
        
        /* Set the handler for the game stats tab button */
        gameStatsButton.selectedHandler = {
            self.gameStatsTab = UIGameStatsTab(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 6, referenceName: "gameStatsTabReferenceNode", resourcePath: "GameStatsTab", resourceType: "sks")
        }
        
        /* Set the handler for the replay button */
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
    
    /* Update values */
    func updateValues() {
        /* Get the references to the labels */
        let score = referenceNode.childNode(withName: ".//score") as! SKLabelNode
        let jumps = referenceNode.childNode(withName: ".//jumps") as! SKLabelNode
        let highScore = referenceNode.childNode(withName: ".//highScore") as! SKLabelNode
        
        score.text = String(self.score)
        jumps.text = String(self.jumps)
        highScore.text = String(self.highScore)
    }
    
    /* Animate the gameOverMenu */
    func animate() {
        /* Get the references to the labels */
        let score = referenceNode.childNode(withName: ".//score") as! SKLabelNode
        let jumps = referenceNode.childNode(withName: ".//jumps") as! SKLabelNode
        let highScore = referenceNode.childNode(withName: ".//highScore") as! SKLabelNode
        let newHighScoreLabel = referenceNode.childNode(withName: ".//newHighScoreLabel") as! SKLabelNode
        
        /* Display the score label */
        let displayScore = SKAction.run {
            score.isHidden = false
        }
        
        /* Display the jump label */
        let displayJumps = SKAction.run {
            jumps.isHidden = false
        }
        
        /* Display the high score label */
        let displayHighScore = SKAction.run {
            highScore.isHidden = false
        }
        
        /* Display the new high score label */
        let displayNewHighScoreLabel = SKAction.run {
            if self.isNewHighScore {
                newHighScoreLabel.isHidden = false
            }
        }
        
        /* Wait for 0.5 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        
        /* Wait 0.5 seconds, display score, wait, display jumps, wait, display high score, wait, and then display */
        referenceNode.run(SKAction.sequence([wait, displayScore, wait, displayJumps, wait, displayHighScore, wait, displayNewHighScoreLabel]))
    }
}
