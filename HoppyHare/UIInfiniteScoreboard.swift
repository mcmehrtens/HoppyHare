//
//  UIInfiniteScoreboard.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIInfiniteScoreboard: UIScoreboard {
    var highScoreNode: SKNode!
    var highScoreLabel: SKLabelNode!
    var highScore: SKLabelNode!
    
    /* Add the element to the screen */
    override func addElement() {
        super.addElement()
        highScoreNode = referenceNode.childNode(withName: "//highScoreNode")!
        highScoreLabel = referenceNode.childNode(withName: "//highScoreLabel") as! SKLabelNode
        highScore = referenceNode.childNode(withName: "//highScore") as! SKLabelNode
        
        updateHighScoreLabel()
        
        setScoreboardSide()
        
        referenceNode.run(SKAction.sequence([SKAction.run { self.slideScoreOn() }, SKAction.wait(forDuration: TimeInterval(0.1)), SKAction.run { self.slideHighScoreOn() }]))
    }
    
    /* Update labels */
    func updateHighScoreLabel() {
        self.highScore.text = String(GameStats.defaults.integer(forKey: GameStats.highScore))
    }
    
    /* Sets the scoreboards side */
    func setScoreboardSide() {
        if GameStats.defaults.bool(forKey: GameStats.scoreboardSwitcher) {
            score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            score.position = CGPoint(x: 125, y: -44.5)
            
            highScoreNode.position = CGPoint(x: 125, y: -69)
            
            highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            highScoreLabel.position = CGPoint(x: 0, y: 0)
            
            highScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            highScore.position = CGPoint(x: 0, y: -10)
        }
    }
    
    /* Slide the scoreboard on to the screen */
    func slideHighScoreOn() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -4.5), duration: 0.35)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -9.5), duration: 0.2)
        slideDown.timingMode = SKActionTimingMode.easeInEaseOut
        
        highScoreNode.run(SKAction.sequence([slideUp, slideDown]))
    }
    
    /* Slide the startMenu off the screen */
    func slideHighScoreOff() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -4.5), duration: 0.2)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: highScoreNode.position.x, y: -69), duration: 0.35)
        slideDown.timingMode = SKActionTimingMode.easeIn
        
        highScoreNode.run(SKAction.sequence([slideUp, slideDown]))
    }
    
    override func removeElement() {
        referenceNode.run(SKAction.sequence([SKAction.run { self.slideHighScoreOff() }, SKAction.wait(forDuration: TimeInterval(0.1)), SKAction.run { self.slideScoreOff() }, SKAction.wait(forDuration: TimeInterval(0.55)), SKAction.run { super.removeElement() }]))
    }
}
