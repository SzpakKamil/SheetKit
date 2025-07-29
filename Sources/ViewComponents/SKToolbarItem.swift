//
//  SKToolbarItem.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/07/2025.
//

import SwiftUI

public extension SKToolbarItem {
    struct Data: Identifiable, Hashable {
        public let id: UUID
        let placement: SKToolbarItem.Placement
        let content: (@escaping () -> Void) -> AnyView
        let noActionContent: (() -> AnyView)?
        
        // Initializer for content with action
        public init(placement: SKToolbarItem.Placement, @ViewBuilder content: @escaping (@escaping () -> Void) -> some View) {
            self.id = UUID()
            self.placement = placement
            self.content = { action in AnyView(content(action)) }
            self.noActionContent = nil
        }
        
        // Initializer for content without action
        public init(placement: SKToolbarItem.Placement, @ViewBuilder content: @escaping () -> some View) {
            self.id = UUID()
            self.placement = placement
            self.content = { _ in AnyView(content()) }
            self.noActionContent = { AnyView(content()) }
        }
        
        public static func == (lhs: SKToolbarItem.Data, rhs: SKToolbarItem.Data) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    enum Placement {
        case primary
        case secondary
        case navigation
        case note
    }
}

public struct SKToolbarItem: View, Identifiable, Hashable {
    @Environment(\.primaryAction) var primaryAction
    @Environment(\.navigationAction) var navigationAction
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.accentColor) var accentColor
    @Environment(\.skSheetSize) var sheetSize
    public var id: UUID {
        data.id
    }
    
    var data: SKToolbarItem.Data
    
    public var body: some View {
        Group{
            switch data.placement{
            case .primary:
                data.content(primaryAction)
            case .navigation:
                data.content(navigationAction)
            default:
                data.content({})
            }
        }
        .environment(\.skToolbarPlacement, data.placement)
    }
    
    // Initializer for content with action
    public init(placement: SKToolbarItem.Placement, @ViewBuilder content: @escaping (@escaping () -> Void) -> some View) {
        self.data = .init(placement: placement, content: content)
    }
    
    // Initializer for content without action
    public init(placement: SKToolbarItem.Placement, @ViewBuilder content: @escaping () -> some View) {
        self.data = .init(placement: placement, content: content)
    }
    
    public static func == (lhs: SKToolbarItem, rhs: SKToolbarItem) -> Bool {
        lhs.data.id == rhs.data.id
    }
    
    public func hash(into hasher: inout Hasher) {
        data.hash(into: &hasher)
    }
}

#if DEBUG
#Preview {
    SKToolbarItem(placement: .navigation){ action in
        Button("Test") {
            action()
        }
    }
}
#endif
