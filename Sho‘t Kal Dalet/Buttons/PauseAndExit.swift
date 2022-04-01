//
//  PauseButton.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 4/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit

/*
 These double as a subclassing test
 */

// Set type of button
enum ButtonType {
    case pause
    case exit
}


// Main class. Is not used in-game except as a parent of the two that follow
class Button: SKSpriteNode {
    
    // Properties
    let buttonTex: SKTexture
    let buttonSize: CGFloat
    var buttonPos: CGPoint
    
    let fadeAction = SKAction.fadeOut(withDuration: 0.5)
    let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
    
    
    init(_ asType: ButtonType) {
        
        if asType == .pause {
            buttonTex = tex.pauseTex
        } else {
            buttonTex = tex.exitTex
        }
        
        buttonSize = meter * 4
        buttonPos = CGPoint(x: 0, y: 0)
        
        
        super.init(texture: buttonTex, color: .clear, size: CGSize(width: buttonSize, height: buttonSize))
        position = buttonPos
        isUserInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Will be overridden in child classes
    func wasActivated() { return }
    
    // Responds to click
    override func mouseDown(with event: NSEvent) { wasActivated() }
    
}


// Pauses game and shows pause layer
let pauseButton = PauseButton()

class PauseButton: Button {
    
    init() {
        super.init(.pause)
        position = CGPoint(x: (sceneWidth / 2) - self.size.width, y: (sceneHeight / 2) - (self.size.height * 2) )
        zPosition = pauseLayer.zPosition + 1
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Brings up pause layer
    override func wasActivated() { pauseFunc.showPauseLayer() }
    
    
}


// Closes pause layer and plays game
class ExitButton: Button {
    
    init() {
        super.init(.exit)
        buttonPos = CGPoint(x: -sceneWidth / 4, y: 0)
        position = buttonPos
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Removes pause layer
    override func wasActivated() { pauseFunc.hidePauseLayer() }
    
    
}
