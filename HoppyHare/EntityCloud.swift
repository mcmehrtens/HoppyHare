//
//  EntityCloud.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/14/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class EntityCloud: UIElement {
    override func addElement() {
        super.addElement()
        slideIn()
    }
    
    /* Slide Mr. Cloud on :) */
    func slideIn() {
        let slideIn = SKAction.move(to: CGPoint(x: -88, y: 0), duration: TimeInterval(1))
        slideIn.timingMode = SKActionTimingMode.easeOut
        
        referenceNode.run(slideIn)
    }
    
    /* Slide Mr. Cloud away :( */
    func slideOff() {
        referenceNode.run(SKAction.sequence([SKAction.move(to: CGPoint(x: -(baseScene.size.width / 2) - ((referenceNode.childNode(withName: ".//cloud") as! SKSpriteNode).size.width / 2), y: referenceNode.position.y), duration: TimeInterval(0.35)), SKAction.wait(forDuration: TimeInterval(0.35)), SKAction.run { self.removeElement() }]))
    }
}
