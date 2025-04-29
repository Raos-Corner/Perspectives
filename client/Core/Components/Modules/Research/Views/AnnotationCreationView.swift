//
//  AnnotationView.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/27/25.
//

import SwiftUI
import Granite

struct AnnotationCreationView: View {
    @GraniteAction<AnnotationModel> var annotated
    
    var baseLink: String
    
    @Binding
    var highlighted: String
    @State
    var input: String = ""
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: .layer1) {
                    StandardTextField(text: $highlighted,
                                      height: 20,
                                      padding: .layer1,
                                      backgroundColor: .clear)
                    .allowsHitTesting(false)
                    StandardTextField(text: $input,
                                      height: 15,
                                      padding: .layer1,
                                      font: .subheadline,
                                      placeholder: "annotation",
                                      italic: true,
                                      backgroundColor: .clear)
                    .opacity(0.8)
                }
            }
            
            Spacer()
            
            Button {
                annotated.perform(.init(topic: highlighted, annotation: input, link: baseLink))
                input = ""
            } label: {
                Image(systemName: "plus.app")
                    .font(.title2)
            }
            .contentShape(Rectangle())
            .buttonStyle(.plain)
        }
        .padding(.layer4)
        .background(
            RoundedRectangle(cornerRadius: .layer4)
                .foregroundColor(Color.secondaryBackground.opacity(0.3))
        )
        
    }
}

