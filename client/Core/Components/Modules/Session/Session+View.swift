//
//  Session+View.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite
import SwiftUI

extension Session: View {
    public var view: some View {
        ZStack {
            GraniteWebView(remote: $webViewAction,
                           action: service._state.action,
                           state: service._state.currentSession,
                           highlightedText: annotation._state.input)
            
            HStack {
                VStack {
                    Spacer()
                    
                    linkView
                }
                
                Spacer()
                
                Research()
            }
        }
        .onChange(of: service.state.currentSessionIndex) {
            updateLinkString()
        }
        .task {
            updateLinkString()
        }
    }
}
