//
//  GraniteWebView.State.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import Foundation
import Granite

public struct WebViewState: GraniteModel, Identifiable {
    public var id: UUID = UUID()
    public internal(set) var isLoading: Bool
    public internal(set) var pageURL: String?
    public internal(set) var pageTitle: String?
    public internal(set) var pageHTML: String?
    public internal(set) var error: String?
    public internal(set) var canGoBack: Bool
    public internal(set) var canGoForward: Bool
    
    public static let empty = WebViewState(isLoading: false,
                                           pageURL: nil,
                                           pageTitle: nil,
                                           pageHTML: nil,
                                           error: nil,
                                           canGoBack: true,
                                           canGoForward: true)
    
    public static func == (lhs: WebViewState, rhs: WebViewState) -> Bool {
        lhs.isLoading == rhs.isLoading
            && lhs.pageURL == rhs.pageURL
            && lhs.pageTitle == rhs.pageTitle
            && lhs.pageHTML == rhs.pageHTML
            && lhs.error == rhs.error
            && lhs.canGoBack == rhs.canGoBack
            && lhs.canGoForward == rhs.canGoForward
    }
}
