//
//  Research+Center.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/27/25.
//  
//

import Granite
import SwiftUI

extension Research {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var isVisible: Bool = true
        }
        
        @Store public var state: State
    }
}
