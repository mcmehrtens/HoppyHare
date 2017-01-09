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
    var labels: [SKLabelNode] = []
    
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
    override func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode
        
        safetyButton.selectedHandler = {}
        
        (referenceNode.childNode(withName: ".//buttonOne") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 1)
        }
        (referenceNode.childNode(withName: ".//buttonTwo") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 2)
        }
        (referenceNode.childNode(withName: ".//buttonThree") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 3)
        }
        (referenceNode.childNode(withName: ".//buttonFour") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 4)
        }
        (referenceNode.childNode(withName: ".//buttonFive") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 5)
        }
        (referenceNode.childNode(withName: ".//buttonSix") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 6)
        }
        (referenceNode.childNode(withName: ".//buttonSeven") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 7)
        }
        (referenceNode.childNode(withName: ".//buttonEight") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 8)
        }
        (referenceNode.childNode(withName: ".//buttonNine") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 9)
        }
        (referenceNode.childNode(withName: ".//buttonTen") as! MSButtonNode).selectedHandler = {
            self.removeElement()
            GameStats.setStat(statName: GameStats.gameDiff, value: 10)
        }
    }
    
    /* Set the Game Difficulty Selector Label Nodes */
    func setGameDifficultyLabels() {
        let selectedLabel = labels[GameStats.getStat(statName: GameStats.gameDiff) - 1]
        
        for label in labels {
            if label == selectedLabel {
                label.fontColor = CustomColors.colorGold
            } else {
                label.fontColor = CustomColors.colorWhite
            }
        }
    }
}
