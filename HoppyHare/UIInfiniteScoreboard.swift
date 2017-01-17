//
//  UIInfiniteScoreboard.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIInfiniteScoreboard: UIElement {
    var score: SKLabelNode! // Score label
    var highScoreNode: SKNode! // High score node
    var highScoreLabel: SKLabelNode! // High score label
    var highScore: SKLabelNode! // High score number label
    
    /* Add the element to the screen */
    override func addElement() {
        super.addElement()
        score = referenceNode.childNode(withName: ".//score") as! SKLabelNode // Set reference to the score label
        highScoreNode = referenceNode.childNode(withName: ".//highScoreNode")! // Set reference to the high score node
        highScoreLabel = referenceNode.childNode(withName: ".//highScoreLabel") as! SKLabelNode // Set reference to the high score label
        highScore = referenceNode.childNode(withName: ".//highScore") as! SKLabelNode // Set reference to the high score number label
        
        setHighScore() // Set the high score number label
        
        setScoreboardSide() // Set the side that the scoreboard is on
        
        /* Animate the score/highscore onto the screen:
         1. Slide the score on (0.55s)
         2. Wait 0.1 Seconds
         3. Slide the high score node on (0.55s)
         */
        referenceNode.run(SKAction.sequence([SKAction.run { self.slideScoreOn() }, SKAction.wait(forDuration: TimeInterval(0.1)), SKAction.run { self.slideHighScoreOn() }]))
    }
    
    /* Set the score to the desired integer */
    func setScore(score: Int) {
        self.score.text = String(score)
        
        /* If the score is higher than the previous high score:
         1. Set the highScoreLabel to be gold
         2. Set the highScoreNumber to be gold
         3. Update the highScoreNumber to the new score
         */
        if score > GameStats.defaults.integer(forKey: GameStats.highScore) {
            highScoreLabel.fontColor = CustomColors.colorGold
            highScore.fontColor = CustomColors.colorGold
            
            highScore.text = String(score)
        }
    }
    
    /* Set the high score to the stored high score variable */
    func setHighScore() {
        self.highScore.text = String(GameStats.defaults.integer(forKey: GameStats.highScore))
    }
    
    /* Set the side that the scoreboard is on (based off the ScoreboardSwitcher default) */
    func setScoreboardSide() {
        /* All these variables are the opposite of what they are in the UIInfiniteScoreboard.sks */
        if GameStats.defaults.bool(forKey: GameStats.scoreboardSide) {
            score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            score.position = CGPoint(x: 125, y: -44.5)
            
            highScoreNode.position = CGPoint(x: 125, y: -69)
            
            highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            highScoreLabel.position = CGPoint(x: 0, y: 0)
            
            highScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            highScore.position = CGPoint(x: 0, y: -10)
        }
    }
    
    /* Slide the score onto the screen */
    func slideScoreOn() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: score.position.x, y: 20), duration: 0.35)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: score.position.x, y: 15), duration: 0.2)
        slideDown.timingMode = SKActionTimingMode.easeInEaseOut
        
        score.run(SKAction.sequence([slideUp, slideDown]))
    }
    
    /* Slide the score off the screen */
    func slideScoreOff() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: score.position.x, y: 20), duration: 0.2)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: score.position.x, y: -44.5), duration: 0.35)
        slideDown.timingMode = SKActionTimingMode.easeIn
        
        score.run(SKAction.sequence([slideUp, slideDown]))
    }
    
    /* Slide the high score node onto the screen */
    func slideHighScoreOn() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -4.5), duration: 0.35)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -9.5), duration: 0.2)
        slideDown.timingMode = SKActionTimingMode.easeInEaseOut
        
        highScoreNode.run(SKAction.sequence([slideUp, slideDown]))
    }
    
    /* Slide the high score node off the screen */
    func slideHighScoreOff() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -4.5), duration: 0.2)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -69), duration: 0.35)
        slideDown.timingMode = SKActionTimingMode.easeIn
        
        highScoreNode.run(SKAction.sequence([slideUp, slideDown]))
    }
    
    /* Remove the InfiniteScoreboard (first animate it, then remove) */
    override func removeElement() {
        /* Animate the scoreboard off the screen:
         1. Slide the high score node off (0.55s)
         2. Wait 0.1 seconds
         3. Slide the score off (0.55s)
         4. Wait 0.55 seconds
         5. Remove the element
         */
        referenceNode.run(SKAction.sequence([SKAction.run { self.slideHighScoreOff() }, SKAction.wait(forDuration: TimeInterval(0.1)), SKAction.run { self.slideScoreOff() }, SKAction.wait(forDuration: TimeInterval(0.55)), SKAction.run { super.removeElement() }]))
    }
}
