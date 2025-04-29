//
//  GraniteWebView.Action.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import Foundation

public enum WebViewAction: Equatable {
    case idle,
         load(URLRequest),
         loadHTML(String),
         reload,
         goBack,
         goForward,
         evaluateJS(String, (Result<Any?, Error>) -> Void)
    
    public static func == (lhs: WebViewAction, rhs: WebViewAction) -> Bool {
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
        if case let .evaluateJS(commandLHS, _) = lhs,
           case let .evaluateJS(commandRHS, _) = rhs {
            return commandLHS == commandRHS
        }
        return false
    }
}
