//
//  EntityGround.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/23/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class EntityGround {
    var ground = SKSpriteNode() // invisible ground sprite
    
    /* Initializes all the variables */
    init(baseScene: SKScene, pos: CGPoint, size: CGSize) {
        /* Set some basic variables */
        ground.position = pos
        ground.size = size
        ground.zPosition = 3
        
        /* Create a phyisics body that the bunny can go through, but the game is notified when contact is made. */
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground.size.width, height: ground.size.height))
        physicsBody.isDynamic = false
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.friction = 0
        physicsBody.restitution = 0
        physicsBody.categoryBitMask = 4
        physicsBody.contactTestBitMask = 1
        
        ground.physicsBody = physicsBody // Assign our physics body to our invisible ground
        
        baseScene.addChild(ground) // Add the ground onto the screen
    }
}
