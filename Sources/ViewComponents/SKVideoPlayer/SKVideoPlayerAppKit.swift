//
//  SKVideoPlayerAppKit.swift
//  SymbolPicker
//
//  Created by Kamil Szpak on 11/04/2025.
//

#if os(macOS)
import AVKit
import AppKit
import SwiftUI

// MARK: - macOS Implementation Using AVPlayerLayer
struct SKPlayerView: NSViewRepresentable {
    @Binding var player: AVPlayer
    
    func makeNSView(context: Context) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.clear.cgColor
        
        // Create and configure AVPlayerLayer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = containerView.bounds
        playerLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        playerLayer.backgroundColor = NSColor.clear.cgColor
        
        containerView.layer?.addSublayer(playerLayer)
        return containerView
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        if let playerLayer = nsView.layer?.sublayers?.first as? AVPlayerLayer {
            playerLayer.player = player
        }
    }
    
    init(player: Binding<AVPlayer>) {
        self._player = player
    }
}


#endif
