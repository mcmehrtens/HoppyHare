//
//  InfiniteGameSceneAnimations.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/1/17.
//  Copyright © 2017 Mattkx4. All rights reserved.
//
import SpriteKit
import GameplayKit

class InfiniteGameSceneAnimations: SKScene {
    
    /* This animation slides in the scoreboard once the player has tapped the screen */
    static func infScoreboardSlideIn(nodes: [SKNode]) {
        /* Slide the node up */
        let infScoreboardSlideUp = SKAction.move(by: CGVector(dx: 0.0, dy: 64.5), duration: 0.35)
        infScoreboardSlideUp.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the node down */
        let infScoreboardSlideDown = SKAction.move(by: CGVector(dx: 0.0, dy: -5), duration: 0.2)
        infScoreboardSlideDown.timingMode = SKActionTimingMode.easeInEaseOut
        
        /* This gives the items a +0.1 delayed start time each time the action is called */
        var startTime = 0.0
        
        /* Loop through all the objects from the parameters */
        for obj in nodes {
            /* Create an action to wait (this is the start time; starts at 0.0; each time is +0.1) */
            let wait = SKAction.wait(forDuration: startTime)
            
            /* Make the animation sequence (wait, slide the node up, slide the node down) */
            let infScoreboardSlideIn = SKAction.sequence([wait, infScoreboardSlideUp, infScoreboardSlideDown])
            
            /* Run the animation */
            obj.run(infScoreboardSlideIn)
            
            /* Increment the start time */
            startTime += 0.1
        }
    }
    
    /* This animation shakes the screen when the hero dies */
    static func shake(nodes: [SKNode]) {
        /* Shake #1 */
        let shakeOne = SKAction.move(by: CGVector(dx: 4, dy: 2), duration: 0.1)
        
        /* Shake #2 */
        let shakeTwo = SKAction.move(by: CGVector(dx: -8, dy: -4), duration: 0.1)
        
        /* Shake #3 */
        let shakeThree = SKAction.move(by: CGVector(dx: 4, dy: 2), duration: 0.1)
        
        /* This puts all the shakes one after another. NOTE: due to the math here, the screen should end up in the same original position.*/
        let shake = SKAction.sequence([shakeOne, shakeTwo, shakeThree])
        
        for obj in nodes {
            obj.run(shake)
        }
    }
    
    /* This animation slides the title onto the screen horizontally. The parameters: nodes.0 is the first title label. nodes.1 is the second title label. This will have be adjusted later when I get a proper textured title (maybe)*/
    static func titleSlideIn(nodes: (SKNode, SKNode)) {
        /* Slides the first title label in */
        let labelOneSlideIn = SKAction.move(by: CGVector(dx: 235, dy: 0), duration: 0.75)
        labelOneSlideIn.timingMode = SKActionTimingMode.easeOut
        
        /* Slides the second title label in */
        let labelTwoSlideIn = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 0.75)
        labelTwoSlideIn.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the labels on */
        nodes.0.run(labelOneSlideIn)
        nodes.1.run(labelTwoSlideIn)
    }
    
    /* This animation slides the title off the screen in the same direction they slid on. The parameters: nodes.0 = first title label. noddes.1 = second title label */
    static func titleSlideOff(nodes: (SKNode, SKNode)) {
        /* Slides the first title label off in the same direction. The x value is the distance to travel until the anchor point is off the screen + the width of the label */
        let labelOneSlideOff = SKAction.move(by: CGVector(dx: CGFloat(85) + (nodes.0.frame.width), dy: 0), duration: 0.75)
        labelOneSlideOff.timingMode = SKActionTimingMode.easeIn
        
        /* Slides the second title label off in the same direction. The x value is the distance to travel until the anchor point is off the screen - the width of the label */
        let labelTwoSlideOff = SKAction.move(by: CGVector(dx: (CGFloat(-120) - (nodes.1.frame.width)), dy: 0), duration: 0.75)
        labelTwoSlideOff.timingMode = SKActionTimingMode.easeIn
        
        /* Slide the labels off */
        nodes.0.run(labelOneSlideOff)
        nodes.1.run(labelTwoSlideOff)
    }
    
    /* This animation slides the loading label off the screen. */
    static func loadingLabelSlideOff(node: SKNode) {
        /* Slides the label up... */
        let loadingLabelSlideUp = SKAction.move(by: CGVector(dx: 0, dy: 15), duration: 0.2)
        loadingLabelSlideUp.timingMode = SKActionTimingMode.easeOut
        
        /* ...and off... */
        let loadingLabelSlideDown = SKAction.move(by: CGVector(dx: 0, dy: -40 - (node.frame.height)), duration: 0.3)
        loadingLabelSlideDown.timingMode = SKActionTimingMode.easeInEaseOut
        
        /* ... put it all together... */
        let loadingLabelSlideOff = SKAction.sequence([loadingLabelSlideUp, loadingLabelSlideDown])
        
        /* ...and slide 'er up and off babyyyyyyy! */
        node.run(loadingLabelSlideOff)
    }
}

/* DEPRECATED CODE */

/* This code block animated the title off the screen in the opposite direction that they came on */

//    /* This animation slides the title off the screen. The parameters: nodes.0 = first title label. noddes.1 = second title label */
//    static func titleSlideOff(nodes: (SKNode, SKNode)) {
//        /* Slides the first title label off */
//        let labelOneSlideOff = SKAction.move(by: CGVector(dx: -235, dy: 0), duration: 0.5)
//        labelOneSlideOff.timingMode = SKActionTimingMode.easeIn
//
//        /* Slides the second title label off*/
//        let labelTwoSlideOff = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 0.5)
//        labelTwoSlideOff.timingMode = SKActionTimingMode.easeIn
//
//        nodes.0.run(labelOneSlideOff)
//        nodes.1.run(labelTwoSlideOff)
//    }
