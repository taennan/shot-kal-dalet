//
//  SettingsLayer.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 24/9/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


let sL = SettingsLayer()

class SettingsLayer: SKNode {
    
    // Nodes
    let title = SKLabelNode(text: "Settings")
    let done = LayerChanger(from: settingsLayer, to: menuLayer, textShown: "Done")
    
    // Labels
    let modeLabel = SKLabelNode(text: "Game Mode:")
    let rofLabel = SKLabelNode(text: "R.O.F:")
    let diffLabel = SKLabelNode(text: "Difficulty:")
    
    // Option Setters
    let diffSett = DifficultySetter()
    let rofSett = ROFSetter()
    let modeSett = GameModeGroup()
    
    
    override init() {
        
        // Layer Title
        title.position = CGPoint(x: 0, y: (sceneHeight / 7) * 2 )
        title.fontSize = 70
        title.fontName = standardFont
        title.fontColor = .white
        
        // Navigation button
        done.position = CGPoint(x: 0, y: -title.position.y)
        done.fontSize = 40
        done.fontName = standardFont
        done.fontColor = .lightGray
        
        // Game mode label and setter
        modeLabel.position = CGPoint(x: -sceneWidth / 4, y: sceneHeight / 7)
        modeLabel.fontSize = 50
        modeLabel.fontName = standardFont
        modeLabel.fontColor = .white
        
        modeSett.position = CGPoint(x: -modeLabel.position.x - 70, y: modeLabel.position.y)
        modeSett.addOptions(["Day", "Night"], master: modeSett)
        modeSett.activateOption()
        
        // R.O.F (Rate of Fire) label and setter
        rofLabel.position = CGPoint(x: modeLabel.position.x, y: 0)
        rofLabel.fontSize = modeLabel.fontSize
        rofLabel.fontName = standardFont
        rofLabel.fontColor = modeLabel.fontColor
        
        rofSett.position = CGPoint(x: -rofLabel.position.x, y: rofLabel.position.y)
        rofSett.addSelectors(spacing: 75)
        rofSett.changeOpt(to: 2)        // Sets initial option
        
        // Difficulty label and setter
        diffLabel.position = CGPoint(x: modeLabel.position.x, y: -sceneHeight / 7)
        diffLabel.fontColor = modeLabel.fontColor
        diffLabel.fontName = standardFont
        diffLabel.fontSize = modeLabel.fontSize
        
        diffSett.position = CGPoint(x: -diffLabel.position.x, y: diffLabel.position.y)
        diffSett.addSelectors(spacing: 200)
        diffSett.changeOpt(to: 0)       // Sets initial option
        
        
        super.init()
        
        // Adds nodes as children
        addChild(title)
        addChild(done)
        
        addChild(modeLabel)
        addChild(modeSett)
        
        addChild(rofLabel)
        addChild(rofSett)
        
        addChild(diffLabel)
        addChild(diffSett)
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}



