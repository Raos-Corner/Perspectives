//
//  Research.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/27/25.
//  
//

import Granite
import SwiftUI

struct Research: GraniteComponent {
    @Command var center: Center
    @Relay var service: AnnotationService
    @Relay var environment: EnvironmentService
    @Relay var session: SessionService
    
    var isPopout: Bool = false
}
