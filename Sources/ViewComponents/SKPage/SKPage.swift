//
//  SKPage.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public struct SKPage: View, SKPageable{
    public var data: SKPageableData
    public var adjustedContent: AnyView?
    public var body: some View {
        if let adjustedContent{
            adjustedContent
        }else{
            #if os(iOS)
            SKPageIOS(data: data)
            #elseif os(macOS)
            SKPageMACOS(data: data)
            #elseif os(tvOS)
            SKPageTVOS(data: data)
            #elseif os(visionOS)
            SKPageVISIONOS(data: data)
            #elseif os(watchOS)
            SKPageWATCHOS(data: data)
            #else
            EmptyView()
            #endif
        }
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.data = .init(content: content, toolbar: toolbar)
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent]) {
        self.data = .init(content: content, toolbar: {})
    }
    init(data: SKPageableData) {
        self.data = data
    }
    init(data: SKPageableData, @ViewBuilder content: @escaping () -> some View) {
        self.data = data
        self.adjustedContent = AnyView(content())
    }
}
