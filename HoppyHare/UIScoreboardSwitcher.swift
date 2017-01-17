//
//  ScoreboardSwitcher.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/9/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class UIScoreboardSwitcher: UIElement {
    var leftButton: (MSButtonNode, SKSpriteNode)! // leftButton and leftButtonSprite references
    var rightButton: (MSButtonNode, SKSpriteNode)! // rightButton and rightButtonSprite references
    
    /* Add the element onto the screen, set the button handlers, and set the proper colors to the buttons */
    override func addElement() {
        super.addElement()
        
        /* Set the references to the left/right buttons/sprites */
        leftButton = (referenceNode.childNode(withName: ".//leftButton") as! MSButtonNode, referenceNode.childNode(withName: ".//leftButtonSprite") as! SKSpriteNode)
        rightButton = (referenceNode.childNode(withName: ".//rightButton") as! MSButtonNode, referenceNode.childNode(withName: ".//rightButtonSprite") as! SKSpriteNode)
        
        setButtonHandlers()
        setButtonColors()
    }
    
    /* Set the button handler for the left, right, and safety button. */
    func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode // Set the safetyButton reference
        
        /* Empty handler for the safetyButton - This ensures the game doesn't start when pressing blank space on the menu! */
        safetyButton.selectedHandler = {}
        
        /* Set the scoreboardSwitcher value to be false (left) - Update button colors */
        leftButton.0.selectedHandler = {
            GameStats.defaults.set(false, forKey: GameStats.scoreboardSide)
            self.setButtonColors()
        }
        
        /* Set the scoreboardSwitcher value to be true (right) - Update button colors */
        rightButton.0.selectedHandler = {
            GameStats.defaults.set(true, forKey: GameStats.scoreboardSide)
            self.setButtonColors()
        }
    }
    
    /* Sets the colors for the buttons in the scoreboardSwitcherMenu */
    func setButtonColors() {
        /* If the scoreboardSide stat is set to false (left):
         - Left button = gold
         - Right button = white
         
         If the scoreboardSide stat is set to true (right):
         - Left button = white
         - Right button = gold
         */
        if GameStats.defaults.bool(forKey: GameStats.scoreboardSide) {
            leftButton.1.color = CustomColors.colorWhite
            rightButton.1.color = CustomColors.colorGold
        } else {
            leftButton.1.color = CustomColors.colorGold
            rightButton.1.color = CustomColors.colorWhite
        }
    }
}
