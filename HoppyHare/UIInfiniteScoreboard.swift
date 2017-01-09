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
        
        setScoreboardSide()
    }
    
    /* Update labels */
    func updateHighScoreLabel(highScore: Int) {
        highScoreLabel.text = String(highScore)
    }
    
    /* Sets the scoreboards side */
    func setScoreboardSide() {
        if GameStats.getStat(statName: GameStats.scoreboardSwitcher) == 0 {
            let score = referenceNode.childNode(withName: ".//score") as! SKLabelNode
            score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            score.position = CGPoint(x: -109, y: -44.5)
            
            let highScoreNode = referenceNode.childNode(withName: ".//highScoreNode")!
            highScoreNode.position = CGPoint(x: -109, y: -69)
            
            let highScoreLabel = referenceNode.childNode(withName: ".//highScoreLabel") as! SKLabelNode
            highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            highScoreLabel.position = CGPoint(x: 0, y: 0)
            
            let highScore = referenceNode.childNode(withName: ".//highScore") as! SKLabelNode
            highScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            highScore.position = CGPoint(x: 0, y: -10)
        } else {
            let score = referenceNode.childNode(withName: ".//score") as! SKLabelNode
            score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            score.position = CGPoint(x: 109, y: -44.5)
            
            let highScoreNode = referenceNode.childNode(withName: ".//highScoreNode")!
            highScoreNode.position = CGPoint(x: 109, y: -69)
            
            let highScoreLabel = referenceNode.childNode(withName: ".//highScoreLabel") as! SKLabelNode
            highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            highScoreLabel.position = CGPoint(x: 0, y: 0)
            
            let highScore = referenceNode.childNode(withName: ".//highScore") as! SKLabelNode
            highScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            highScore.position = CGPoint(x: 0, y: -10)
        }
    }
}
