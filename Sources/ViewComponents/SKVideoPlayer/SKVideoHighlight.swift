//
//  SKVideoHighlight.swift
//  SheetKit
//
//  Created by Kamil Szpak on 30/09/2025.
//

import SwiftUI
#if os(iOS) || os(tvOS) || os(visionOS)
import AVKit
import TabKit

public struct SKVideoHighlight: View, Hashable, Comparable, SKComponent {
    public enum Style{
        case plain
        case auto
        case primary
        case secondary
        
        var description: String{
            switch self {
            case .plain:
                "plain"
            case .auto:
                "auto"
            case .primary:
                "primary"
            case .secondary:
                "secondary"
            }
        }
    }
    public enum TransitionDirection{
        case forward, backward, both, none
        var description: String{
            switch self {
            case .forward:
                "forward"
            case .backward:
                "backward"
            case .both:
                "both"
            case .none:
                "none"
            }
        }
    }
    var id: String{
        "StartTime:\(startTime?.seconds ?? 0)-EndTime:\(endTime?.seconds ?? 0)-Resource:\(resource?.absoluteString ?? "nil")-Style:\(style.description)-TransitionAutoDirection:\(transitionAutoDirection.description)-TransitionManualDirection:\(transitionManualDirection.description)-runIndexfinitely:\(runIndefinitly)"
    }
    var style: Style
    var autoOverride: Style
    var transitionAutoDirection: TransitionDirection
    var transitionManualDirection: TransitionDirection
    var runIndefinitly: Bool
    public var type: SKComponentType = .customView
    var geoProxy: GeometryProxy?
    let resource: URL?
    let startTime: CMTime?
    let endTime: CMTime?
    let content: AnyView
    
    public var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                content
            }
            .frame(height: (geoProxy?.size.height ?? 200) * 0.35, alignment: .top)
        }
        .frame(height: geoProxy?.size.height ?? 200, alignment: .bottom)
        .padding(.horizontal)
        .if{ content in
            if style != .plain{
                content
                    .environment(\.skPrimaryColor, Color.white)
                    .environment(\.skSecondaryColor, Color.white.opacity(0.6))
                    .if{ content in
                        if style == .auto{
                            content
                                .environment(\.skAlignment, autoOverride == .primary ? .leading : .center)
                        }else{
                            content
                                .environment(\.skAlignment, style == .primary ? .leading : .center)
                        }
                    }
            }else{
                content
            }
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func ==(lhs: SKVideoHighlight, rhs: SKVideoHighlight) -> Bool {
        lhs.id == rhs.id
    }
    
    public static func <(lhs: SKVideoHighlight, rhs: SKVideoHighlight) -> Bool {
        lhs.startTime ?? .zero < rhs.startTime ?? .zero
    }
    public init(resource: URL, @ViewBuilder content: () -> some View) {
        self.content = AnyView(content())
        self.resource = resource
        self.startTime = CMTime(seconds: 0, preferredTimescale: 60000)
        self.endTime = nil
        self.geoProxy = nil
        self.style = .auto
        self.runIndefinitly = false
        self.autoOverride = .auto
        self.transitionAutoDirection = .both
        self.transitionManualDirection = .both
    }
    public init(resource: URL, startTime: CMTime, endTime: CMTime? = nil, @ViewBuilder content: () -> some View) {
        self.content = AnyView(content())
        self.resource = resource
        self.startTime = startTime
        self.endTime = endTime
        self.geoProxy = nil
        self.style = .auto
        self.runIndefinitly = false
        self.autoOverride = .auto
        self.transitionAutoDirection = .both
        self.transitionManualDirection = .both
    }
    
    public init(resource: URL, startSeccond: Double, endSeccond: Double? = nil, @ViewBuilder content: () -> some View) {
        self.content = AnyView(content())
        self.resource = resource
        self.startTime = CMTime(seconds: startSeccond, preferredTimescale: 60000)
        if let endSeccond{
            self.endTime = CMTime(seconds: endSeccond, preferredTimescale: 60000)
        }else{
            self.endTime = nil
        }
        self.geoProxy = nil
        self.style = .auto
        self.runIndefinitly = false
        self.autoOverride = .auto
        self.transitionAutoDirection = .both
        self.transitionManualDirection = .both
    }
    
    public init(startTime: CMTime, endTime: CMTime? = nil, @ViewBuilder content: () -> some View) {
        self.content = AnyView(content())
        self.resource = nil
        self.startTime = startTime
        self.endTime = endTime
        self.geoProxy = nil
        self.style = .auto
        self.runIndefinitly = false
        self.autoOverride = .auto
        self.transitionAutoDirection = .both
        self.transitionManualDirection = .both
    }
    
    public init(startSeccond: Double, endSeccond: Double? = nil, @ViewBuilder content: () -> some View) {
        self.content = AnyView(content())
        self.resource = nil
        self.startTime = CMTime(seconds: startSeccond, preferredTimescale: 60000)
        if let endSeccond{
            self.endTime = CMTime(seconds: endSeccond, preferredTimescale: 60000)
        }else{
            self.endTime = nil
        }
        self.geoProxy = nil
        self.style = .auto
        self.autoOverride = .auto
        self.transitionAutoDirection = .both
        self.transitionManualDirection = .both
        self.runIndefinitly = false
    }
    
    func updateGeoProxy(proxy: GeometryProxy) -> Self{
        var copy = self
        copy.geoProxy = proxy
        return copy
    }
    
    public func skVideoHighlightStyle(_ style: SKVideoHighlight.Style) -> Self{
        var copy = self
        copy.style = style
        return copy
    }
    
    public func skVideoHighlightRunIndefinitly(_ condition: Bool) -> Self{
        var copy = self
        copy.runIndefinitly = condition
        return copy
    }
    
    public func skVideoHighlightTransitionDirection(autoChange: SKVideoHighlight.TransitionDirection, manualChange: SKVideoHighlight.TransitionDirection) -> Self{
        var copy = self
        copy.transitionAutoDirection = autoChange
        copy.transitionManualDirection = manualChange
        return copy
    }
    
    public func skVideoHighlightTransitionDirection(_ direction: SKVideoHighlight.TransitionDirection) -> Self{
        var copy = self
        copy.transitionAutoDirection = direction
        copy.transitionAutoDirection = direction
        return copy
    }
    
    
    func setAutoStyle(index: Int) -> Self{
        var copy = self
        copy.autoOverride = index == 0 ? .primary : .secondary
        return copy
    }
}
#endif
