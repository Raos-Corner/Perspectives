//
//  EnvironmentService.Popout.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import Foundation
import Granite

extension EnvironmentService {
    struct Popout: GraniteReducer {
        typealias Center = EnvironmentService.Center
        
        func reduce(state: inout Center.State) {
            state.researchPane?.toggleWindow()
            state.researchPane?.bringToFront()
        }
    }
}
