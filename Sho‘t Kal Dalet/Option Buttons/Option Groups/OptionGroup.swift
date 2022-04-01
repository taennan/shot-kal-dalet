//
//  OptionGroup.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 28/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Contains types that set how options are arranged in an option group
enum Orientation {
    case horizontal
    case vertical
}


// This object initializes a group of options that can be switched between
class OptionGroup: SKNode {
    
    // An option to be picked from in an option group
    class Option: SKLabelNode {
        var isActive: Bool = false
        let master: OptionGroup
        
        init(masterGroup: OptionGroup) {
            master = masterGroup
            super.init()
            isUserInteractionEnabled = true
            fontName = standardFont
            fontColor = .lightGray
        }
        
        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
        
        // Activates self
        func wasClicked() {
            master.changeOption(to: self)
            fontColor = .white
        }
        
        // Fires when clicked
        override func mouseUp(with event: NSEvent) { wasClicked() }
        
    }
    
    
    let spacing: CGFloat
    let btnSize: CGFloat
    let btnOrientation: Orientation
    
    var optArray: [Option] = []
    var currentOpt: Int
    let totalOpt: Int
    
    let enabledColour: NSColor = .white
    let disabledColour: NSColor = .lightGray
    
    
    init(initialOption: Int, buttonSpacing: CGFloat, buttonSize: CGFloat, orientation: Orientation) {
        
        spacing = buttonSpacing
        btnSize = buttonSize
        btnOrientation = orientation

        totalOpt = optArray.count - 1
        currentOpt = initialOption
        
        super.init()
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Adds options to group. (Must be called after initialization or the group will be empty)
    func addOptions(_ options: [String], master: OptionGroup) {
        
        // Adds buttons
        for opt in options {
            
            // Initialises option
            let btn = Option(masterGroup: self)
            btn.text = opt
            btn.fontName = standardFont
            btn.fontSize = btnSize
            
            // Adds to self
            optArray.append(btn)
            self.addChild(btn)
        }
        
        // Sets colour of initial option
        optArray[currentOpt].fontColor = enabledColour
        
        // Sets position of buttons
        var btnSpace: CGFloat = -1
        
        if btnOrientation == .horizontal {
            // Arranges horizontally
            for btn in optArray {
                btnSpace += 1
                btn.position = CGPoint(x: spacing * btnSpace, y: 0)
            }
        } else {
            // Arranges vertically
            for btn in optArray {
                btnSpace += 1
                btn.position = CGPoint(x: 0, y: spacing * btnSpace)
            }
        }
    }
    
    
    // Changes selected option
    func changeOption(to option: Option) {
        var optIterated: Int = 0
        
        // Sets font colours for all options
        for opt in optArray { opt.fontColor = disabledColour }
        
        // Sets currentOpt
        for opt in optArray {
            if opt == option {
                currentOpt = optIterated
                break
            }
            
            optIterated += 1
        }
        
        activateOption()
    }
    
    
    // Activates selected option. Must be overriden in subclass
    func activateOption() { fatalError("func activateOption() is not overriden in OptionGroup subclass") }
    
}
