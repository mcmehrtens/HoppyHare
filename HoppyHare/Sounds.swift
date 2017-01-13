//
//  Sounds.swift
//  HoppyBunny
//
//  Created by Matthew Mehrtens on 12/4/16.
//  Copyright © 2016 Mattkx4. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

struct Sounds {
    /* Check if the sounds have been initialized */
    static var hasBeenInitialized = false
    
    /* Declare a dictionary to hold the sounds */
    static var sounds: [String: SKAction?] = [:]
    
    /* This function initializes all the sounds being used in the game */
    static func initializeSounds() {
        if !Sounds.hasBeenInitialized {
            sounds["jump"] = SKAction.playSoundFileNamed("jump", waitForCompletion: false)
            sounds["goal"] = SKAction.playSoundFileNamed("goal", waitForCompletion: false)
            
            Sounds.hasBeenInitialized = true
        }
    }
    
    /* This function plays the sound */
    static func playSound(soundName: String, object: SKScene) {
        /* Check if the sound has been disabled. If so, immediately return */
        if GameStats.getStat(statName: GameStats.soundEnabled) == 1 { return }
        
        /* Check if there's a vlue in the dictionary for the name provided */
        if sounds[soundName] != nil {
            object.run(sounds[soundName]!!)
        } else {
            print("[ERROR] Sound with the name \(soundName) doesn't exist.")
        }
    }
}
