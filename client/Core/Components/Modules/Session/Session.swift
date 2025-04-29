//
//  Session.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite
import SwiftUI

struct Session: GraniteComponent {
    @Command var center: Center
    
    @Relay var service: SessionService
    @Relay var annotation: AnnotationService
    
    @State
    var webViewAction: WebViewAction = .idle
}
