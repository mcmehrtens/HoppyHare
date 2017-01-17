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
    var labels: [SKLabelNode]! // Array holds all the label nodes in the diffSelectorMenu
    
    override func addElement() {
        super.addElement()
        populateLabels() // Populates the label array
        setGameDifficultyLabels() // Set the button with the actual game difficulty to be golden
        setButtonHandlers() // Set the button handlers in the diffSelectorMenu
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
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode // Set the safety button reference
        
        /* Empty handler for the safetyButton - This ensures the game doesn't start when pressing blank space on the menu! */
        safetyButton.selectedHandler = {}
        
        /* Sets the handlers for the diffSelectorButtons 
         - Loops through 10 times starting at 1
         - Each time it loops, it gets a different button and uses that same number that it got the button with to assign a different value to the selectedHandler. A little confusing to explain, but look at the code.
         */
        for difficulty in 1...10 {
            (referenceNode.childNode(withName: ".//button" + String(difficulty)) as! MSButtonNode).selectedHandler = {
                GameStats.defaults.set(difficulty, forKey: GameStats.gameDiff)
                self.setGameDifficultyLabels() // Update the labels to set the game difficulty button to be golden
            }
        }
    }
    
    /* Set the gameDiffSelector menu's buttons to be their appropriate color */
    func setGameDifficultyLabels() {
        var gameDiff = GameStats.defaults.integer(forKey: GameStats.gameDiff) // Gets the game difficulty
        
        /* If the gameDifficulty is 0, set it to be 1 */
        if gameDiff == 0 {
            GameStats.defaults.set(1, forKey: GameStats.gameDiff)
            gameDiff = 1
        }
        
        /* Gets the label with the gameDifficulty in it by subtracting one from the gameDifficulty and finding that associate position in the array */
        let selectedLabel = labels[gameDiff - 1]
        
        /* Loop through all the labels - When you find the selectedLabel, set it's color to be gold */
        for label in labels {
            if label == selectedLabel {
                label.fontColor = CustomColors.colorGold
            } else {
                label.fontColor = CustomColors.colorWhite
            }
        }
    }
}
