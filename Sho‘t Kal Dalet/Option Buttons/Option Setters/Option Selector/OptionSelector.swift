//
//  OptionSelector.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 22/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Object used to select individual options in option selector
class Selector: SKLabelNode {
    
    let changeBy: Int
    let textShown: String
    let setter: OptionSetter
    
    let enabledColour: NSColor = .white
    let disabledColour: NSColor = .lightGray
    
    init(switchToLeft: Bool, affects: OptionSetter) {
        
        setter = affects
        
        if switchToLeft == true {     // Had to put this here for reasons
            changeBy = -1
            textShown = "<"
        } else {
            changeBy = 1
            textShown = ">"
        }
        
        super.init()
        
        text = textShown
        isUserInteractionEnabled = true
        fontName = standardFont
        fontSize = 50
        fontColor = enabledColour
        zPosition = settingsLayer.zPosition + 1
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Toggles new option in setter
    override func mouseUp(with event: NSEvent) {
        
        setter.changeOpt(to: setter.currentOpt + changeBy)
        
        print("Option changed")
        
    }
    
    
}
