//
//  SKToolbarItem.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/07/2025.
//

import SwiftUI

public struct SKToolbarItem: View {
    @Environment(\.skPrimaryButtonAction) var primaryAction
    @Environment(\.skDismissButtonAction) var dismissAction
    @Environment(\.skCloseButtonAction) var closeAction
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skAccentColor) var accentColor
    let placement: SKToolbarItemPlacement
    let actionType: SKToolbarItemActionType
    let content: (@escaping () -> Void) -> AnyView
    
    public var body: some View {
        let action: () -> Void = {
            switch actionType {
            case .primary:
                primaryAction()
            case .dismiss:
                dismissAction()
            case .close:
                closeAction()
            case .none:
                break
            case .auto:
                switch placement{
                case .primary:
                    primaryAction()
                case .dismiss:
                    dismissAction()
                default:
                    break
                }
            }
        }
        
        content(action)
        .environment(\.skToolbarButtonAction, action)
        .environment(\.skToolbarPlacement, placement)
    }
    
    // Initializer for content with action
    public init(placement: SKToolbarItemPlacement, actionType: SKToolbarItemActionType = .auto, @ViewBuilder content: @escaping (@escaping () -> Void) -> some View) {
        self.placement = placement
        self.actionType = actionType
        self.content = { AnyView(content($0).environment(\.skToolbarButtonAction, {}))}
    }
    
    // Initializer for content without action
    public init(placement: SKToolbarItemPlacement, actionType: SKToolbarItemActionType = .auto, @ViewBuilder content: @escaping () -> some View) {
        self.placement = placement
        self.actionType = actionType
        self.content = { _ in AnyView(content()) }
    }
}
