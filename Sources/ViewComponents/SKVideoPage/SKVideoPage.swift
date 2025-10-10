//
//  SKVideoPage.swift
//  SheetKit
//
//  Created by Kamil Szpak on 02/10/2025.
//
#if os(iOS) || os(tvOS) || os(visionOS) || os(macOS)
import SwiftUI
import AVKit
import TabKit


public struct SKVideoPage: SKPageable, View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skIsUsingFullScreenCover) var skIsUsingFullScreenCover
    @Environment(\.skDismissButtonAction) var skDismissButtonAction
    @Environment(\.skIsSkipButtonHidden) var skIsSkipButtonHidden
    @Environment(\.skIsBackButtonHidden) var skIsBackButtonHidden
    @Environment(\.skPrimaryButtonAction) var skPrimaryButtonAction
    public var data: SKPageableData
    public var adjustedContent: AnyView?
    var bindingIndex: Binding<Int>?
    @State private var defaultSelectedHighlightIndex: Int = 0
    var selectedHighlightIndex: Binding<Int>{
        bindingIndex ?? $defaultSelectedHighlightIndex
    }
    @State private var showingTransitionBG = false
    @State private var player: AVPlayer
    @State private var isLoaded: Bool = false
    @State private var isDuringTransiton: Bool = false
    
    let pageBackground: AnyView
    let highlights: [SKVideoHighlight]
    
    var pageStyle: SKPageBackgroundStyle {
        data.backgroundStyle ?? .init{
            #if os(tvOS)
            ZStack{
                if colorScheme == .dark{
                    Color(red: 0.0, green: 0.0, blue: 0.01)
                        .opacity(0.8)
                        .ignoresSafeArea()
                }else{
                    Color(white: 0.9)
                        .opacity(0.7)
                        .ignoresSafeArea()
                }
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
            }
            #elseif os(iOS)
            if colorScheme == .light{
                Color.clear
            }else{
                skIsUsingFullScreenCover ? Color.black : Color(red: 0.109375, green: 0.109375, blue: 0.1176470588)
            }
            #else
            Color.clear
            #endif
        }
    }
    
    var pageColor: Color {
        #if os(tvOS)
        let defaultValue: Color = colorScheme == .dark ? Color(red: 0.02, green: 0.02, blue: 0.03) : Color(white: 0.9)
        #elseif os(visionOS)
        let defaultValue: Color = Color(red: 0.4, green: 0.4, blue: 0.4)
        #elseif os(macOS)
        let defaultValue: Color = colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.18) : .white
        #else
        let defaultValue: Color = colorScheme == .dark ? skIsUsingFullScreenCover ? Color.black : Color(red: 0.109375, green: 0.109375, blue: 0.1176470588) : .white
        #endif
        guard selectedHighlightIndex.wrappedValue < highlights.count else {
            return defaultValue
        }
        return highlights[selectedHighlightIndex.wrappedValue].backgroundColor ?? defaultValue
    }
    
    var toolbarNew: SKToolbar{
        #if os(iOS) || os(visionOS)
        let navigationItem: SKToolbarItem = SKToolbarItem(placement: .dismiss, actionType: .dismiss) {
            if isLoaded{
                if #available(iOS 26.0, *){
                    SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward"){}
                        .skAccentColor(nil)
                }else{
                    SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward"){}
                        .skAccentColor(.accentColor)
                }
            }
        }
        let secondaryItem: SKToolbarItem = SKToolbarItem(placement: .navigation, actionType: .none) {
            if isLoaded{
                if #available(iOS 26.0, *){
                    SKButton(verbatim: SKTranslation.SKButton.skip.value){
                        skPrimaryButtonAction()
                    }
                    .skAccentColor(nil)
                }else{
                    SKButton(verbatim: SKTranslation.SKButton.skip.value){
                        skPrimaryButtonAction()
                    }
                    .skAccentColor(.accentColor)
                }
            }
        }
        #elseif os(macOS)
        let navigationItem: SKToolbarItem = SKToolbarItem(placement: .navigation, actionType: .dismiss) {
            if #available(iOS 26.0, *){
                SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward"){}
                    .skAccentColor(nil)
            }else{
                SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward"){}
                    .skAccentColor(.accentColor)
            }
        }
        let secondaryItem: SKToolbarItem = SKToolbarItem(placement: .secondary, actionType: .none) {
            if #available(iOS 26.0, *){
                SKButton(verbatim: SKTranslation.SKButton.skip.value){
                    skPrimaryButtonAction()
                }
                .skAccentColor(nil)
            }else{
                SKButton(verbatim: SKTranslation.SKButton.skip.value){
                    skPrimaryButtonAction()
                }
                .skAccentColor(.accentColor)
            }
        }
        #else
        let navigationItem: SKToolbarItem = SKToolbarItem(placement: .secondary, actionType: .dismiss) {
            SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward"){}
                .skAccentColor(nil)
        }
        let secondaryItem: SKToolbarItem = SKToolbarItem(placement: .navigation, actionType: .none) {
            SKButton(verbatim: SKTranslation.SKButton.skip.value){
                skPrimaryButtonAction()
            }
            .skAccentColor(nil)
        }
        #endif
        var newItems = data.toolbar.items
        if !skIsBackButtonHidden{
            newItems.append(navigationItem)
        }
        if !skIsSkipButtonHidden{
            newItems.append(secondaryItem)
        }
        return .init(items: newItems)
    }
    
    public var body: some View {
        SKScrollView(pageStyle: .plain, backgroundStyle: pageStyle, toolbar: toolbarNew, showBlur: false, showAsInset: true, opacity: isLoaded ? 1 : 0,  toolbarAnimations: .smooth(duration: 1.5).delay(0.4), animationValue: isLoaded) {
            videoContent()
        }
        .onAppear {
            if let firstStartTime = highlights.first?.startTime?.seconds, firstStartTime > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + firstStartTime + 1) {
                    isLoaded = true
                }
            }else{
                isLoaded = true
            }
        }
        .environment(\.skIsCloseButtonHidden, true)
        .environment(\.skPrimaryButtonAction){
            if selectedHighlightIndex.wrappedValue >= highlights.count - 1{
                skPrimaryButtonAction()
            }else{
                selectedHighlightIndex.wrappedValue += 1
            }
        }
        .environment(\.skDismissButtonAction){
            if selectedHighlightIndex.wrappedValue <= 0{
                skDismissButtonAction()
            }else{
                selectedHighlightIndex.wrappedValue -= 1
            }
        }
        .environment(\.skIsBackDefaultButtonHidden, true)
        #if os(macOS)
        .frame(width: sheetStyle.windowWidth, height: sheetStyle.height)
        #endif
    }
    
    @ViewBuilder
    private func videoContent() -> some View{
        GeometryReader{ proxy in
            ZStack(alignment: .bottom){
                SKPlayerView(player: $player)
                    .ignoresSafeArea()
                    .focusable(false)
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
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
                
                LinearGradient(
                    stops: [
                        .init(color: pageColor.opacity(0), location: 0),
                        .init(color: pageColor.opacity(0), location: 0.6),
                        .init(color: pageColor.opacity(1), location: 0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .opacity(isLoaded ? 1 : 0)
                .animation(.smooth(duration: 1.5).delay(0.2), value: isLoaded)
                pageColor
                    .opacity(showingTransitionBG ? 1 : 0)
                    .ignoresSafeArea()
                
                Group{
                    TKPagesView {
                        ForEach(highlights.indices, id: \.self) { index in
                            let highlight = highlights[index]
                            TKPage {
                                highlight
                                    .setAutoStyle(index: index)
                                    .ignoresSafeArea()
                            }
                            .tkPageDuration(
                                calculateDuration(
                                    previousItem: highlights.indices.contains(index > 0 ? index-1 : 0) ? highlights[index == 0 ? 0 : index-1] : highlights[index],
                                    currentItem: highlights[index],
                                    nextItem: (index+1)<highlights.count ? highlights[index+1] : nil
                                )
                            )
                        }
                    }
                    .tkCurrentPageIndex(index: selectedHighlightIndex)
                    .tkPageControlAlignment(spacing: 0, alignment: .bottom)
                    .tkPageControlAllowsContinuousInteraction(false)
                    .tkPageControlCurrentIndicatorTintColor(.primary.opacity(0.5))
                    .tkPageControlIndicatorTintColor(.secondary.opacity(0.5))
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
        if shouldShowTransition && !isDuringTransiton{
            withAnimation(.smooth(duration: 0.5)){
                showingTransitionBG = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (shouldShowTransition ? 0.5 : 0)){
            configuratePlayerLayer(previousItem: previousItem, currentItem: currentItem, isManual: isManual)
        }
        
        
        if shouldShowTransition && !isDuringTransiton{
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
    
    private func configuratePlayerLayer(previousItem: SKVideoHighlight, currentItem: SKVideoHighlight, isManual: Bool) {
        if let resource = currentItem.resource, highlights.last == previousItem && highlights.first == currentItem {
            player.pause()
            player = AVPlayer(url: resource)
            player.seek(to: (currentItem.startTime ?? .zero))
            player.play()
        }else if previousItem.resource == currentItem.resource {
            if isManual{
                player.seek(to: isLoaded ? currentItem.startTime ?? .zero : .zero)
            }
            player.play()
        } else if let resource = currentItem.resource {
            player.pause()
            player = AVPlayer(url: resource)
            player.seek(to: currentItem.startTime ?? .zero)
            player.play()
        }
    }
    
    private func calculateDuration(previousItem: SKVideoHighlight, currentItem: SKVideoHighlight, nextItem: SKVideoHighlight?) -> Double? {
        let highlight = currentItem
        guard !highlight.runIndefinitly else { return nil }
        #if os(macOS)
        let transitionTime: Double = highlight.transitionAutoDirection != .none ? 0 : 0
        #else
        let transitionTime: Double = highlight.transitionAutoDirection != .none ? -0.5 : 0
        #endif
        let assetURL = highlight.resource ?? previousItem.resource
        guard let url = assetURL else { return nil }
        let asset = AVAsset(url: url)
        let videoDuration = asset.duration
        guard videoDuration.isValid, !videoDuration.isIndefinite else { return nil }
        let totalDuration = videoDuration.seconds
        let startSeconds = !isLoaded ? .zero : (highlight.startTime ?? .zero).seconds
        guard !startSeconds.isNaN else { return nil }
        if let next = nextItem, highlight.resource == next.resource {
            let nextStart = (next.startTime ?? .zero).seconds
            guard !nextStart.isNaN else { return nil }
            return nextStart - startSeconds + transitionTime
        } else if let endTime = highlight.endTime, endTime.isValid, !endTime.isIndefinite {
            return endTime.seconds - startSeconds + transitionTime
        } else {
            return totalDuration - startSeconds + transitionTime
        }
    }
    
    public init( @SKVideoPageBuilder highlights: () -> [SKVideoHighlight], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        var highlightsResult = highlights()
        guard let url = highlightsResult.compactMap({ $0.resource }).first else{ fatalError("No page have resource")}
        self.player = AVPlayer(url: url)
        self.bindingIndex = nil
        self.highlights = highlightsResult
        self.pageBackground = AnyView(Group{})
        self.data = .init(content: highlightsResult, toolbar: toolbar)
    }
    
    public init(player: AVPlayer, @SKVideoPageBuilder highlights: () -> [SKVideoHighlight], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.player = player
        self.bindingIndex = nil
        self.pageBackground = AnyView(Group{})
        let result = SKVideoPage.transformHighlights(for: highlights(), defaultURL: (player.currentItem?.asset as? AVURLAsset)?.url)
        self.highlights = result
        self.data = .init(content: result, toolbar: toolbar)
    }
    
    public init(resource: URL, @SKVideoPageBuilder highlights: () -> [SKVideoHighlight], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.player = AVPlayer(url: resource)
        self.pageBackground = AnyView(Group{})
        self.bindingIndex = nil
        let result = SKVideoPage.transformHighlights(for: highlights(), defaultURL: resource)
        self.highlights = result
        self.data = .init(content: result, toolbar: toolbar)
    }
    
    
    static func transformHighlights(for highlights: [SKVideoHighlight], defaultURL: URL?) -> [SKVideoHighlight]{
        guard !highlights.isEmpty else { return [] }
        var result = highlights
        // Step 1: Overwrite first element if needed
        if let url = defaultURL, result[0].resource == nil {
            result[0].resource = url
        }
        // Step 2: For each next element, inherit from previous non-nil
        for i in 1..<result.count {
            if result[i].resource == nil {
                // Scan backwards to find previous non-nil resource
                var foundURL: URL? = nil
                for j in (0..<i).reversed() {
                    if let prevURL = result[j].resource {
                        foundURL = prevURL
                        break
                    }
                }
                if let foundURL = foundURL {
                    result[i].resource = foundURL
                }
            }
        }
        return result
    }
}
#endif

