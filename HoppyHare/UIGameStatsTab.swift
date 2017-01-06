//
//  UIGameStatsTab.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIGameStatsTab: UIElement {
    var nodes: [SKNode] = []
    var labels: [SKLabelNode] = []
    
    /* Adds the Game Stats Tab */
    override func addElement() {
        super.addElement()
        setButtonHandlers()
        populateNodes()
        populateLabels()
        updateLabels()
        animate()
    }
    
    /* Populates the node array */
    func populateNodes() {
        nodes = [referenceNode.childNode(withName: "//gameStatsTabAllTimeHighScoreNode")!]
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabAllTimeScoreNode")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabAllTimeJumpsNode")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabMostJumpsInOneGameNode")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabTotalGamesPlayedNode")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfCostumesDiscoveredNode")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabFavCostumeNode")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScorePrec1Node")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc25Node")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc50Node")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc100Node")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc250Node")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc500Node")!)
        nodes.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc1000Node")!)
    }
    
    /* Populates the label arrary */
    func populateLabels() {
        labels = [referenceNode.childNode(withName: "//gameStatsTabAllTimeHighScore") as! SKLabelNode]
        labels.append(referenceNode.childNode(withName: "//gameStatsTabAllTimeScore") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabAllTimeJumps") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabMostJumpsInOneGame") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabTotalGamesPlayed") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfCostumesDiscovered") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabFavCostume") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScorePrec1") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc25") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc50") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc100") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc250") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc500") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//gameStatsTabNumOfTimesScoreExc1000") as! SKLabelNode)
    }
    
    /* Animates the gameStatsTab */
    func animate() {
        /* Display the 1st pair of nodes */
        let displayOne = SKAction.run {
            self.nodes[0].isHidden = false
            self.nodes[1].isHidden = false
        }
        
        /* Display the 2nd pair of nodes */
        let displayTwo = SKAction.run {
            self.nodes[2].isHidden = false
            self.nodes[3].isHidden = false
        }
        
        /* Display the 3rd pair of nodes */
        let displayThree = SKAction.run {
            self.nodes[4].isHidden = false
            self.nodes[5].isHidden = false
        }
        
        /* Display the 4th pair of nodes */
        let displayFour = SKAction.run {
            self.nodes[6].isHidden = false
            self.nodes[7].isHidden = false
        }
        
        /* Display the 5th pair of nodes */
        let displayFive = SKAction.run {
            self.nodes[8].isHidden = false
            self.nodes[9].isHidden = false
        }
        
        /* Display the 6th pair of nodes */
        let displaySix = SKAction.run {
            self.nodes[10].isHidden = false
            self.nodes[11].isHidden = false
        }
        
        /* Display the 7th pair of nodes */
        let displaySeven = SKAction.run {
            self.nodes[12].isHidden = false
            self.nodes[13].isHidden = false
        }
        
        /* Wait for 0.45 seconds */
        let wait = SKAction.wait(forDuration: TimeInterval(0.45))
        
        /* Animated the referenceNode */
        self.referenceNode.run(SKAction.sequence([wait, displayOne, wait, displayTwo, wait, displayThree, wait, displayFour, wait, displayFive, wait, displaySix, wait, displaySeven]))
    }
    
    /* Updates the values of the labels in the gameStatsTab */
    func updateLabels() {
        /* Make the text of all the stat labels = to what they actually are in the defaults */
        labels[0].text = String(StoredStats.allTimeHighScore)
        labels[1].text = String(StoredStats.allTimeScore)
        labels[2].text = String(StoredStats.allTimeJumps)
        labels[3].text = String(StoredStats.mostJumpsInOneGame)
        labels[4].text = String(StoredStats.totalGamesPlayed)
        labels[5].text = String(StoredStats.numOfCostumesDiscovered)
        labels[6].text = StoredStats.favCostume
        labels[7].text = String(StoredStats.numOfTimesScorePrec1)
        labels[8].text = String(StoredStats.numOfTimesScoreExc25)
        labels[9].text = String(StoredStats.numOfTimesScoreExc50)
        labels[10].text = String(StoredStats.numOfTimesScoreExc100)
        labels[11].text = String(StoredStats.numOfTimesScoreExc250)
        labels[12].text = String(StoredStats.numOfTimesScoreExc500)
        labels[13].text = String(StoredStats.numOfTimesScoreExc1000)
    }
    
    /* Sets the button handlers for the game stats tab*/
    override func setButtonHandlers() {
        /* Set the references to the buttons in the gameStatsTab */
        let gameStatsTabBackButton_1 = referenceNode.childNode(withName: "//gameStatsTabBackButton_1") as! MSButtonNode
        let gameStatsTabReplayButton_1 = referenceNode.childNode(withName: "//gameStatsTabReplayButton_1") as! MSButtonNode
        //let gameStatsTabShareButton_1 = referenceNode.childNode(withName: "//gameStatsTabShareButton_1") as! MSButtonNode
        
        /* Handler for the back button */
        gameStatsTabBackButton_1.selectedHandler = {
            self.removeElement()
        }
        
        /* Handler for the replay button. Same as the gameOverMenuReplayButton_1 handler */
        gameStatsTabReplayButton_1.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.baseScene.view as SKView!
            
            /* Load Game scene */
            let scene = InfiniteGameScene(fileNamed:"InfiniteGameScene") as InfiniteGameScene!
            
            /* Ensure correct aspect mode */
            scene!.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView!.presentScene(scene)
        }
    }
}
