//
//  SessionBar+View.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite
import SwiftUI

extension SessionBar: View {
    public var view: some View {
        HStack(spacing: .layer2) {
            Spacer()
                .frame(width: 68)
            
            ForEach(service.state.sessionStates) { state in
                tabButton(state)
            }
            
            Button {
                service.addSession()
            } label: {
                Image(systemName: "plus.square.fill")
                    .font(.title3.bold())
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: WindowComponent.Style.defaultTitleBarHeight + .layer1)
        .padding(.top, -1)
        .background(Color.background)
    }
    
    func tabButton(_ state: WebViewState) -> some View {
        Button {
            service.load(state)
        } label: {
            Image(systemName: "square\(state.id == service.state.currentSession.id ? ".fill" : "")")
                .font(.title3.bold())
        }
        .buttonStyle(.plain)
    }
}
