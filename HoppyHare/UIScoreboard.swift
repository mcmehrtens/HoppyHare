//
//  UIScoreboard.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/7/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class UIScoreboard: UIElement {
    var scoreLabelName: String!
    var scoreLabel: SKLabelNode!
    
    init(baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, resourcePath: String, resourceType: String, scoreLabelName: String) {
        self.scoreLabelName = scoreLabelName
        
        super.init(baseScene: baseScene, pos: pos, zPos: zPos, referenceName: referenceName, resourcePath: resourcePath, resourceType: resourceType)
    }
    
    override func addElement() {
        super.addElement()
        
        scoreLabel = referenceNode.childNode(withName: "//" + scoreLabelName) as! SKLabelNode
    }
    
    func increaseScore(score: Int) {
        scoreLabel.text = String(score)
    }
    
    /* Slide the scoreboard on to the screen */
    func onSlide() {
        /* Slide the node up */
        let slideUp = SKAction.move(by: CGVector(dx: 0.0, dy: 64.5), duration: 0.35)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(by: CGVector(dx: 0.0, dy: -5), duration: 0.2)
        slideDown.timingMode = SKActionTimingMode.easeInEaseOut
        
        /* This gives the items a +0.1 delayed start time each time the action is called */
        var startTime = 0.0
        
        /* Loop through all the objects from the parameters */
        for obj in (referenceNode.childNode(withName: "SKNode")!.children) {
            /* Create an action to wait (this is the start time; starts at 0.0; each time is +0.1) */
            let wait = SKAction.wait(forDuration: startTime)
            
            /* Make the animation sequence (wait, slide the node up, slide the node down) */
            let slideIn = SKAction.sequence([wait, slideUp, slideDown])
            
            /* Run the animation */
            obj.run(slideIn)
            
            /* Increment the start time */
            startTime += 0.1
        }
    }
    
    /* Slide the startMenu off the screen */
    func offSlide() {
        /* Slide the node up */
        let slideUp = SKAction.move(by: CGVector(dx: 0.0, dy: 5), duration: 0.2)
        slideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let slideDown = SKAction.move(by: CGVector(dx: 0.0, dy: -64.5), duration: 0.35)
        slideDown.timingMode = SKActionTimingMode.easeIn
        
        /* This gives the items a +0.1 delayed start time each time the action is called */
        var startTime = 0.0
        
        /* Loop through all the objects from the parameters */
        for obj in (referenceNode.childNode(withName: "SKNode")!.children).reversed() {
            /* Create an action to wait (this is the start time; starts at 0.0; each time is +0.1) */
            let wait = SKAction.wait(forDuration: startTime)
            
            /* Make the animation sequence (wait, slide the node up, slide the node down) */
            let slideIn = SKAction.sequence([wait, slideUp, slideDown, SKAction.run { self.removeElement() }])
            
            /* Run the animation */
            obj.run(slideIn)
            
            /* Increment the start time */
            startTime += 0.1
        }
    }
}
