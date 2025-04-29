//
//  GraniteWebView.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import SwiftUI
import Foundation
import WebKit
import Granite

#if os(iOS)
public struct GraniteWebView: UIViewRepresentable {
    let config: WebViewConfig
    @Binding var action: WebViewAction
    @Binding var state: WebViewState
    let restrictedPages: [String]?
    let htmlInState: Bool
    let schemeHandlers: [String: (URL) -> Void]
    
    public init(config: WebViewConfig = .default,
                action: Binding<WebViewAction>,
                state: Binding<WebViewState>,
                restrictedPages: [String]? = nil,
                htmlInState: Bool = false,
                schemeHandlers: [String: (URL) -> Void] = [:]) {
        self.config = config
        _action = action
        _state = state
        self.restrictedPages = restrictedPages
        self.htmlInState = htmlInState
        self.schemeHandlers = schemeHandlers
    }
    
    public func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(webView: self)
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = config.javaScriptEnabled
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = config.allowsInlineMediaPlayback
        configuration.mediaTypesRequiringUserActionForPlayback = config.mediaTypesRequiringUserActionForPlayback
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = config.allowsBackForwardNavigationGestures
        webView.scrollView.isScrollEnabled = config.isScrollEnabled
        webView.isOpaque = config.isOpaque
        if #available(iOS 14.0, *) {
            webView.backgroundColor = UIColor(config.backgroundColor)
        } else {
            webView.backgroundColor = .clear
        }
        
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        if action == .idle || context.coordinator.actionInProgress {
            return
        }
        context.coordinator.actionInProgress = true
        switch action {
        case .idle:
            break
        case .load(let request):
            uiView.load(request)
        case .loadHTML(let pageHTML):
            uiView.loadHTMLString(pageHTML, baseURL: nil)
        case .reload:
            uiView.reload()
        case .goBack:
            uiView.goBack()
        case .goForward:
            uiView.goForward()
        case .evaluateJS(let command, let callback):
            uiView.evaluateJavaScript(command) { result, error in
                if let error = error {
                    callback(.failure(error))
                } else {
                    callback(.success(result))
                }
            }
        }
    }
}
#endif

#if os(macOS)
public struct GraniteWebView: NSViewRepresentable {
    let config: WebViewConfig
    @Binding var remote: WebViewAction
    @Binding var action: SessionAction
    @Binding var state: WebViewState
    @Binding var highlightedText: String
    let restrictedPages: [String]?
    let htmlInState: Bool
    let schemeHandlers: [String: (URL) -> Void]
    
    public init(config: WebViewConfig = .default,
                remote: Binding<WebViewAction>,
                action: Binding<SessionAction> = .constant(.ignore),
                state: Binding<WebViewState>,
                highlightedText: Binding<String>,
                restrictedPages: [String]? = nil,
                htmlInState: Bool = false,
                schemeHandlers: [String: (URL) -> Void] = [:]) {
        self.config = config
        _remote = remote
        _action = action
        _state = state
        _highlightedText = highlightedText
        self.restrictedPages = restrictedPages
        self.htmlInState = htmlInState
        self.schemeHandlers = schemeHandlers
    }
    
    public func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(webView: self)
    }
    
    public func makeNSView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = config.javaScriptEnabled
        
        let contentController = WKUserContentController()
        let userScript = WKUserScript(
            source: """
            document.addEventListener('mouseup', function() {
                var selectedText = window.getSelection().toString();
                if (selectedText) {
                    window.webkit.messageHandlers.highlightedTextHandler.postMessage(selectedText);
                }
            });
            """,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.add(context.coordinator, name: "highlightedTextHandler")
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController
        
        let webView = CustomWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = config.allowsBackForwardNavigationGestures
        
        // TODO: more comprehensive state restoration system
        if let linkString = state.pageURL,
           let url = URL(string: linkString) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    public func updateNSView(_ uiView: WKWebView, context: Context) {
        switch action {
        case .idle:
            return
        case .ignore:
            break
        case .load(let linkString):
            if let url = URL(string: linkString) {
                uiView.load(URLRequest(url: url))
            }
        case .loadHTML(let html):
            uiView.loadHTMLString(html, baseURL: nil)
        case .reload:
            uiView.reload()
        case .goBack:
            uiView.goBack()
        case .goForward:
            uiView.goForward()
        }
        
        switch remote {
        case .idle:
            return
        case .load(let request):
            uiView.load(request)
        case .loadHTML(let html):
            uiView.loadHTMLString(html, baseURL: nil)
        case .reload:
            uiView.reload()
        case .goBack:
            uiView.goBack()
        case .goForward:
            uiView.goForward()
        case .evaluateJS(let command, let callback):
            uiView.evaluateJavaScript(command) { result, error in
                if let error = error {
                    callback(.failure(error))
                } else {
                    callback(.success(result))
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            action = .idle
            remote = .idle
        }
    }
}
#endif
