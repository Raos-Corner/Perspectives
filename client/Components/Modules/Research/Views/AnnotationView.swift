//
//  AnnotationView.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/27/25.
//

import SwiftUI
import Granite

struct AnnotationView: View {
    @GraniteAction<AnnotationModel> var modified
    @GraniteAction<AnnotationModel> var didRemove
    
    @State
    var model: AnnotationModel
    
    @State
    var edited: Bool = false
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: .layer1) {
                    StandardTextField(text: $model.topic,
                                      height: 20,
                                      padding: .layer1,
                                      backgroundColor: .clear)
                    .allowsHitTesting(false)
                    StandardTextField(text: $model.annotation,
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
            
            if edited {
                Button {
                    modified.perform(model)
                    edited = false
                } label: {
                    Image(systemName: "sdcard")
                        .font(.title3.bold())
                }
                .contentShape(Rectangle())
                .buttonStyle(.plain)
            }
            
            Button {
                didRemove.perform(model)
            } label: {
                Image(systemName: "minus.square")
                    .font(.title2.bold())
            }
            .contentShape(Rectangle())
            .buttonStyle(.plain)
        }
        .padding(.layer4)
        .background(
            RoundedRectangle(cornerRadius: .layer4)
                .foregroundColor(Color.secondaryBackground.opacity(0.3))
        )
        .onChange(of: model) { _, new in
            edited = true
        }
    }
}
//
//#Preview {
//    AnnotationView(model: .init(topic: "highlight", annotation: "Test annotation"))
//}
