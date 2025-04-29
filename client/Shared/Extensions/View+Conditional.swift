//
//  View+Conditional.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func ignoreSafeAreaIf(_ cond: Bool) -> some View {
        if cond {
            self.ignoresSafeArea()
        } else {
            self
        }
    }
}
