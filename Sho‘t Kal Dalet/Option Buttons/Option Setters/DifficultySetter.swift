//
//  DifficultySetter.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 23/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import Foundation


// Controls difficulty setting
class DifficultySetter: OptionSetter {
    
    init() { super.init(allOptions: ["Increasing", "Easy", "Medium", "Hard"], loopOptions: false) }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Runs code for current option
    override func activateOpt() {
        
        switch optLabel.text {
        case "Increasing":
            gL.spawnFrequency = 2.5   // This one is broken. Fix later
            difficulty = .increasing
        case "Easy":
            gL.spawnFrequency = 2.3
            difficulty = .easy
        case "Medium":
            gL.spawnFrequency = 1.9
            difficulty = .medium
        case "Hard":
            
            fallthrough
        default:
            gL.spawnFrequency = 1.5
            difficulty = .hard
            
        }
        
    }
    
    
}
