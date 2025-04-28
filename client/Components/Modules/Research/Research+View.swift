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
        HStack(spacing: .layer2) {
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
                    .cornerRadius(.layer1)
            }
            .buttonStyle(.plain)
            .padding(state.isVisible ? 0 : .layer4)
            
            if state.isVisible {
                VStack(spacing: .layer2) {
                    if input.isNotEmpty {
                        AnnotationCreationView(highlighted: $input)
                            .attach({ model in
                                service._state.annotations.wrappedValue[model.id] = model
                                input = ""
                            }, at: \.annotated)
                        
                        PaddingVertical()
                    }
                    
                    annotationList
                    
                    if service.state.annotations.isNotEmpty {
                        PaddingVertical()
                        
                        Compile()
                    }
                }
                .frame(maxWidth: 300,
                       maxHeight: .infinity)
                .background {
                    Color
                        .secondaryBackground
                        .cornerRadius(.layer4)
                }
                .padding(.layer4)
                .transition(.move(edge: state.isVisible ? .trailing : .leading))
            }
        }
        .animation(.interactiveSpring, value: state.isVisible)
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
                            service._state.annotations.wrappedValue[model.id] = nil
                        }, at: \.didRemove)
                }
            }
        }
    }
}
