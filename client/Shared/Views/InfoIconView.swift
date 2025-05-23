//
//  InfoIconView.swift
//  Stoic
//
//  Created by Ritesh Pakala Rao on 4/30/23.
//

import Foundation
import SwiftUI
import GraniteUI

struct InfoIconView: View {
    var text: LocalizedStringKey
    var body: some View {
        //TODO: modal bug with macOS (maxHeight)
        VStack {
            Text("i")
                .font(.caption2.bold())
                .foregroundColor(.foreground)
                .background(Circle().strokeBorder(.foreground, lineWidth: 1).frame(width: 16, height: 16))
        }
        .onTapGesture {
            GraniteHaptic.light.invoke()
            ModalService.shared.presentModal(GraniteAlertView(message: text) {
                
                GraniteAlertAction(title: "done")
            })
        }
    }
}

extension View {
    func addInfoIcon(text: String, spacing: CGFloat = .layer4, direction: HorizontalAlignment = .trailing ) -> some View {
        HStack(spacing: spacing) {
            if direction == .leading {
                InfoIconView(text: .init(text))
            }
            self
            if direction == .trailing {
                InfoIconView(text: .init(text))
            }
        }
    }
    func addInfoIconIf(_ condition: Bool, text: String, spacing: CGFloat = .layer4, direction: HorizontalAlignment = .trailing ) -> some View {
        Group {
            if condition {
                self.addInfoIcon(text: text, spacing: spacing, direction: direction)
            } else {
                self
            }
        }
    }
}
