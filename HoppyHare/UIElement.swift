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
    var baseScene: SKScene
    var referenceNode: SKReferenceNode!
    var pos: CGPoint
    var zPos: Int
    var referenceName: String
    var resourcePath: String
    var resourceType: String
    
    init (baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, resourcePath: String, resourceType: String) {
        self.baseScene = baseScene
        self.pos = pos
        self.zPos = zPos
        self.resourcePath = resourcePath
        self.resourceType = resourceType
        self.referenceName = referenceName
        
        addElement()
    }
    
    func addElement() {
        let resourcePath = Bundle.main.path(forResource: self.resourcePath, ofType: resourceType)
        let genReferenceNode = SKReferenceNode(url: NSURL(fileURLWithPath: resourcePath!) as URL)
        
        genReferenceNode.name = referenceName
        
        referenceNode = genReferenceNode
        
        baseScene.addChild(referenceNode)
        
        referenceNode.position = pos
        referenceNode.zPosition = CGFloat(zPos)
    }
    
    func removeElement() {
        if referenceNode.parent != nil {
            referenceNode.removeFromParent()
        }
    }
    
    func getReferenceNode() -> SKReferenceNode {
        print(baseScene.children)
        print("//\(referenceNode.name)")
        return baseScene.childNode(withName: "//\(referenceNode.name!)") as! SKReferenceNode
    }
}
