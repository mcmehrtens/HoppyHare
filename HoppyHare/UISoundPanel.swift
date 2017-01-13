//
//  UISoundPanel.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/8/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class UISoundPanel: UIElement {
    override func addElement() {
        super.addElement()
        updateButtonColors()
        setButtonHandlers()
    }
    
    func updateButtonColors() {
        if GameStats.getStat(statName: GameStats.soundEnabled) == 0 {
            (referenceNode.childNode(withName: ".//soundButtonSprite") as! SKSpriteNode).color = CustomColors.colorGold
        } else {
            (referenceNode.childNode(withName: ".//soundButtonSprite") as! SKSpriteNode).color = CustomColors.colorWhite
        }
        if GameStats.getStat(statName: GameStats.musicEnabled) == 0 {
            (referenceNode.childNode(withName: ".//musicButtonSprite") as! SKSpriteNode).color = CustomColors.colorGold
        } else {
            (referenceNode.childNode(withName: ".//musicButtonSprite") as! SKSpriteNode).color = CustomColors.colorWhite
        }
    }
    
    func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode
        let soundButton = referenceNode.childNode(withName: ".//soundButton") as! MSButtonNode
        let musicButton = referenceNode.childNode(withName: ".//musicButton") as! MSButtonNode
        
        safetyButton.selectedHandler = {}
        
        soundButton.selectedHandler = {
            if GameStats.getStat(statName: GameStats.soundEnabled) == 0 {
                GameStats.setStat(statName: GameStats.soundEnabled, value: 1)
            } else {
                GameStats.setStat(statName: GameStats.soundEnabled, value: 0)
            }
            self.updateButtonColors()
        }
        
        musicButton.selectedHandler = {
            if GameStats.getStat(statName: GameStats.musicEnabled) == 0 {
                GameStats.setStat(statName: GameStats.musicEnabled, value: 1)
                BGMusic.stopBGMusic(scene: self.baseScene)
            } else {
                GameStats.setStat(statName: GameStats.musicEnabled, value: 0)
                BGMusic.playBGMusic(url: BGMusic.getRandSongURL())
            }
            self.updateButtonColors()
        }
    }
}
