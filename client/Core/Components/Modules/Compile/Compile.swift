//
//  Compile.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/27/25.
//  
//

import Granite
import SandKit

struct Compile: GraniteComponent {
    @Command var center: Center
    
    @Relay var service: AnnotationService
    
    static var kit = SandKit()
}
