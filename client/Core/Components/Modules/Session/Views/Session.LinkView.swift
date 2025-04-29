//
//  Session.LinkView.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import Foundation
import SwiftUI

extension Session {
    
    var linkView: some View {
        HStack {
            HStack(spacing: .layer1) {
                Button {
                    service.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3.bold())
                        .aspectRatio(.init(1, 1), contentMode: .fit)
                        .padding(.layer1)
//                                .background {
//                                    Color.secondaryBackground
//                                        .cornerRadius(.layer4)
//                                }
                }
                .buttonStyle(.plain)
                .padding(.leading, .layer2)
                
                Button {
                    service.load("https://google.com")
                } label: {
                    Image(systemName: "house")
                        .font(.title3.bold())
                        .aspectRatio(.init(1, 1), contentMode: .fit)
                        .padding(.layer1 + 3)
                }
                .buttonStyle(.plain)
                
                Button {
                    service.goForward()
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3.bold())
                        .aspectRatio(.init(1, 1), contentMode: .fit)
                        .padding(.layer1)
//                                .background {
//                                    Color.secondaryBackground
//                                        .cornerRadius(.layer4)
//                                }
                }
                .buttonStyle(.plain)
                .padding(.trailing, .layer2)
            }
            .background {
                Color.secondaryBackground
                    .cornerRadius(.layer4)
            }
            
            StandardTextField(text: _state.linkString)
            
            Button {
                service.load(state.linkString)
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
        //.background(Color.background.opacity(0.8).cornerRadius(.layer4))
        .frame(maxWidth: 400, maxHeight: 60)
        .padding(.leading, .layer4)
    }
}
