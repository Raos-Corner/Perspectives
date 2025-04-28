//
//  Session+Center.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite
import SwiftUI

extension Session {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var highlightedText: String = ""
            var urlText: String = "https://google.com"
        }
        
        @Store public var state: State
    }
}
