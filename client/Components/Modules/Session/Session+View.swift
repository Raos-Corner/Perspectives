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
            GraniteWebView(action: $webViewAction,
                           state: $webViewState,
                           highlightedText: _state.highlightedText)
            
            HStack {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            webViewAction = .load(.init(url: .init(string: "https://google.com")!))
                        } label: {
                            Image(systemName: "house")
                                .font(.title3.bold())
                                .aspectRatio(.init(1, 1), contentMode: .fit)
                                .padding(.layer1 + 3)
                                .background {
                                    Color.secondaryBackground
                                        .cornerRadius(.layer4)
                                }
                        }
                        .buttonStyle(.plain)
                        
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
                    .frame(maxWidth: 400, maxHeight: 60)
                    .padding(.leading, .layer4)
                }
                Spacer()
                
                Research(baseLink: state.urlText,
                         input: _state.highlightedText)
            }
        }
        .onAppear {
            webViewAction = .load(.init(url: .init(string: state.urlText)!))
        }
    }
}
