//
//  UIInfiniteScoreboard.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIInfiniteScoreboard: UIScoreboard {
    var highScoreLabelName: String!
    var highScoreLabel: SKLabelNode!
    
    init(baseScene: SKScene, pos: CGPoint, zPos: Int, referenceName: String, resourcePath: String, resourceType: String, scoreLabelName: String, highScoreLabelName: String) {
        self.highScoreLabelName = highScoreLabelName
        
        super.init(baseScene: baseScene, pos: pos, zPos: zPos, referenceName: referenceName, resourcePath: resourcePath, resourceType: resourceType, scoreLabelName: scoreLabelName)
    }
    
    /* Add the element to the screen */
    override func addElement() {
        super.addElement()
        highScoreLabel = referenceNode.childNode(withName: "//" + highScoreLabelName) as! SKLabelNode
        
        updateHighScoreLabel(highScore: GameStats.getStat(statName: GameStats.highScore))
    }
    
    /* Update labels */
    func updateHighScoreLabel(highScore: Int) {
        highScoreLabel.text = String(highScore)
    }
}
