//
//  Garden+View.swift
//  Gita
//
//  Created by Ritesh Pakala Rao on 4/20/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Granite
import SwiftUI

extension Garden: View {
    public var view: some View {
        VStack(spacing: 0) {
            // Tab and Toolbar
            Color.background
                .frame(maxWidth: .infinity)
                .frame(height: 36)
            
            Session()
        }
    }
}

//#Preview {
//    HStack {
//        StandardTextField(text: .constant("Hello"))
//        
//        Button {
//            
//        } label: {
//            Image(systemName: "arrow.forward")
//                .font(.title2.bold())
//                .aspectRatio(.init(1, 1), contentMode: .fit)
//                .padding(.layer1 + 3)
//                .background {
//                    Color.secondaryBackground
//                        .cornerRadius(.layer4)
//                }
//        }
//        .buttonStyle(.plain)
//    }
//    .frame(maxHeight: 60)
//}
