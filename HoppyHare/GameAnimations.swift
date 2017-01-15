//
//  InfiniteGameSceneAnimations.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/1/17.
//  Copyright © 2017 Mattkx4. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameAnimations: SKScene {
    /* This animation slides the title onto the screen horizontally. The parameters: nodes.0 is the first title label. nodes.1 is the second title label. This will have be adjusted later when I get a proper textured title (maybe)*/
    static func titleSlideIn(nodes: (SKNode, SKNode)) {
        /* Slides the first title label in */
        let labelOneSlideIn = SKAction.move(by: CGVector(dx: 235, dy: 0), duration: 0.5)
        labelOneSlideIn.timingMode = SKActionTimingMode.easeOut
        
        /* Slides the second title label in */
        let labelTwoSlideIn = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 0.5)
        labelTwoSlideIn.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the labels on */
        nodes.0.run(labelOneSlideIn)
        nodes.1.run(labelTwoSlideIn)
    }
    
    /* This animation slides the title off the screen in the same direction they slid on. The parameters: nodes.0 = first title label. noddes.1 = second title label */
    static func titleSlideOff(nodes: (SKNode, SKNode)) {
        /* Slides the first title label off in the same direction. The x value is the distance to travel until the anchor point is off the screen + the width of the label */
        let labelOneSlideOff = SKAction.move(by: CGVector(dx: CGFloat(85) + (nodes.0.frame.width), dy: 0), duration: 0.5)
        labelOneSlideOff.timingMode = SKActionTimingMode.easeIn
        
        /* Slides the second title label off in the same direction. The x value is the distance to travel until the anchor point is off the screen - the width of the label */
        let labelTwoSlideOff = SKAction.move(by: CGVector(dx: (CGFloat(-120) - (nodes.1.frame.width)), dy: 0), duration: 0.5)
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
        let loadingLabelSlideOff = SKAction.sequence([loadingLabelSlideUp, loadingLabelSlideDown, SKAction.run { node.removeFromParent() }])
        
        /* ...and slide 'er up and off babyyyyyyy! */
        node.run(loadingLabelSlideOff)
    }
    
    /* This animation slides on the inGameDifficulty Label */
    static func inGameDifficultyLabelSlideIn(node: SKNode) {
        /* Slide the label down */
        let inGameDifficultyLabelSlideDown = SKAction.move(by: CGVector(dx: 0, dy: -25), duration: 0.5)
        inGameDifficultyLabelSlideDown.timingMode = SKActionTimingMode.easeOut
        
        /* Slide that sucker */
        node.run(inGameDifficultyLabelSlideDown)
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
