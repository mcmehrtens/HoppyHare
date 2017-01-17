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
    
    /* This function initializes all the sounds being used in the game. This prevents a bug that would cause visual and audio lag the first time a sound was run.  */
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
        if !GameStats.defaults.bool(forKey: GameStats.soundEnabled) { return }
        
        /* Check if there's a value in the dictionary for the name provided */
        if let sound = sounds[soundName] {
            object.run(sound!)
        } else {
            print("[ERROR] Sound with the name \(soundName) doesn't exist.")
        }
    }
}
