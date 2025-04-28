//
//  Garden+View.swift
//  Gita
//
//  Created by Ritesh Pakala Rao on 4/20/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Granite
import SwiftUI

extension Garden: View {
    public var view: some View {
        ZStack {
            GraniteWebView(action: $webViewAction,
                           state: $webViewState,
                           highlightedText: _state.highlightedText)
            
            
            
            HStack {
                VStack {
                    Spacer()
                    HStack {
                        StandardTextField(text: _state.urlText)
                        
                        Button {
                            let sanitized: String
                            // TODO: stronger sanitization logic
                            if state.urlText.hasPrefix("http://") || state.urlText.hasPrefix("https://") {
                                sanitized = state.urlText
                            } else {
                                sanitized = "https://\(state.urlText)"
                            }
                            webViewAction = .load(.init(url: .init(string: sanitized)!))
                        } label: {
                            Image(systemName: "arrow.forward")
                                .font(.title2.bold())
                                .aspectRatio(.init(1, 1), contentMode: .fit)
                                .padding(.layer1 + 3)
                                .background {
                                    Color.secondaryBackground
                                        .cornerRadius(.layer4)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                    .background(Color.background.opacity(0.8).cornerRadius(.layer4))
                    .frame(maxHeight: 60)
                    .padding(.leading, .layer4)
                }
                Spacer()
                
                Research(baseLink: state.urlText,
                         input: _state.highlightedText)
            }
        }
        .onChange(of: state.highlightedText) { old, new in
            print("{TEST} n: \(new)")
        }
        .onAppear {
            webViewAction = .load(.init(url: .init(string: state.urlText)!))
        }
    }
}

//#Preview {
//    HStack {
//        StandardTextField(text: .constant("Hello"))
//        
//        Button {
//            
//        } label: {
//            Image(systemName: "arrow.forward")
//                .font(.title2.bold())
//                .aspectRatio(.init(1, 1), contentMode: .fit)
//                .padding(.layer1 + 3)
//                .background {
//                    Color.secondaryBackground
//                        .cornerRadius(.layer4)
//                }
//        }
//        .buttonStyle(.plain)
//    }
//    .frame(maxHeight: 60)
//}
