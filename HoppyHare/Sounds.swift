//
//  Sounds.swift
//  HoppyBunny
//
//  Created by Matthew Mehrtens on 12/4/16.
//  Copyright © 2016 Mattkx4. All rights reserved.
//

import Foundation
import SpriteKit

class GameSounds {
    /* Check if the sounds have been initialized */
    static var hasBeenInitialized = false
    
    /* Sounds */
    static var flapSFX: SKAction!
    static var goalSFX: SKAction!
    
    /* This function initializes all the sounds being used in the game */
    static func initializeSounds() {
        if !GameSounds.hasBeenInitialized {
            GameSounds.flapSFX = SKAction.playSoundFileNamed("flap", waitForCompletion: false)
            GameSounds.goalSFX = SKAction.playSoundFileNamed("goal", waitForCompletion: false)
            
            GameSounds.hasBeenInitialized = true
        }
    }
}
