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
        if GameStats.defaults.bool(forKey: GameStats.soundEnabled) {
            (referenceNode.childNode(withName: ".//soundButtonSprite") as! SKSpriteNode).color = CustomColors.colorGold
        } else {
            (referenceNode.childNode(withName: ".//soundButtonSprite") as! SKSpriteNode).color = CustomColors.colorWhite
        }
        if GameStats.defaults.bool(forKey: GameStats.musicEnabled) {
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
            if GameStats.defaults.bool(forKey: GameStats.soundEnabled) {
                GameStats.defaults.set(false, forKey: GameStats.soundEnabled)
            } else {
                GameStats.defaults.set(true, forKey: GameStats.soundEnabled)
            }
            self.updateButtonColors()
        }
        
        musicButton.selectedHandler = {
            if GameStats.defaults.bool(forKey: GameStats.musicEnabled) {
                GameStats.defaults.set(false, forKey: GameStats.musicEnabled)
                BGMusic.stopBGMusic(scene: self.baseScene)
            } else {
                GameStats.defaults.set(true, forKey: GameStats.musicEnabled)
                BGMusic.playBGMusic(url: BGMusic.getRandSongURL())
            }
            self.updateButtonColors()
        }
    }
}
