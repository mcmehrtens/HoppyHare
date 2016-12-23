//
//  GameStats.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 12/22/16.
//  Copyright © 2016 Mattkx4. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameStats: SKScene {
    /* Buttons */
    var buttonBack: MSButtonNode!
    
    /* Array that contains all the text nodes */
    var textObjects: [SKNode] = []
    
    /* Set up the scene here */
    override func didMove(to view: SKView) {
        /* Set back button connection */
        buttonBack = self.childNode(withName: "backButton") as! MSButtonNode
        
        /* Setup back button selection handler */
        buttonBack.selectedHandler = { [unowned self] in
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = InfiniteGameScene(fileNamed:"InfiniteGameScene") as InfiniteGameScene!
            
            /* Ensure correct aspect mode */
            scene!.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView!.presentScene(scene)
        }
        
        /* Set the label references */
        textObjects = [self.childNode(withName: "allTimeHighScoreNode")!]
        textObjects.append(self.childNode(withName: "allTimeJumpsNode")!)
        textObjects.append(self.childNode(withName: "allTimeScoreNode")!)
        textObjects.append(self.childNode(withName: "totalTimePlayedNode")!)
        textObjects.append(self.childNode(withName: "totalGamesPlayedNode")!)
        textObjects.append(self.childNode(withName: "numOfCostumesDiscoveredNode")!)
        textObjects.append(self.childNode(withName: "favCostumeNode")!)
        textObjects.append(self.childNode(withName: "numOfTimesScorePrec1Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc25Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc50Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc100Node")!)
        textObjects.append(self.childNode(withName: "numOfTimesScoreExc250Node")!)
        
        slideOnText()
    }
    
    /* Slide on all the text */
    func slideOnText() {
    }
}
