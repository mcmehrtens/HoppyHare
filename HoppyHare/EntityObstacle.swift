//
//  EntityObstacle.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/27/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class EntityObstacle {
    var referenceNode: SKReferenceNode! // This is the node being added
    var pos: CGPoint // Position of the reference node
    var zPos: Int // zPosition of the reference node
    var spriteName: String // Gets the name of the obstacle sprite
    
    /* Basic initialization */
    init (pos: CGPoint, zPos: Int, spriteName: String) {
        self.pos = pos
        self.zPos = zPos
        self.spriteName = spriteName
        
        addElement()
    }
    
    /* Add the obstacle layer onto the screen */
    func addElement() {
        /* Create the reference node */
        referenceNode = SKReferenceNode()
        
        referenceNode.position = pos
        referenceNode.zPosition = CGFloat(zPos)
        
        /* Create the goal */
        let goal = SKSpriteNode(color: UIColor(red: CGFloat(0.0), green: CGFloat(0.0), blue: CGFloat(0.0), alpha: CGFloat(0.0)), size: CGSize(width: CGFloat(1.0), height: GameDifficulty.goalHeight))
        goal.name = "goal"
        
        // Set up the physics body for the goal
        let goalPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: goal.size.width, height: goal.size.height))
        goalPhysicsBody.isDynamic = false
        goalPhysicsBody.allowsRotation = false
        goalPhysicsBody.affectedByGravity = false
        goalPhysicsBody.categoryBitMask = 8
        goalPhysicsBody.collisionBitMask = 1
        goalPhysicsBody.contactTestBitMask = 1
        
        /* Add the goal into the scene*/
        goal.physicsBody = goalPhysicsBody
        referenceNode.addChild(goal)
        
        /* Create the top obstacle */
        let topObstacle = SKSpriteNode(imageNamed: spriteName + "_top")
        topObstacle.size = SKTexture(imageNamed: spriteName + "_top").size()
        
        // Set up the physics body for the top obstacle
        let topObstaclePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: topObstacle.size.width, height: topObstacle.size.height))
        topObstaclePhysicsBody.isDynamic = false
        topObstaclePhysicsBody.allowsRotation = false
        topObstaclePhysicsBody.affectedByGravity = false
        topObstaclePhysicsBody.categoryBitMask = 2
        topObstaclePhysicsBody.contactTestBitMask = 1
        
        /* Add the top obstacle into the scene */
        topObstacle.physicsBody = topObstaclePhysicsBody
        referenceNode.addChild(topObstacle)
        
        /* Create the bottom obstacle */
        let bottomObstacle = SKSpriteNode(imageNamed: spriteName + "_bottom")
        bottomObstacle.size = SKTexture(imageNamed: spriteName + "_bottom").size()
        
        // Set up the physics body for the bottom obstacle
        let bottomObstaclePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bottomObstacle.size.width, height: bottomObstacle.size.height))
        bottomObstaclePhysicsBody.isDynamic = false
        bottomObstaclePhysicsBody.allowsRotation = false
        bottomObstaclePhysicsBody.affectedByGravity = false
        bottomObstaclePhysicsBody.categoryBitMask = 2
        bottomObstaclePhysicsBody.contactTestBitMask = 1
        
        /* Add the bottom obstacle into the scene */
        bottomObstacle.physicsBody = bottomObstaclePhysicsBody
        referenceNode.addChild(bottomObstacle)
        
        /* Organize all the parts of the obstacle node */
        goal.position = CGPoint(x: SKTexture(imageNamed: spriteName + "_top").size().width / 2, y: 0)
        topObstacle.position = CGPoint(x: 0, y: (goal.size.height / 2) + (topObstacle.size.height / 2))
        bottomObstacle.position = CGPoint(x: 0, y: -(goal.size.height / 2) - (bottomObstacle.size.height / 2))
        
        /* Make a random position for the obstacle node */
        referenceNode.position.y = CGFloat.random(min: GameDifficulty.minHeight, max: GameDifficulty.maxHeight)
    }
}
