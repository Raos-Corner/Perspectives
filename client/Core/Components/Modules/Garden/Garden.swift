//
//  Garden.swift
//  Gita
//
//  Created by Ritesh Pakala Rao on 4/20/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Granite
import SwiftUI

struct Garden: GraniteComponent {
    @Command var center: Center
    
    @Relay var service: SessionService
}
