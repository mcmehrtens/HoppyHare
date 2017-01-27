//
//  EntityObstacleScrollLayer.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/27/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class EntityObstacleScrollLayer: EntityScrollLayer {
    /* Add the obstacle scroll layer to the base scene */
    override func addElement() {
        referenceNode = SKReferenceNode() // Creates a blank reference node
        
        referenceNode.name = referenceName // Set the name of the referenceNode
        
        baseScene.addChild(referenceNode) // Add the referenceNode to the baseScene
        
        referenceNode.position = pos // Set the position of the new node
        referenceNode.zPosition = CGFloat(zPos) // Set the zPosition of the new node
    }
    
    /* Add an obstacle */
    func addObstacle() {
        let obstacle = EntityObstacle(pos: CGPoint(x: (baseScene.size.width / 2) + (SKTexture(imageNamed: spriteName + "_top").size().width / 2), y: 0), zPos: 0, spriteName: spriteName)
        
        referenceNode.addChild(obstacle.referenceNode)
    }
    
    /* Scroll sprites */
    func scrollObstacles() {
        /* Loop through all the obstacles in the layer */
        for obstacle in referenceNode.children {
            /* If the node is off the screen, remove it */
            if obstacle.position.x <= (-(baseScene.size.width / 2) - SKTexture(imageNamed: spriteName + "_top").size().width / 2) {
                obstacle.removeFromParent()
            }
            
            /* Scroll through them */
            obstacle.position.x -= scrollSpeed * CGFloat(1.0/60.0)
        }
    }
}
