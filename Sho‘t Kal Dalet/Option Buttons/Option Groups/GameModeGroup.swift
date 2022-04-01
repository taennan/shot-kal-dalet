//
//  GameModeGroup.swift
//  Shot Kal Dalet
//
//  Created by Taennan Rickman on 28/10/20.
//  Copyright © 2020 Taennan Rickman. All rights reserved.
//

import SpriteKit


// Controls game mode
class GameModeGroup: OptionGroup {
    
    init() { super.init(initialOption: 0, buttonSpacing: 175, buttonSize: 50, orientation: .horizontal) }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // Activates selected option
    override func activateOption() {
        
        switch optArray[currentOpt].text {
        case "Day":
            print("Game mode changed to: DAY")
        case "Night":
            print("Game mode changed to: NIGHT")
        case "TEST":
            print("Game mode changed to: TEST")
            
        default:
            return
        }
        
    }
    
}
