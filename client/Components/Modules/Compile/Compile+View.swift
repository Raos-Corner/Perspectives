//
//  Compile+View.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/27/25.
//  
//

import Granite
import SwiftUI
import SandKit

extension Compile: View {
    public var view: some View {
        VStack {
            if state.result.isNotEmpty || service.state.latestSummary.isNotEmpty {
                
                Markdown(content: service._state.latestSummary)
//                
//                StandardTextView(text: service._state.latestSummary)
            }
            
            Button {
                center.generate.send()
            } label: {
                Image(systemName: "greetingcard.fill")
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .padding(.top, .layer2)
            .padding(.bottom, .layer4)
        }
    }
}
