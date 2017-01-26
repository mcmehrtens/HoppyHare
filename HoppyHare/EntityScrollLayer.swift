//
//  EntityScrollLayer.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/21/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class EntityScrollLayer {
    var baseScene: SKScene // This is the scene where the element will be added
    var referenceNode: SKReferenceNode! // This is the node being added
    var pos: CGPoint // Position of the reference node
    var zPos: Int // zPosition of the reference node
    var referenceName: String // Name of the reference node
    var scrollSpeed: CGFloat // Determines how fast you should scroll the layer
    var spriteName: String // Gets the name of the sprite to be scrolled
    var sprites = (SKSpriteNode(), SKSpriteNode()) // Tuple that holds the sprite nodes in this obstacle layer
    
    /* Initializes all the variables */
    init(baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, scrollSpeed: CGFloat, spriteName: String) {
        self.baseScene = baseScene
        self.pos = pos
        self.zPos = zPos
        self.referenceName = referenceName
        self.scrollSpeed = scrollSpeed
        self.spriteName = spriteName
        
        addElement()
    }
    
    /* Creates a new, EMPTY reference node and populates it with two sprites */
    func addElement() {
        referenceNode = SKReferenceNode() // Creates a blank reference node
        
        referenceNode.name = referenceName // Set the name of the referenceNode
        
        baseScene.addChild(referenceNode) // Add the referenceNode to the baseScene
        
        referenceNode.position = pos // Set the position of the new node
        referenceNode.zPosition = CGFloat(zPos) // Set the zPosition of the new node
        
        /* 
         Now we populate the reference node with two new sprites :)
         */
        
        sprites.0.texture = SKTexture(imageNamed: spriteName) // Set the texture
        sprites.1.texture = SKTexture(imageNamed: spriteName)
        
        sprites.0.size = sprites.0.texture!.size() // Set the size
        sprites.1.size = sprites.1.texture!.size()
        
        sprites.0.anchorPoint = CGPoint(x: 0, y: 1) // Set the anchor point to the top-left corner
        sprites.1.anchorPoint = CGPoint(x: 0, y: 1)
        
        sprites.0.position = CGPoint(x: 0, y: 0) // Set this nodes position to reference node
        sprites.1.position = CGPoint(x: sprites.0.size.width, y: 0) // Set this nodes position to be at the right side of the first node
        
        referenceNode.addChild(sprites.0) // Add the nodes to the baseScene
        referenceNode.addChild(sprites.1)
    }
    
    /* This function scrolls the sprite nodes */
    func scrollSprites() {
        /* Scroll the sprites */
        sprites.0.position.x -= scrollSpeed * CGFloat(TimeInterval(1.0/60.0))
        sprites.1.position.x -= scrollSpeed * CGFloat(TimeInterval(1.0/60.0))
        
        updateSprites() // Check if the sprites have left the screen
    }
    
    /* Updates the position of the sprites in the scroll layer if they're past the referenceNode point */
    func updateSprites() {
        /* If the sprite has passed the reference node, set its new position to be on the right side of the other sprite */
        if sprites.0.position.x <= -sprites.0.size.width {
            sprites.0.position.x = sprites.1.position.x + sprites.1.size.width
        } else if sprites.1.position.x <= -sprites.1.size.width {
            sprites.1.position.x = sprites.0.position.x + sprites.0.size.width
        }
    }
}
