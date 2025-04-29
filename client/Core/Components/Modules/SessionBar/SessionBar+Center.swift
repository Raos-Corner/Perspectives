//
//  SessionBar+Center.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite
import SwiftUI

extension SessionBar {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            
        }
        
        @Store public var state: State
    }
}
