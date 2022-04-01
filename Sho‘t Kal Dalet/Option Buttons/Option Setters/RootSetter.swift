//
//  OptionSelector.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 19/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Object used to select one of multiple grouped settings
class OptionSetter: SKNode {
    
    var hasSelectors: Bool = false
    let doesLoop: Bool
    
    let totalOpt: Int
    let optArray: [String]
    var currentOpt: Int
    
    var selOne: Selector?
    var selTwo: Selector?
    
    let optLabel = SKLabelNode()

    
    init(allOptions: [String], loopOptions: Bool) {
        
        optArray = allOptions
        totalOpt = optArray.count - 1
        currentOpt = 0
        doesLoop = loopOptions
        
        optLabel.zPosition = settingsLayer.zPosition + 1
        optLabel.fontName = standardFont
        optLabel.fontSize = 50
        optLabel.fontColor = .white
        
        selOne = nil
        selTwo = nil
        
        super.init()
        isUserInteractionEnabled = true
        
        addChild(optLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Adds selectors either side of self (must call in order to use Option Selector)
    func addSelectors(spacing: CGFloat) {
        
        // Guards against re-adding selectors
        guard self.hasSelectors == false else { fatalError("Attempted to add selectors to Option Selector that already has some") }
        
        hasSelectors = true
        
        // Initializes and adds selectors
        selOne = Selector(switchToLeft: true, affects: self)
        selOne?.position = CGPoint(x: optLabel.position.x - spacing, y: optLabel.position.y - 5)
        self.addChild(selOne!)
        
        selTwo = Selector(switchToLeft: false, affects: self)
        selTwo?.position = CGPoint(x: optLabel.position.x + spacing, y: optLabel.position.y - 5)
        self.addChild(selTwo!)
        
    }
    
    // Changes current option
    func changeOpt(to opt: Int) {
        currentOpt = opt
        
        // Checks if selectors are to be enabled
        if currentOpt > 0 || currentOpt < totalOpt {
            selOne?.fontColor = .white
            selOne?.isUserInteractionEnabled = true
            selTwo?.fontColor = .white
            selTwo?.isUserInteractionEnabled = true
        }
        
        
        // Checks if currentOpt must be looped or selectors disabled
        if doesLoop {
            
            // LØØPS option
            if currentOpt < 0 {
                currentOpt = totalOpt
            } else if currentOpt > totalOpt {
                currentOpt = 0
            }
            
        } else {
            
            // Disables selector
            if currentOpt == 0 {
                selOne?.fontColor = .lightGray
                selOne?.isUserInteractionEnabled = false
            } else if currentOpt == totalOpt {
                selTwo?.fontColor = .lightGray
                selTwo?.isUserInteractionEnabled = false
            }
            
        }
        
        // Sets label and activates option
        optLabel.text = optArray[currentOpt]
        activateOpt()
        
    }
    
    // Runs code for current option. (Must be overriden in subclasses or will throw error)
    func activateOpt() { fatalError("Did not override 'activateOpt()' in OptionSetter subclass") }
    
}


