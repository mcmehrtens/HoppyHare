//
//  Music.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/8/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import AVFoundation
import SpriteKit
import GameplayKit

class BGMusic {
    /* Create an AVPlayer to play the BG music */
    static var bgMusicPlayer: AVAudioPlayer!
    
    /* Return a random song URL */
    static func getRandSongURL() -> URL  {
        let songNumber = arc4random_uniform(5)
        
        switch songNumber {
        case 0:
            return URL(fileReferenceLiteralResourceName: "music-delta.mp3")
        case 1:
            return URL(fileReferenceLiteralResourceName: "music-intro.mp3")
        case 2:
            return URL(fileReferenceLiteralResourceName: "music-neon.mp3")
        case 3:
            return URL(fileReferenceLiteralResourceName: "music-syn.mp3")
        case 4:
            return URL(fileReferenceLiteralResourceName: "music-wolf.mp3")
        default:
            return URL(fileReferenceLiteralResourceName: "music-wolf.mp3")
        }
    }
    
    /* Play the bgMusicPlayer with the selected song */
    static func playBGMusic(url: URL) {
        if !GameStats.defaults.bool(forKey: GameStats.musicEnabled) { return }
        
        /* Try and assign the bgMusicPlayer to the desired URL */
        do {
            try bgMusicPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print(error)
        }
        
        BGMusic.bgMusicPlayer.numberOfLoops = -1 // Loop infinitely
        BGMusic.bgMusicPlayer.volume = 0.0
        BGMusic.bgMusicPlayer.play()
        BGMusic.bgMusicPlayer.setVolume(1.0, fadeDuration: TimeInterval(0.25)) // Fade in
    }
    
    /* Stop the bgMusicPlayer */
    static func stopBGMusic(scene: SKScene) {
        scene.run(SKAction.sequence([SKAction.run {
            BGMusic.bgMusicPlayer.setVolume(0.0, fadeDuration: TimeInterval(0.5))
            }, SKAction.wait(forDuration: TimeInterval(0.5)), SKAction.run {
                BGMusic.bgMusicPlayer.stop()
            }]))
    }
}
