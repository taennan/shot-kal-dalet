//
//  ROFSetter.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 23/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import Foundation


// Controls SKTank's ROF
class ROFSetter: OptionSetter {
    
    init() { super.init(allOptions: ["0.1", "0.3", "0.6", "0.8", "1.0"], loopOptions: true) }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Runs code for current option
    override func activateOpt() {
        
        switch optLabel.text {
        case "0.1":
            skTank.rof = 0.1
        case "0.3":
            skTank.rof = 0.3
        case "0.6":
            skTank.rof = 0.6
        case "0.8":
            skTank.rof = 0.8
        case "1.0":
            skTank.rof = 1
            
        default:
            return
        }
    }
    
    
}
