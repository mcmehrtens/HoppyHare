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
    var buttons: [MSButtonNode] = []
    
    override func addElement() {
        super.addElement()
        populateLabels()
        populateButtons()
        setGameDifficultyLabels()
        setButtonHandlers()
    }
    
    /* Populates the array that contains all the labels */
    func populateLabels() {
        labels = [referenceNode.childNode(withName: "//diffSelectorButtonOneLabel") as! SKLabelNode]
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonTwoLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonThreeLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonFourLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonFiveLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonSixLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonSevenLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonEightLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonNineLabel") as! SKLabelNode)
        labels.append(referenceNode.childNode(withName: "//diffSelectorButtonTenLabel") as! SKLabelNode)
    }
    
    /* Populates the array that contains all the buttons */
    func populateButtons() {
        buttons = [referenceNode.childNode(withName: "//diffSelectorButtonOne_1") as! MSButtonNode]
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonTwo_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonThree_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonFour_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonFive_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonSix_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonSeven_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonEight_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonNine_1") as! MSButtonNode)
        buttons.append(referenceNode.childNode(withName: "//diffSelectorButtonTen_1") as! MSButtonNode)
    }
    
    /* Set the handlers for all the buttons */
    override func setButtonHandlers() {
        buttons[0].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 1
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[1].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 2
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[2].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 3
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[3].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 4
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[4].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 5
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[5].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 6
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[6].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 7
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[7].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 8
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[8].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 9
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
        buttons[9].selectedHandler = {
            self.removeElement()
            StoredStats.gameDifficulty = 10
            StoredStats.defaults.set(StoredStats.gameDifficulty, forKey: "gameDifficulty")
        }
    }
    
    /* Set the Game Difficulty Selector Label Nodes */
    func setGameDifficultyLabels() {
        let selectedLabel = labels[StoredStats.gameDifficulty - 1]
        
        for label in labels {
            if label == selectedLabel {
                label.fontColor = CustomColors.colorGold
            } else {
                label.fontColor = CustomColors.colorWhite
            }
        }
    }
}
