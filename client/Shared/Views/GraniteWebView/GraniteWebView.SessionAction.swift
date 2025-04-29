//
//  GraniteWebView.SessionAction.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import Granite

public enum SessionAction: GraniteModel {
    case idle,
         load(String),
         loadHTML(String),
         reload,
         goBack,
         goForward,
         ignore
    
    public static func == (lhs: SessionAction, rhs: SessionAction) -> Bool {
        if case .idle = lhs,
           case .idle = rhs {
            return true
        }
        if case let .load(requestLHS) = lhs,
           case let .load(requestRHS) = rhs {
            return requestLHS == requestRHS
        }
        if case let .loadHTML(htmlLHS) = lhs,
           case let .loadHTML(htmlRHS) = rhs {
            return htmlLHS == htmlRHS
        }
        if case .reload = lhs,
           case .reload = rhs {
            return true
        }
        if case .goBack = lhs,
           case .goBack = rhs {
            return true
        }
        if case .goForward = lhs,
           case .goForward = rhs {
            return true
        }
        if case .ignore = lhs,
           case .ignore = rhs {
            return true
        }
        return false
    }
}
