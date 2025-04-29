//
//  CustomWebView.swift
//  Perspectives
//
//  Created by Ritesh Pakala on 4/28/25.
//

import WebKit

// MARK: WebView No Scrollbar

final class CustomWebView: WKWebView {
    private var originalWidth: CGFloat = 0
    private let extraWidth: CGFloat = 16 // Width to extend
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        
        // Set up clipping for the view
        self.wantsLayer = true
        self.layer?.masksToBounds = true
        
        // Apply extended frame
        originalWidth = frame.width
        var extendedFrame = frame
        extendedFrame.size.width += extraWidth
        super.frame = extendedFrame
        
        // Make sure parent view handles clipping
        if let superview = superview {
            superview.wantsLayer = true
            superview.layer?.masksToBounds = true
        }
    }
    
    override var frame: NSRect {
        get {
            return super.frame
        }
        set {
            // Store the original width
            originalWidth = newValue.width
            
            // Extend the frame to the right to push scrollbar off-screen
            var extendedFrame = newValue
            extendedFrame.size.width += extraWidth
            super.frame = extendedFrame
        }
    }
    
    override func layout() {
        super.layout()
        
        // Make sure our frame is still extended
        var currentFrame = super.frame
        if currentFrame.width == originalWidth {
            currentFrame.size.width += extraWidth
            super.frame = currentFrame
        }
        
        // Apply the extension to subviews as well
        for subview in subviews {
            var frame = subview.frame
            frame.size.width = currentFrame.width
            subview.frame = frame
        }
        
        // Ensure our frame remains extended
        // and all scroll views within have transparent backgrounds
        self.layer?.masksToBounds = true
        // Does not work
        // findAndCustomizeScrollViews(in: self)
    }
    
    private func findAndCustomizeScrollViews(in view: NSView) {
        for subview in view.subviews {
            if let scrollView = subview as? NSScrollView {
                // Make scroll view background transparent
                scrollView.drawsBackground = false
                
                // Create a mask to clip the scrollbar
                if scrollView.wantsLayer == false {
                    scrollView.wantsLayer = true
                }
                
                scrollView.layer?.masksToBounds = true
                
                // Limit the scroll view width to hide scrollbar
                let maskLayer = CALayer()
                maskLayer.frame = NSRect(
                    x: 0,
                    y: 0,
                    width: originalWidth, // Only show original width
                    height: scrollView.frame.height
                )
                maskLayer.backgroundColor = NSColor.black.cgColor
                scrollView.layer?.mask = maskLayer
            }
            
            // Continue recursive search
            findAndCustomizeScrollViews(in: subview)
        }
    }
    
    // Handle window resize events
    override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()
        
        // Reapply our extension
        var currentFrame = frame
        currentFrame.size.width = originalWidth + extraWidth
        super.frame = currentFrame
    }
}
