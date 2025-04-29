//
//  Garden+Center.swift
//  Gita
//
//  Created by Ritesh Pakala Rao on 4/20/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Granite
import SwiftUI

extension Garden {
    struct Center: GraniteCenter {
        struct State: GraniteState {
        }
        
        @Store public var state: State
    }
}
