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
    var newHighScore: Bool = false
    
    var gameStatsTab: UIGameStatsTab!
    
    init(baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, resourcePath: String, resourceType: String, score: Int, jumps: Int, highScore: Int, newHighScore: Bool) {
        super.init(baseScene: baseScene, pos: pos, zPos: zPos, referenceName: referenceName, resourcePath: resourcePath, resourceType: resourceType)
        
        self.score = score
        self.jumps = jumps
        self.highScore = highScore
        self.newHighScore = newHighScore
    }
    
    override func addElement() {
        super.addElement()
        setButtonHandlers()
        updateValues()
        animate()
    }
    
    /* Set the button handlers for the GameOverMenu */
    override func setButtonHandlers() {
        let gameOverMenuGameStatsButton_1 = referenceNode.childNode(withName: "//gameOverMenuGameStatsButton_1") as! MSButtonNode
        let gameOverMenuReplayButton_1 = referenceNode.childNode(withName: "//gameOverMenuReplayButton_1") as! MSButtonNode
        
        /* Set the handler for the game stats tab button */
        gameOverMenuGameStatsButton_1.selectedHandler = {
            self.gameStatsTab = UIGameStatsTab(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 6, referenceName: "gameStatsTbReferenceNode", resourcePath: "GameStatsTab", resourceType: "sks")
            self.gameStatsTab.addElement()
        }
        
        /* Set the handler for the replay button */
        gameOverMenuReplayButton_1.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.baseScene.view as SKView!
            
            /* Load Game scene */
            let scene = InfiniteGameScene(fileNamed:"InfiniteGameScene") as InfiniteGameScene!
            
            /* Ensure correct aspect mode */
            scene!.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView!.presentScene(scene)
        }
    }
    
    /* Update values */
    func updateValues() {
        /* Get the references to the labels */
        let gameOverMenuScoreLabel_1 = referenceNode.childNode(withName: "//gameOverMenuScoreLabel_1") as! SKLabelNode
        let gameOverMenuJumpLabel_1 = referenceNode.childNode(withName: "//gameOverMenuJumpLabel_1") as! SKLabelNode
        let gameOverMenuHighScoreLabel_1 = referenceNode.childNode(withName: "//gameOverMenuHighScoreLabel_1") as! SKLabelNode
        
        gameOverMenuScoreLabel_1.text = String(score)
        gameOverMenuJumpLabel_1.text = String(jumps)
        gameOverMenuHighScoreLabel_1.text = String(highScore)
    }
    
    /* Animate the gameOverMenu */
    func animate() {
        /* Get the references to the labels */
        let gameOverMenuScoreLabel_1 = referenceNode.childNode(withName: "//gameOverMenuScoreLabel_1") as! SKLabelNode
        let gameOverMenuJumpLabel_1 = referenceNode.childNode(withName: "//gameOverMenuJumpLabel_1") as! SKLabelNode
        let gameOverMenuHighScoreLabel_1 = referenceNode.childNode(withName: "//gameOverMenuHighScoreLabel_1") as! SKLabelNode
        let gameOverMenuNewHighScoreLabel = referenceNode.childNode(withName: "//gameOverMenuNewHighScoreLabel") as! SKLabelNode
        
        /* Display the score label */
        let displayScore = SKAction.run {
            gameOverMenuScoreLabel_1.isHidden = false
        }
        
        /* Display the jump label */
        let displayJumps = SKAction.run {
            gameOverMenuJumpLabel_1.isHidden = false
        }
        
        /* Display the high score label */
        let displayHighScore = SKAction.run {
            gameOverMenuHighScoreLabel_1.isHidden = false
        }
        
        /* Display the new high score label */
        let displayNewHighScoreLabel = SKAction.run {
            if self.newHighScore {
                gameOverMenuNewHighScoreLabel.isHidden = false
            }
        }
        
        /* Wait for 0.5 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        
        /* Wait 0.5 seconds, display score, wait, display jumps, wait, display high score, wait, and then display */
        referenceNode.run(SKAction.sequence([wait, displayScore, wait, displayJumps, wait, displayHighScore, wait, displayNewHighScoreLabel]))
    }
}
