//
//  Compile+Center.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/27/25.
//  
//

import Granite
import SwiftUI

extension Compile {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var result: String = ""
        }
        
        @Event var generate: Generate.Reducer
        @Event var reset: Reset.Reducer
        
        @Store public var state: State
    }
}
