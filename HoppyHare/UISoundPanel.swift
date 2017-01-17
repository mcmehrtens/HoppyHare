//
//  UISoundPanel.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/8/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

class UISoundPanel: UIElement {
    var soundButton: (MSButtonNode, SKSpriteNode)! // soundButton and soundButtonSprite references
    var musicButton: (MSButtonNode, SKSpriteNode)! // musicButton and musicButtonSprite references
    
    /* Add the element to the screen as well as set the proper butotn colors and their handlers */
    override func addElement() {
        super.addElement()
        
        /* Set the references to the sound/music buttons/sprites */
        soundButton = (referenceNode.childNode(withName: ".//soundButton") as! MSButtonNode, referenceNode.childNode(withName: ".//soundButtonSprite") as! SKSpriteNode)
        musicButton = (referenceNode.childNode(withName: ".//musicButton") as! MSButtonNode, referenceNode.childNode(withName: ".//musicButtonSprite") as! SKSpriteNode)
        
        setButtonHandlers()
        setButtonColors()
    }
    
    /* Set the music/sound button handlers (oh and the safety button, but honestly, who cares about the safetyButton?)*/
    func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode // Set safetyButton reference
        
        /* Empty handler for the safetyButton - This ensures the game doesn't start when pressing blank space on the menu! */
        safetyButton.selectedHandler = {}
        
        /* Set the sound button handler */
        soundButton.0.selectedHandler = {
            /* If sound is enabled, disable it. If it's disabled, enable it. */
            if GameStats.defaults.bool(forKey: GameStats.soundEnabled) {
                GameStats.defaults.set(false, forKey: GameStats.soundEnabled)
            } else {
                GameStats.defaults.set(true, forKey: GameStats.soundEnabled)
            }
            
            self.setButtonColors() // Update the button colors
        }
        
        /* Set the music button handler */
        musicButton.0.selectedHandler = {
            /* if music is enabled, disable it and stop the music. If it's disabled, enable it and play the music. */
            if GameStats.defaults.bool(forKey: GameStats.musicEnabled) {
                GameStats.defaults.set(false, forKey: GameStats.musicEnabled)
                BGMusic.stopBGMusic(scene: self.baseScene)
            } else {
                GameStats.defaults.set(true, forKey: GameStats.musicEnabled)
                BGMusic.playBGMusic(url: BGMusic.getRandSongURL())
            }
            
            self.setButtonColors() // Update the button colors
        }
    }
    
    /* Sets the button colors to their appropriate color */
    func setButtonColors() {
        /* If the sound is enabled, set the soundButton to be gold. If not, make it white. */
        if GameStats.defaults.bool(forKey: GameStats.soundEnabled) {
            soundButton.1.color = CustomColors.colorGold
        } else {
            soundButton.1.color = CustomColors.colorWhite
        }
        
        /* If the music is enabled, set the musicButton to be gold. If not, make it white. */
        if GameStats.defaults.bool(forKey: GameStats.musicEnabled) {
            musicButton.1.color = CustomColors.colorGold
        } else {
            musicButton.1.color = CustomColors.colorWhite
        }
    }
}
