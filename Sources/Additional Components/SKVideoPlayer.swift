//
//  IfModifier.swift
//  SymbolPicker
//
//  Created by Kamil Szpak on 11/04/2025.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
import AVKit
internal import UIKit

// MARK: - iOS / tvOS / visionOS Implementation
struct SKPlayerView: UIViewRepresentable {
    @Binding var player: AVPlayer
    
    func makeUIView(context: Context) -> PlayerView {
        PlayerView(player: player)
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) {
        uiView.playerLayer.player = player
    }
    
    init(player: Binding<AVPlayer>) {
        self._player = player
    }
}

final class PlayerView: UIView {
    override class var layerClass: AnyClass { AVPlayerLayer.self }
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        commonInit()
        playerLayer.player = player
    }
    
    private func commonInit() {
        backgroundColor = .clear
        // Configure audio session to duck others and allow playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set AVAudioSession category: \(error)")
        }
    }
}

#elseif os(macOS)
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
