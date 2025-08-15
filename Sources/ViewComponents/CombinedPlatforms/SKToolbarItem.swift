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
        let actionType: SKToolbarItem.ActionType
        let content: (@escaping () -> Void) -> AnyView
        
        // Initializer for content with action
        public init(placement: SKToolbarItem.Placement, actionType: SKToolbarItem.ActionType = .auto, @ViewBuilder content: @escaping (@escaping () -> Void) -> some View) {
            self.id = UUID()
            self.placement = placement
            self.actionType = actionType
            self.content = { AnyView(content($0).environment(\.skToolbarButtonAction, {}))}
        }
        
        // Initializer for content without action
        public init(placement: SKToolbarItem.Placement, actionType: SKToolbarItem.ActionType = .auto, @ViewBuilder content: @escaping () -> some View) {
            self.id = UUID()
            self.placement = placement
            self.actionType = actionType
            self.content = { _ in AnyView(content()) }
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
    
    enum ActionType {
        case primary
        case dismiss
        case close
        case none
        case auto
    }
}

public struct SKToolbarItem: View, Identifiable, Hashable {
    @Environment(\.skPrimaryButtonAction) var primaryAction
    @Environment(\.skDismissButtonAction) var dismissAction
    @Environment(\.skCloseButtonAction) var closeAction
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skAccentColor) var accentColor
    public var id: UUID {
        data.id
    }
    
    var data: SKToolbarItem.Data
    
    public var body: some View {
        let action: () -> Void = {
            switch data.actionType {
            case .primary:
                primaryAction()
            case .dismiss:
                dismissAction()
            case .close:
                closeAction()
            case .none:
                break
            case .auto:
                switch data.placement{
                case .primary:
                    primaryAction()
                default:
                    break
                }
            }
        }
        
        data.content(action)
        .environment(\.skToolbarPlacement, data.placement)
        .environment(\.skToolbarButtonAction, action)
    }
    
    // Initializer for content with action
    public init(placement: SKToolbarItem.Placement, actionType: SKToolbarItem.ActionType = .auto, @ViewBuilder content: @escaping (@escaping () -> Void) -> some View) {
        self.data = .init(placement: placement, actionType: actionType, content: content)
    }
    
    // Initializer for content without action
    public init(placement: SKToolbarItem.Placement, actionType: SKToolbarItem.ActionType = .auto, @ViewBuilder content: @escaping () -> some View) {
        self.data = .init(placement: placement, actionType: actionType, content: content)
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
    SKToolbarItem(placement: .primary){ action in
        SKButton("Test") {
            action()
        }
    }
}
#endif
