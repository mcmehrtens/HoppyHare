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
        let startMenuSafetyButton = referenceNode.childNode(withName: "//startMenuSafetyButton") as! MSButtonNode
        let startMenuButton_1 = referenceNode.childNode(withName: "//startMenuButton_1") as! MSButtonNode
        let startMenuDiffSelectorButton_1 = referenceNode.childNode(withName: "//startMenuDiffSelectorButton_1") as! MSButtonNode
        
        /* Set the handler for the safety button */
        startMenuSafetyButton.selectedHandler = {}
        
        /* Handler for the startMenuButton_1. This slides the thing in or out */
        startMenuButton_1.selectedHandler = {
            if self.referenceNode.childNode(withName: "//startMenuRightChevronNode")!.isHidden {
                // Slide the menu in
                self.closeSlide()
                
                /* Change the arrow to the RIGHT direction */
                self.referenceNode.childNode(withName: "//startMenuRightChevronNode")!.isHidden = false
                self.referenceNode.childNode(withName: "//startMenuLeftChevronNode")!.isHidden = true
                
                /* Check to see if the diffSelector is visible */
                if self.diffSelector != nil {
                    self.diffSelector.removeElement()
                }
            } else {
                // Slide the menu out
                self.openSlide()
                
                /* Change the arrow to the LEFT direction */
                self.referenceNode.childNode(withName: "//startMenuRightChevronNode")!.isHidden = true
                self.referenceNode.childNode(withName: "//startMenuLeftChevronNode")!.isHidden = false
            }
        }
        
        /* Handler for the diffSelectorButton */
        startMenuDiffSelectorButton_1.selectedHandler = {
            if self.baseScene.childNode(withName: "//diffSelectorReferenceNode") == nil {
                self.diffSelector = UIDiffSelector(baseScene: self.baseScene, pos: CGPoint(x: 0, y: 0), zPos: 1, referenceName: "diffSelectorReferenceNode", resourcePath: "DiffSelector", resourceType: "sks")
                self.diffSelector.addElement()
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
        
        if self.diffSelector != nil { self.diffSelector.removeElement() }
    }
}
