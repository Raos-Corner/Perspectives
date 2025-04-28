//
//  StandardTextField.swift
//  Neatia
//
//  Created by Ritesh Pakala on 4/24/25.
//

import SwiftUI

struct StandardTextField: View {
    
    @Binding var text: String
    var height: CGFloat = 30
    var padding: CGFloat = .layer3
    //TODO: pass into texttoolview
    var font: Font = .headline.bold()
    var placeholder: String = ""
    
    var alternateBackground: Bool = false
    var italic: Bool = false
    var backgroundColor: Color = Color.secondaryBackground
    
    var body: some View {
        Group {
            #if os(iOS)
            TextToolView(text: $text, kind: .standard(placeholder))
                .frame(height: height)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color.alternateBackground.opacity(0.3))
                )
            #else
            TextField(.init(placeholder), text: $text)
                .textFieldStyle(.plain)
                .italic(italic)
                //.correctionDisabled()
                .frame(height: height)
                .padding(.horizontal, padding)
                .font(font.bold())
                .background(
                    RoundedRectangle(cornerRadius: .layer4)
                        .foregroundColor(backgroundColor.opacity(0.3))
                )
            #endif
        }
    }
}
