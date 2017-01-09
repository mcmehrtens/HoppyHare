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

class Music {
    /* Create an AVPlayer to play the BG music */
    static var bgMusicPlayer: AVAudioPlayer!
    
    static func playRandSong() {
        let songNumber = arc4random_uniform(5)
        var songURL: URL!
        
        switch songNumber {
        case 0:
            songURL = URL(fileReferenceLiteralResourceName: "music-delta.mp3")
        case 1:
            songURL = URL(fileReferenceLiteralResourceName: "music-intro.mp3")
        case 2:
            songURL = URL(fileReferenceLiteralResourceName: "music-neon.mp3")
        case 3:
            songURL = URL(fileReferenceLiteralResourceName: "music-syn.mp3")
        case 4:
            songURL = URL(fileReferenceLiteralResourceName: "music-wolf.mp3")
        default:
            break
        }
        
        do {
            try Music.bgMusicPlayer = AVAudioPlayer(contentsOf: songURL)
        } catch {
            print(error)
        }
        Music.bgMusicPlayer.numberOfLoops = -1
        Music.bgMusicPlayer.prepareToPlay()
        Music.bgMusicPlayer.play()
        Music.bgMusicPlayer.setVolume(1.0, fadeDuration: TimeInterval(2.0))
    }
    
    static func playSong(url: URL) {
        do {
            try Music.bgMusicPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print(error)
        }
        
        Music.bgMusicPlayer.numberOfLoops = -1
        Music.bgMusicPlayer.prepareToPlay()
        Music.bgMusicPlayer.play()
    }
    
    static func fadeToGameSong(volume: Float, fadeDuration: TimeInterval, scene: SKScene) {
        scene.run(SKAction.sequence([SKAction.run { Music.bgMusicPlayer.setVolume(volume, fadeDuration: fadeDuration) }, SKAction.wait(forDuration: fadeDuration), SKAction.run { Music.playRandSong() }]))
    }
}
