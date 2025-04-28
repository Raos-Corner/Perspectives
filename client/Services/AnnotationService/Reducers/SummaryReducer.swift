//
//  SummaryReducer.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/27/25.
//

import Granite
import SandKit

extension AnnotationService {
    struct Reset: GraniteReducer {
        typealias Center = AnnotationService.Center
        
        func reduce(state: inout Center.State) {
            state.latestSummary = ""
        }
    }
    
    struct Result: GraniteReducer {
        typealias Center = AnnotationService.Center
        
        struct Meta: GranitePayload {
            var output: String
        }
        
        @Payload var meta: Meta?
        
        func reduce(state: inout Center.State) {
            guard let meta else { return }
            state.latestSummary = meta.output
        }
    }
}
