//
//  NodeGraphView.swift
//  Stoic
//
//  Created by Ritesh Pakala on 4/12/25.
//

import SwiftUI

struct Node: Identifiable {
    let id = UUID()
    let name: String
    let position: CGPoint
}

struct NodeView: View {
    var body: some View {
        Circle()
            .frame(width: 48, height: 48)
            .foregroundColor(Color.blue)
    }
}

struct NodeGraphView: View {
    var body: some View {
        ZStack {
            NodeView()
        }
    }
}

#Preview {
    NodeGraphView()
}
