//
//  SessionService+Center.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite
import SwiftUI

extension SessionService {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var action: SessionAction = .idle
            var sessionStates: [WebViewState] = [.empty]
            var currentSessionIndex: Int = 0
            var currentSession: WebViewState {
                get {
                    return sessionStates[currentSessionIndex]
                }
                set {
                    sessionStates[currentSessionIndex] = newValue
                }
            }
        }
        
        @Store(persist: "sessions.persistence.0004",
               autoSave: true) public var state: State
    }
    
    func update(_ state: WebViewState) {
        _state.wrappedValue.sessionStates[center.state.currentSessionIndex] = state
    }
    
    func getState() -> WebViewState {
        center.state.sessionStates[center.state.currentSessionIndex]
    }
    
    func goBack() {
        _state.wrappedValue.action = .goBack
    }
    
    func goForward() {
        _state.wrappedValue.action = .goForward
    }
    
    func addSession() {
        _state.wrappedValue.sessionStates
            .append(
                .init(
                    isLoading: false,
                    canGoBack: true,
                    canGoForward: true
                )
            )
        _state.wrappedValue.currentSessionIndex = state.currentSessionIndex + 1
    }
    
    func load(_ state: WebViewState) {
        if let index = self.state.sessionStates.firstIndex(where: { $0.id == state.id }) {
            _state.currentSessionIndex.wrappedValue = index
        }
        
        guard let linkString = state.pageURL else {
            return
        }
        self.load(linkString)
    }
    
    // Since the action is bound the webview, this should trigger an updateNSView and
    // begin the new session / restoration process
    func load(_ linkString: String) {
        let sanitized: String
        // TODO: stronger sanitization logic
        if linkString.hasPrefix("http://") || linkString.hasPrefix("https://") {
            sanitized = linkString
        } else {
            sanitized = "https://\(linkString)"
        }
        
        _state.wrappedValue.action = .load(sanitized)
    }
}
