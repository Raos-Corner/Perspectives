//
//  AnnotationModel.swift
//  Perspectives (iOS)
//
//  Created by Ritesh Pakala on 4/27/25.
//

import Foundation
import Granite

struct AnnotationModel: GraniteModel, Identifiable {
    var id: UUID = UUID()
    var topic: String
    var annotation: String
}
