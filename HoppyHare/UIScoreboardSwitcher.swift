//
//  ScoreboardSwitcher.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/9/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class UIScoreboardSwitcher: UIElement {
    override func addElement() {
        super.addElement()
        updateButtonColors()
        setButtonHandlers()
    }
    
    /* Updates the colors for the ScoreboardSwitcher Menu */
    func updateButtonColors() {
        let leftButtonSprite = referenceNode.childNode(withName: ".//leftButtonSprite") as! SKSpriteNode
        let rightButtonSprite = referenceNode.childNode(withName: ".//rightButtonSprite") as! SKSpriteNode
        
        if GameStats.getStat(statName: GameStats.scoreboardSwitcher) == 0 {
            leftButtonSprite.color = CustomColors.colorGold
            rightButtonSprite.color = CustomColors.colorWhite
        } else {
            leftButtonSprite.color = CustomColors.colorWhite
            rightButtonSprite.color = CustomColors.colorGold
        }
    }
    
    /* Set up button handlers */
    func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode
        let leftButton = referenceNode.childNode(withName: ".//leftButton") as! MSButtonNode
        let rightButton = referenceNode.childNode(withName: ".//rightButton") as! MSButtonNode
        
        safetyButton.selectedHandler = {}
        
        leftButton.selectedHandler = {
            GameStats.setStat(statName: GameStats.scoreboardSwitcher, value: 0)
            self.updateButtonColors()
        }
        
        rightButton.selectedHandler = {
            GameStats.setStat(statName: GameStats.scoreboardSwitcher, value: 1)
            self.updateButtonColors()
        }
    }
}
