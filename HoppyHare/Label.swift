//
//  Label.swift
//  HoppyHare
//
//  Created by Matthew Mehrtens on 2/10/17.
//  Copyright © 2017 Mattkx4 Apps. All rights reserved.
//

import GameplayKit

struct Label {
    /* Creates and returns an SKLabelNode NOTE: THIS DOES NOT ADD IT TO THE SCREEN */
    static func createLabel(name: String, text: String, fontName: String, fontSize: CGFloat, fontColor: UIColor, zPosition: CGFloat, horizontalAlign: SKLabelHorizontalAlignmentMode, verticalAlign: SKLabelVerticalAlignmentMode) -> SKLabelNode {
        let label = SKLabelNode()
        label.name = name
        label.text = text
        label.fontName = fontName
        label.fontSize = fontSize
        label.fontColor = fontColor
        label.zPosition = zPosition
        label.horizontalAlignmentMode = horizontalAlign
        label.verticalAlignmentMode = verticalAlign
        return label
    }
}

struct LabelAnimations {
    /* "Slide to" position animation */
    static func slideToAnimation(position: CGPoint, duration: TimeInterval, timingMode: SKActionTimingMode) -> SKAction {
        let animation = SKAction.move(to: position, duration: duration)
        animation.timingMode = timingMode
        return animation
    }
    
    /* "Slide by" position animation */
    static func slideByAnimation(vector: CGVector, duration: TimeInterval, timingMode: SKActionTimingMode) -> SKAction {
        let animation = SKAction.move(by: vector, duration: duration)
        animation.timingMode = timingMode
        return animation
    }
}
