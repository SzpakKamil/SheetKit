//
//  SKVideoPage.swift
//  SheetKit
//
//  Created by Kamil Szpak on 02/10/2025.
//
#if os(iOS)
import SwiftUI
import AVKit
import TabKit

public struct SKVideoPage: SKPageable, View {
    @Environment(\.skDismissButtonAction) var skDismissButtonAction
    @Environment(\.skPrimaryButtonAction) var skPrimaryButtonAction
    public var data: SKPage.Data
    public var adjustedContent: AnyView?
    @State private var defaultSelectedHighlightIndex: Int = 0
    @State private var showingTransitionBG = false
    @State private var player: AVPlayer
    @State private var isLoaded: Bool = false
    @State private var isLoadedCompletly: Bool = false
    let highlights: [SKVideoHighlight]
    
    public var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()

            Group{
                videoContent()
                    .frame(maxHeight: .infinity)
            }
            .if{ content in
                Group{
                    if #available(iOS 26.0, *){
                        content
#if compiler(>=6.2)
                            .safeAreaBar(edge: .bottom) {
                                data.toolbar
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 30)
                                    .opacity(isLoaded ? 1 : 0)
                                    .animation(.smooth(duration: 1.5).delay(0.4), value: isLoaded)
                            }
#endif
                    }else{
                        content
                            .safeAreaInset(edge: .bottom) {
                                data.toolbar
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 30)
                                    .frame(maxWidth: .infinity)
                                    .opacity(isLoaded ? 1 : 0)
                                    .animation(.smooth(duration: 1.5).delay(0.4), value: isLoaded)
                            }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
            let firstStartTime = highlights.first?.startTime?.seconds ?? 0
            if firstStartTime <= 0 {
                isLoaded = true
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + firstStartTime) {
                    isLoaded = true
                }
            }
        }
        .toolbar{
            if isLoaded{
                ToolbarItem(placement: .cancellationAction) {
                    SKToolbarItem(placement: .navigation, actionType: .dismiss) {
                        SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward"){}
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Skip") {
                        skPrimaryButtonAction()
                    }
                }
            }
        }
        .environment(\.skIsCloseButtonHidden, true)
        .environment(\.skPrimaryButtonAction){
            if defaultSelectedHighlightIndex >= highlights.count - 1{
                skPrimaryButtonAction()
            }else{
                defaultSelectedHighlightIndex += 1
            }
        }
        .environment(\.skDismissButtonAction){
            if defaultSelectedHighlightIndex <= 0{
                skDismissButtonAction()
            }else{
                defaultSelectedHighlightIndex -= 1
            }
        }
    }
    
    @ViewBuilder
    private func videoContent() -> some View{
        GeometryReader{ proxy in
            ZStack(alignment: .bottom){
                VideoPlayer(player: player)
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
                    .ignoresSafeArea()
                    .onChange(of: player.currentItem){
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main
                        ) { [weak player] _ in
                            player?.seek(to: .zero)
                            player?.play()
                        }
                        player.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
                        player.play()
                    }
                    .onAppear {
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main
                        ) { [weak player] _ in
                            player?.seek(to: .zero)
                            player?.play()
                        }
                        player.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
                        player.play()
                    }
                
                LinearGradient(
                    stops: [
                        .init(color: .black.opacity(0), location: 0),
                        .init(color: .black.opacity(0), location: 0.6),
                        .init(color: .black.opacity(1), location: 0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .opacity(isLoaded ? 1 : 0)
                .animation(.smooth(duration: 1.5).delay(0.2), value: isLoaded)
                Color.black
                    .opacity(showingTransitionBG ? 1 : 0)
                    .ignoresSafeArea()
                
                Group{
                    TKPagesView {
                        TKForEach(highlights.indices, id: \.self) { index in
                            let highlight = highlights[index]
                            TKPage {
                                highlight
                                    .updateGeoProxy(proxy: proxy)
                                    .setAutoStyle(index: index)
                                    .ignoresSafeArea()
                            }
                            .tkPageDuration(calculateDuration(for: index))
                        }
                    }
                    
                    .tkCurrentPageIndex(index: $defaultSelectedHighlightIndex)
                    .tkPageControlAlignment(spacing: 0, alignment: .bottom)
                    .tkPageControlAllowsContinuousInteraction(false)
                    .tkOnManualPageChange { performPageChangeSetup(isManual: true, previousIndex: $0, currentIndex: $1) }
                    .tkOnAutoPageChange { performPageChangeSetup(isManual: false, previousIndex: $0, currentIndex: $1) }
                }
                .offset(x: isLoaded ? 0 : -150)
                .opacity(isLoaded ? 1 : 0)
                .animation(.smooth(duration: 0.15), value: isLoaded)
            }
        }
    }
    private func performPageChangeSetup(isManual: Bool, previousIndex: Int, currentIndex: Int){
        let currentItem = highlights[currentIndex]
        let previousItem = highlights[previousIndex]
        let beforeItem = currentIndex == 0 ? nil : highlights[currentIndex - 1]
        
        let isMovingForward = currentIndex > previousIndex
        let isMovingBackward = currentIndex < previousIndex
        let shouldShowTransition: Bool = {
            if isManual{
                switch currentItem.transitionManualDirection {
                case .forward: return isMovingForward
                case .backward: return isMovingBackward
                case .both: return isMovingForward || isMovingBackward
                case .none: return false
                }
            }else{
                switch currentItem.transitionAutoDirection {
                case .forward: return isMovingForward
                case .backward: return isMovingBackward
                case .both: return isMovingForward || isMovingBackward
                case .none: return false
                }
            }
        }()
        if shouldShowTransition {
            withAnimation(.smooth(duration: 0.5)){
                showingTransitionBG = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (shouldShowTransition ? 0.4 : 0)){
            configuratePlayerLayer(previousItem: previousItem, currentItem: currentItem, beforeItem: beforeItem, isManual: isManual)
        }
        
        
        if shouldShowTransition {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                player.play()
            }
            Task{ @MainActor in
                try? await Task.sleep(nanoseconds: 700_000_000)
                withAnimation(.smooth(duration: 0.5)){
                    showingTransitionBG = false
                }
            }
        }else{
            player.play()
        }
    }
    
    private func configuratePlayerLayer(previousItem: SKVideoHighlight, currentItem: SKVideoHighlight, beforeItem: SKVideoHighlight?, isManual: Bool){
        let usesPreviousResource = beforeItem?.resource != nil && currentItem.resource == nil && !isManual
        if let previousResource = beforeItem?.resource, currentItem.resource == nil && isManual{
            player = AVPlayer(url: previousResource)
            player.pause()
        }else if let currentResource = currentItem.resource{
            player.pause()
            player = AVPlayer(url: currentResource)
        }
        
        if let index = highlights.firstIndex(of: currentItem), index == 0{
            player.seek(to: isLoaded ? currentItem.startTime ?? .zero : .zero)
            player.play()
        }else{
            if !usesPreviousResource{
                player.seek(to: currentItem.startTime ?? .zero)
                player.play()
            }
        }
    }
    
    private func calculateDuration(for index: Int) -> Double? {
        let highlight = highlights[index]
        guard !highlight.runIndefinitly else { return nil }
        let transitionTime = highlight.transitionAutoDirection != .none ? -0.5 : 0
        
        // Find the effective video for this highlight
        var effectiveResource: URL?
        var effectiveVideoDuration: Double?
        for i in (0...index).reversed() {
            if let resource = highlights[i].resource {
                effectiveResource = resource
                let asset = AVAsset(url: resource)
                let duration = asset.duration
                if duration.isValid && !duration.isIndefinite {
                    effectiveVideoDuration = duration.seconds
                }
                break
            }
        }
        
        if effectiveResource == nil {
            // Use main player if no resource found
            guard let videoDuration = player.currentItem?.asset.duration,
                  videoDuration.isValid, !videoDuration.isIndefinite else { return nil }
            effectiveVideoDuration = videoDuration.seconds
        }
        
        guard let videoDuration = effectiveVideoDuration else { return nil }
        
        // Get the start time in seconds, default to zero if nil or if has resource (ignore startTime for new resource)
        let startSeconds: Double
        if highlight.resource != nil && !isLoaded {
            startSeconds = 0 // Ignore startTime for highlights with resource
        } else {
            startSeconds = (highlight.startTime ?? .zero).seconds
        }
        guard !startSeconds.isNaN else { return nil }
        
        // If endTime is provided and valid, use it
        if let endTime = highlight.endTime, endTime.isValid, !endTime.isIndefinite {
            return endTime.seconds - startSeconds + transitionTime
        }
        
        // Check if there's a next highlight and if it's a continuation (no resource)
        let nextIndex = index + 1
        if nextIndex < highlights.count {
            let nextHighlight = highlights[nextIndex]
            if nextHighlight.resource == nil {
                let nextStartSeconds = (nextHighlight.startTime ?? .zero).seconds
                guard !nextStartSeconds.isNaN else { return nil }
                return nextStartSeconds - startSeconds
            }
        }
        
        // End of group or last highlight, use remaining video duration
        return videoDuration - startSeconds + transitionTime
    }
    
    public init( @SKVideoPageBuilder highlights: () -> [SKVideoHighlight], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        guard let url = highlights().flatMap{ $0.resource }.first else{ fatalError("No page have resource")}
        self.player = AVPlayer(url: url)
        self.highlights = highlights()
        self.data = .init(content: highlights, toolbar: toolbar)
    }
    
    public init(player: AVPlayer, @SKVideoPageBuilder highlights: () -> [SKVideoHighlight], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.player = player
        self.highlights = highlights()
        self.data = .init(content: highlights, toolbar: toolbar)
    }
    
    public init(videoURL: URL, @SKVideoPageBuilder highlights: () -> [SKVideoHighlight], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.player = AVPlayer(url: videoURL)
        self.highlights = highlights()
        self.data = .init(content: highlights, toolbar: toolbar)
    }
    
    public func skSelectedHighlightIndex(_ binding: Binding<Int>) -> Self {
        var copy = self
        return copy
    }
}
#endif

