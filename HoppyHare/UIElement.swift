//
//  UIController.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIElement {
    var baseScene: SKScene // This is the scene where the element will be added
    var referenceNode: SKReferenceNode! // This is the node being added
    var pos: CGPoint // Position of the reference node
    var zPos: Int // zPosition of the reference node
    var referenceName: String // Name of the reference node
    var resourcePath: String // Name of the resource file
    var resourceType: String // Type of resource file
    
    /* Pretty basic initalization. At the end of every initialization we call the addElement func. */
    init (baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, resourcePath: String, resourceType: String) {
        self.baseScene = baseScene
        self.pos = pos
        self.zPos = zPos
        self.resourcePath = resourcePath
        self.resourceType = resourceType
        self.referenceName = referenceName
        
        addElement()
    }
    
    /* Adds the reference node to the base scene */
    func addElement() {
        referenceNode = SKReferenceNode(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: resourcePath, ofType: resourceType)!) as URL) // Make a new referenceNode with the appropriate path
        
        referenceNode.name = referenceName // Set the name of the referenceNode
        
        baseScene.addChild(referenceNode) // Add the referenceNode to the baseScene
        
        referenceNode.position = pos // Set the position of the new node
        referenceNode.zPosition = CGFloat(zPos) // Set the zPosition of the new node
    }
    
    /* Removes the reference node from the base scene*/
    func removeElement() {
        if let node = referenceNode {
            node.removeFromParent() // Remove the node from the baseScene
            referenceNode = nil // Set the referenceNode to nil to prevent further manipulation of a ghost node
        }
    }
}
