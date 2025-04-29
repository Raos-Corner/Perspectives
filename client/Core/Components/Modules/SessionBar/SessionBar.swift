//
//  SessionBar.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite

struct SessionBar: GraniteComponent {
    @Command var center: Center
    
    @Relay var service: SessionService
}
