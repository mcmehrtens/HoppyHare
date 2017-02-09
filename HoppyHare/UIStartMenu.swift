//
//  UIStartMenu.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 1/6/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class UIStartMenu: UIElement {
    var diffSelector: UIDiffSelector! // Reference to the diff selector menu
    var gameStats: UIGameStats! // Reference to the game stats menu
    var soundPanel: UISoundPanel! // Reference to the sound panel menu
    var scoreboardSwitcher: UIScoreboardSwitcher! // Reference to the scoreboard switcher menu
    var currentMenu: UIElement? // This variable keeps track of what menu is open
    
    /* Buttons */
    var toggleMenuButton: MSButtonNode!
    var diffSelectorButton: MSButtonNode!
    var gameStatsButton: MSButtonNode!
    var soundPanelButton: MSButtonNode!
    var scoreboardSwitcherButton: MSButtonNode!
    
    /* Add the element onto the screen and then set up the button handlers */
    override func addElement() {
        super.addElement()
        setButtonHandlers()
    }
    
    /* Set all the handlers for the buttons in the start menu */
    func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode // Safety button reference
        toggleMenuButton = referenceNode.childNode(withName: ".//toggleMenuButton") as! MSButtonNode // Start menu toggle button reference
        diffSelectorButton = referenceNode.childNode(withName: ".//diffSelectorButton") as! MSButtonNode // Diff selector button reference
        gameStatsButton = referenceNode.childNode(withName: ".//gameStatsButton") as! MSButtonNode // Game stats button reference
        soundPanelButton = referenceNode.childNode(withName: ".//soundPanelButton") as! MSButtonNode // Sound panel button reference
        scoreboardSwitcherButton = referenceNode.childNode(withName: ".//scoreboardSwitcherButton") as! MSButtonNode // Scoreboard switcher button reference
        
        let rightChevronNode = referenceNode.childNode(withName: ".//rightChevronNode")! // rightChevronNode reference
        let leftChevronNode = referenceNode.childNode(withName: ".//leftChevronNode")! // leftChevronNode reference
        
        /* Empty handler for the safetyButton - This ensures the game doesn't start when pressing blank space on the menu! */
        safetyButton.selectedHandler = {}
        
        /* Set the handler for the toggleMenuButton
         - Slides the menu in and out depending on which chevron is visible
         - If the menu is closing, exit all the menus
         */
        toggleMenuButton.selectedHandler = {
            if rightChevronNode.isHidden { // If the right chevron is hidden, the the left chevron is displayed meaning, the user wants to CLOSE the startMenu
                // Slide the menu in
                self.closeSlide()
                
                /* Change the arrow to point RIGHT */
                rightChevronNode.isHidden = false
                leftChevronNode.isHidden = true
                
                /* Close the current menu */
                self.closeCurrentMenu()
            } else {
                // Slide the menu out
                self.openSlide()
                
                /* Change the arrow to point LEFT */
                rightChevronNode.isHidden = true
                leftChevronNode.isHidden = false
            }
        }
        
        /* Set the handler for the diffSelectorButton */
        diffSelectorButton.selectedHandler = {
            if self.diffSelector == nil {
                self.diffSelector = UIDiffSelector(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 5, referenceName: "diffSelectorReferenceNode", resourcePath: "UIDiffSelector", resourceType: "sks") // Create the diffSelector menu
                
                /* Close the current menu */
                self.closeCurrentMenu()
                
                /* Set the current menu */
                self.currentMenu = self.diffSelector
            } else {
                self.closeCurrentMenu()
                self.diffSelector = nil
            }
        }
        
        /* Set the handler for the gameStatsButton */
        gameStatsButton.selectedHandler = {
            if self.baseScene.childNode(withName: "//gameStatsReferenceNode") == nil {
                self.gameStats = UIGameStats(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 5, referenceName: "gameStatsReferenceNode", resourcePath: "UIGameStats", resourceType: "sks") // Create the gameStats menu
                
                /* Close the current menu */
                self.closeCurrentMenu()
                
                /* Set the current menu */
                self.currentMenu = self.gameStats
            } else {
                self.closeCurrentMenu()
                self.gameStats = nil
            }
        }
        
        /* Set the handler for the soundPanelButton */
        soundPanelButton.selectedHandler = {
            if self.baseScene.childNode(withName: "//soundPanelReferenceNode") == nil {
                self.soundPanel = UISoundPanel(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 5, referenceName: "soundPanelReferenceNode", resourcePath: "UISoundPanel", resourceType: "sks") // Create the soundPanel menu
                
                /* Close the current menu */
                self.closeCurrentMenu()
                
                /* Set the current menu */
                self.currentMenu = self.soundPanel
            } else {
                self.closeCurrentMenu()
                self.soundPanel = nil
            }
        }
        
        /* Set the handler for the scoreboardSwitcherButton */
        scoreboardSwitcherButton.selectedHandler = {
            if self.baseScene.childNode(withName: "//scoreboardSwitcherReferenceNode") == nil {
                self.scoreboardSwitcher = UIScoreboardSwitcher(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 5, referenceName: "scoreboardSwitcherReferenceNode", resourcePath: "UIScoreboardSwitcher", resourceType: "sks") // Create the scoreboardSwitcher menu
                
                /* Close the current menu */
                self.closeCurrentMenu()
                
                /* Set the current menu */
                self.currentMenu = self.scoreboardSwitcher
            } else {
                self.closeCurrentMenu()
                self.scoreboardSwitcher = nil
            }
        }
    }
    
    /* Closes the current menu if there is one */
    func closeCurrentMenu() {
        if let menu = currentMenu {
            menu.removeElement()
            currentMenu = nil
        }
    }
    
    /* This animation slides the startMenu to a closed position */
    func closeSlide() {
        let closeSlide = SKAction.move(to: CGPoint(x: -230, y: -209.5), duration: 0.5)
        closeSlide.timingMode = SKActionTimingMode.easeOut
        
        referenceNode.run(closeSlide)
    }
    
    /* This animation slides the startMenu to an open position */
    func openSlide() {
        let openSlide = SKAction.move(to: CGPoint(x: 0, y: -209.5), duration: 0.5)
        openSlide.timingMode = SKActionTimingMode.easeOut
        
        /* Slide it */
        referenceNode.run(openSlide)
    }
    
    /* This animation slides the startMenu to an off-screen position - Also removes the menu node */
    func offSlide() {
        /* First things first, we disable all the buttons so that the user can't press the button while the menu is closing. */
        toggleMenuButton.removeFromParent()
        diffSelectorButton.removeFromParent()
        gameStatsButton.removeFromParent()
        soundPanelButton.removeFromParent()
        scoreboardSwitcherButton.removeFromParent()
        
        let offSlide = SKAction.move(to: CGPoint(x: -270, y: -209.5), duration: 0.5)
        offSlide.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the start menu off, then remove the startMenuReferenceNode */
        referenceNode.run(SKAction.sequence([offSlide, SKAction.run { self.removeElement() }]))
        
        /* If a menu is open, close it */
        closeCurrentMenu()
    }
}
