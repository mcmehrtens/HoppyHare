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
    var diffSelector: UIDiffSelector!
    
    override func addElement() {
        super.addElement()
        setButtonHandlers()
    }
    
    override func setButtonHandlers() {
        let safetyButton = referenceNode.childNode(withName: ".//safetyButton") as! MSButtonNode
        let toggleMenuButton = referenceNode.childNode(withName: ".//toggleMenuButton") as! MSButtonNode
        let diffSelectorButton = referenceNode.childNode(withName: ".//diffSelectorButton") as! MSButtonNode
        
        let rightChevronNode = referenceNode.childNode(withName: ".//rightChevronNode")!
        let leftChevronNode = referenceNode.childNode(withName: ".//leftChevronNode")!
        
        /* Set the handler for the safety button */
        safetyButton.selectedHandler = {}
        
        /* Handler for the startMenuButton_1. This slides the thing in or out */
        toggleMenuButton.selectedHandler = {
            if rightChevronNode.isHidden {
                // Slide the menu in
                self.closeSlide()
                
                /* Change the arrow to the RIGHT direction */
                rightChevronNode.isHidden = false
                leftChevronNode.isHidden = true
                
                /* Check to see if the diffSelector is visible */
                if self.diffSelector != nil {
                    self.diffSelector.removeElement()
                }
            } else {
                // Slide the menu out
                self.openSlide()
                
                /* Change the arrow to the LEFT direction */
                rightChevronNode.isHidden = true
                leftChevronNode.isHidden = false
            }
        }
        
        /* Handler for the diffSelectorButton */
        diffSelectorButton.selectedHandler = {
            if self.baseScene.childNode(withName: "//diffSelectorReferenceNode") == nil {
                self.diffSelector = UIDiffSelector(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 1, referenceName: "diffSelectorReferenceNode", resourcePath: "DiffSelector", resourceType: "sks")
            } else {
                self.diffSelector.removeElement()
            }
        }
    }
    
    /* This animation slides the startMenu closed */
    func closeSlide() {
        let closeSlide = SKAction.move(to: CGPoint(x: -230, y: -209.5), duration: 0.5)
        closeSlide.timingMode = SKActionTimingMode.easeOut
        
        /* DO IT */
        referenceNode.run(closeSlide)
    }
    
    /* This animation slides the startMenu open */
    func openSlide() {
        let openSlide = SKAction.move(to: CGPoint(x: 0, y: -209.5), duration: 0.5)
        openSlide.timingMode = SKActionTimingMode.easeOut
        
        /* Slide it */
        referenceNode.run(openSlide)
    }
    
    /* This animation slides the startMenu off */
    func offSlide() {
        let offSlide = SKAction.move(to: CGPoint(x: -270, y: -209.5), duration: 0.5)
        offSlide.timingMode = SKActionTimingMode.easeOut
        
        /* Slide the start menu off, then remove the startMenuReferenceNode, then remove the difficultySelectorReferenceNode*/
        referenceNode.run(SKAction.sequence([offSlide, SKAction.run { self.removeElement() }]))
        
        /* If diffSelector is on the screen, then remove it */
        if self.diffSelector != nil { self.diffSelector.removeElement() }
    }
}
