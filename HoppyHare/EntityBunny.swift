//
//  Hero.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/10/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class EntityBunny: UIElement {
    var bunny: SKSpriteNode! // This is the bunny sprite. Use this to manipulate the bunny
    
    /* Adds the bunny onto the screen */
    override func addElement() {
        super.addElement()
        bunny = referenceNode.childNode(withName: ".//bunny") as! SKSpriteNode // Assigns the bunny sprite node to the bunny instance
        bunny.position = CGPoint(x: -200, y: 15) // Set the position of the bunny within the referenceNode
        bunny.physicsBody!.affectedByGravity = false // Set the bunny to be gravity immune
        slideIn() // Slide the bunny in atop a cloud of justice
    }
    
    /* Propels the bunny into the air. */
    func jump() {
        /* If the bunny is not affected by gravity, set it equal to true */
        if !(bunny.physicsBody!.affectedByGravity) {
            bunny.physicsBody!.affectedByGravity = true
        }
        
        /* Reset velocity, helps improve response against cumulative falling velocity */
        bunny.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        /* Apply vertical impulse */
        bunny.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 180))
        
        /* Play SFX */
        Sounds.playSound(soundName: "jump", object: self.baseScene)
        
        /* Apply subtle rotation */
        bunny.physicsBody!.applyAngularImpulse(CGFloat(0.1))
    }
    
    /* Rotate the hero after a jump. */
    func rotateBunny(sinceTouch: TimeInterval) {
        /* Apply falling rotation */
        if sinceTouch > 0.29 { // Make this number smaller to start the falling rotation sooner
            bunny.physicsBody!.applyAngularImpulse(CGFloat(-20000 * TimeInterval(1.0/60.0))) // Apply the impulse
        }
        
        /* Clamp rotation */
        bunny.zRotation = bunny.zRotation.clamped(CGFloat(-10).degreesToRadians(), CGFloat(15).degreesToRadians()) // Negative number is the most it is allowed to turn downwards. Positive number is the max rotation upwards.
        bunny.physicsBody!.angularVelocity = bunny.physicsBody!.angularVelocity.clamped(-1, 1) // This clamp makes it so that the rotating velocity never gets to high or low. Adjust these numbers to make the rotation happen faster/slower.
    }
    
    /* Cap the bunny's vertical velocity to ensure the bunny doesn't fall or rise too quickly. */
    func capBunnyVelocityY() {
        /* Check and cap vertical velocity */
        if bunny.physicsBody!.velocity.dy > 350 {
            bunny.physicsBody!.velocity.dy = 350
        }
    }
    
    /* Caps the bunny's y-coord to make sure you can't go above the screen. */
    func capBunnyY() {
        if bunny.position.y >= (baseScene.size.height / 2) - (bunny.size.height * (3/4)) {
            bunny.physicsBody!.velocity.dy = 0
        }
    }
    
    /* Runs the animation to kill the bunny */
    func killBunny() {
        /* Stop any new angular velocity being applied */
        bunny.physicsBody!.allowsRotation = false
        
        /* Reset angular velocity */
        bunny.physicsBody!.angularVelocity = 0
        
        /* Stop hero flapping animation */
        bunny.removeAllActions()
        
        /* Create our hero death sequence. After setting the bunny's zRotation and collisionBitMask, we wait 2 seconds then delete the node. */
        bunny.run(SKAction.sequence([SKAction.run {
            /* Put our hero face down in the dirt */
            self.bunny.zRotation = CGFloat(-90).degreesToRadians()
            
            /* Stop hero from colliding with anything else */
            self.bunny.physicsBody!.collisionBitMask = 0
            }, SKAction.wait(forDuration: TimeInterval(2.0)), SKAction.run { self.removeElement() }]))
    }
    
    /* Slide the bunny in on top of the cloud */
    func slideIn() {
        /* Slide the bunny into it's starting place with the easeOut timingMode over the course of 1 second. */
        let slideIn = SKAction.move(to: CGPoint(x: -88, y: 15), duration: TimeInterval(1))
        slideIn.timingMode = SKActionTimingMode.easeOut
        
        bunny.run(slideIn)
    }
}
