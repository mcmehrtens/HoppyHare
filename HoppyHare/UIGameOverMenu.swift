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
    var score: Int
    var jumps: Int
    var brokeHighScore: Bool // Keeps track of whether the user broke a new high score or not
    
    var gameStatsTab: UIGameStatsTab! // Makes a reference to the GameStatsTab
    
    /* Initalizes the basic variables + the score, jumps, and the brokeHighScore variable */
    init(baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, resourcePath: String, resourceType: String, score: Int, jumps: Int, brokeHighScore: Bool) {
        self.score = score
        self.jumps = jumps
        self.brokeHighScore = brokeHighScore
        
        super.init(baseScene: baseScene, pos: pos, zPos: zPos, referenceName: referenceName, resourcePath: resourcePath, resourceType: resourceType)
    }
    
    /* Add the element to the screen, set the button handlers, update the values, then animate the menu */
    override func addElement() {
        super.addElement()
        setButtonHandlers()
        updateValues()
        animate()
    }
    
    /* Set the button handlers for the GameOverMenu */
    func setButtonHandlers() {
        let gameStatsButton = referenceNode.childNode(withName: "//gameStatsButton") as! MSButtonNode // gameStatsTabButton reference
        let replayButton = referenceNode.childNode(withName: "//replayButton") as! MSButtonNode // replayButton reference
        
        /* Set the handler for the game stats tab button */
        gameStatsButton.selectedHandler = {
            self.gameStatsTab = UIGameStatsTab(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 6, referenceName: "gameStatsTabReferenceNode", resourcePath: "UIGameStatsTab", resourceType: "sks") // Create a new gameStatsTab reference node
        }
        
        /* Set the handler for the replay button - This restarts the game */
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
    
    /* Update the score, jump, and high score values */
    func updateValues() {
        /* Get the references to the labels */
        let score = referenceNode.childNode(withName: ".//score") as! SKLabelNode
        let jumps = referenceNode.childNode(withName: ".//jumps") as! SKLabelNode
        let highScore = referenceNode.childNode(withName: ".//highScore") as! SKLabelNode
        
        score.text = String(self.score) // Set the score label
        jumps.text = String(self.jumps) // Set the jumps label
        highScore.text = String(GameStats.defaults.integer(forKey: GameStats.highScore)) // Set the high score label
    }
    
    /* Animate the gameOverMenu */
    func animate() {
        /* Get the references to the labels */
        let score = referenceNode.childNode(withName: ".//score") as! SKLabelNode
        let jumps = referenceNode.childNode(withName: ".//jumps") as! SKLabelNode
        let highScore = referenceNode.childNode(withName: ".//highScore") as! SKLabelNode
        let newHighScoreLabel = referenceNode.childNode(withName: ".//newHighScoreLabel") as! SKLabelNode
        
        /* Wait for 0.5 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        
        /* Animate the labels onto the gameOverMenu with a 0.5s delay in between each iteration 
         1. Wait 0.5s
         2. Display score
         3. Wait 0.5s
         4. Display jumps
         5. Wait 0.5s
         6. Display high score
         7. Wait 0.5s
         8. Optional(Display newHighScoreLabel)
         */
        referenceNode.run(SKAction.sequence([wait, SKAction.run { score.isHidden = false }, wait, SKAction.run { jumps.isHidden = false }, wait, SKAction.run { highScore.isHidden = false }, wait, SKAction.run { if self.brokeHighScore { newHighScoreLabel.isHidden = false } }]))
    }
}
