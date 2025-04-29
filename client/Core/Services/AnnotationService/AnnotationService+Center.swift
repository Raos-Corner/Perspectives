//
//  AnnotationService+Center.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/27/25.
//  
//

import Granite
import SwiftUI

extension AnnotationService {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var annotations: [UUID: AnnotationModel] = [:]
            var latestSummary: String = ""
            
            var baseLink: String = ""
            var input: String = ""
        }
        
        @Event var reset: Reset.Reducer
        @Event var result: Result.Reducer
        
        @Store(persist: "annotations.persistence.0000", autoSave: true) public var state: State
    }
}
