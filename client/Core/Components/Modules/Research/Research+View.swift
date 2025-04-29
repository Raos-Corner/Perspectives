//
//  Research+View.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/27/25.
//  
//

import Foundation
import Granite
import SwiftUI

extension Research: View {
    public var view: some View {
        HStack(spacing: 0) {
            if isPopout == false {
                VStack {
                    if state.isPoppedOut == false {
                        Button {
                            _state.isVisible.wrappedValue.toggle()
                        } label: {
                            Image(systemName: "arrow.\(state.isVisible ? "forward" : "backward").square")
                                .font(.title2)
                        }
                        .contentShape(Rectangle())
                        .padding(.layer2)
                        .background {
                            Color.background
                                .cornerRadius(.layer2)
                        }
                        .buttonStyle(.plain)
                        .padding(state.isVisible ? 0 : .layer4)
                    }
                    
                    Spacer()
                    
                    Button {
                        environment.center.popout.send()
                        _state.wrappedValue.isPoppedOut.toggle()
                    } label: {
                        Image(systemName: state.isPoppedOut ? "square.fill.on.square.fill" : "square.on.square")
                            .font(.title2)
                    }
                    .contentShape(Rectangle())
                    .padding(.layer2)
                    .background {
                        Color.background
                            .cornerRadius(.layer2)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, .layer4)
                .padding(.trailing, state.isPoppedOut ? .layer4 : 0)
            }
            
            if state.isVisible && state.isPoppedOut == false {
                VStack(spacing: .layer2) {
                    Spacer()
                        .frame(height: isPopout ? WindowComponent.Style.defaultTitleBarHeight + .layer2 : 0)
                    
                    let baseLink = session.getState().pageURL ?? ""
                    if service.state.input.isNotEmpty {
                        AnnotationCreationView(baseLink: baseLink, highlighted: service._state.input)
                            .attach({ model in
                                service._state.annotations.wrappedValue[model.id] = model
                                service._state.wrappedValue.input = ""
                            }, at: \.annotated)
                        
                        PaddingVertical()
                    }
                    
                    annotationList
                    
                    if service.state.annotations.isNotEmpty {
                        PaddingVertical()
                        
                        Compile()
                    }
                }
                .frame(maxWidth: isPopout ? .infinity : 300,
                       maxHeight: .infinity)
                .background {
                    Color
                        .secondaryBackground
                        .cornerRadius(isPopout ? 0 : .layer4)
                }
                .padding(isPopout ? 0 : .layer4)
                .transition(.move(edge: state.isVisible ? .trailing : .leading))
            }
        }
        .animation(.interactiveSpring, value: state.isVisible)
        .frame(minWidth: isPopout ? 400 : nil, minHeight: isPopout ? 600 : nil)
        .ignoreSafeAreaIf(isPopout)
    }
    
    var annotationList: some View {
        ScrollView {
            VStack {
                ForEach(Array(service.state.annotations.values)) { model in
                    AnnotationView(model: model)
                        .attach({ modified in
                            service._state.annotations.wrappedValue[modified.id] = modified
                        }, at: \.modified)
                        .attach({ model in
                            service._state.annotations.wrappedValue.removeValue(forKey: model.id)
                        }, at: \.didRemove)
                }
            }
        }
    }
}
