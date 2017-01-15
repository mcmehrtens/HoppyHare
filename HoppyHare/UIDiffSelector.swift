//
//  UIDiffSelector.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIDiffSelector: UIElement {
    var labels: [SKLabelNode]!
    
    override func addElement() {
        super.addElement()
        populateLabels()
        setGameDifficultyLabels()
        setButtonHandlers()
    }
    
    /* Populates the array that contains all the labels */
    func populateLabels() {
        labels = [referenceNode.childNode(withName: ".//buttonOneLabel") as! SKLabelNode]
        labels.append(referenceNode.childNode(withName: ".//buttonTwoLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonThreeLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonFourLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonFiveLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonSixLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonSevenLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonEightLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonNineLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: ".//buttonTenLabel") as! SKLabelNode)
    }
    
    /* Set the handlers for all the buttons */
    func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode
        
        safetyButton.selectedHandler = {}
        
        for difficulty in 1...10 {
            print(difficulty)
            (referenceNode.childNode(withName: ".//button" + String(difficulty)) as! MSButtonNode).selectedHandler = {
                GameStats.defaults.set(difficulty, forKey: GameStats.gameDiff)
                self.setGameDifficultyLabels()
            }
        }
    }
    
    /* Set the Game Difficulty Selector Label Nodes */
    func setGameDifficultyLabels() {
        let gameDiff = GameStats.defaults.integer(forKey: GameStats.gameDiff)
        
        if gameDiff == 0 { GameStats.defaults.set(1, forKey: GameStats.gameDiff) }
        
        let selectedLabel = labels[GameStats.defaults.integer(forKey: GameStats.gameDiff) - 1]
        
        for label in labels {
            if label == selectedLabel {
                label.fontColor = CustomColors.colorGold
            } else {
                label.fontColor = CustomColors.colorWhite
            }
        }
    }
}
