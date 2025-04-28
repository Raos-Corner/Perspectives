//
//  PEXApp.swift
//  Shared
//
//  Created by Ritesh Pakala Rao on 7/18/22.
//

import SwiftUI
import Granite

@main
struct PEXApp: App {
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #elseif os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    @Relay var environment: EnvironmentService
    
    let pubDidFinishLaunching = NotificationCenter.default
            .publisher(for: NSNotification.Name("nyc.stoic.Bullish.DidFinishLaunching"))
    
    init() {
        #if os(macOS)
        GraniteNavigationWindow.backgroundColor = NSColor(Color.black)
        #endif
        
        environment.center.boot.send()
        
        //TODO: DEV
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            InteractionManager.shared.observeHotkey(kind: .mount)
        }
    }
    
    var body: some Scene {
//        #if os(iOS)
//        WindowGroup {
//            Home()
//                .preferredColorScheme(.dark)
//        }
//        #elseif os(macOS)
//        WindowComponent(backgroundColor: Color.clear) {
//            Home()
//                .background(Brand.Colors.black)
//        }
//        #endif
        WindowGroup {
            Home()
                .preferredColorScheme(.dark)
        }
    }
}
struct EmptyComponent: GraniteComponent {
    struct Center: GraniteCenter {
        
        struct State: GraniteState {
            
        }
        
        @Store var state: State
    }
    
    @Command var center: Center
}

extension EmptyComponent: View {
    var view: some View {
        ZStack {
            Text("Bullish")
        }
    }
}
