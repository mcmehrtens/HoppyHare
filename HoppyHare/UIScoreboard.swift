//
//  UIScoreboard.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/7/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class UIScoreboard: UIElement {
    var score: SKLabelNode!
    
    override func addElement() {
        super.addElement()
        
        score = referenceNode.childNode(withName: "//score") as! SKLabelNode
    }
    
    func increaseScore(score: Int) {
        self.score.text = String(score)
    }
    
    /* Slide the scoreboard on to the screen */
    func slideScoreOn() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: score.position.x, y: 20), duration: 0.35)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: score.position.x, y: 15), duration: 0.2)
        slideDown.timingMode = SKActionTimingMode.easeInEaseOut
        
        score.run(SKAction.sequence([slideUp, slideDown]))
    }
    
    /* Slide the startMenu off the screen */
    func slideScoreOff() {
        /* Slide the node up */
        let slideUp = SKAction.move(to: CGPoint(x: score.position.x, y: 20), duration: 0.2)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(to: CGPoint(x: score.position.x, y: -44.5), duration: 0.35)
        slideDown.timingMode = SKActionTimingMode.easeIn
        
        score.run(SKAction.sequence([slideUp, slideDown]))
    }
}
