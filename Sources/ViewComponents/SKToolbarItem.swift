//
//  SKToolbarItem.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/07/2025.
//

import SwiftUI

public extension SKToolbarItem{
    struct Data: Identifiable, Hashable{
        public let id: UUID
        let placement: SKToolbarItem.Placement
        let content: (@escaping () -> Void) -> AnyView
        
        public init(placement: SKToolbarItem.Placement, @ViewBuilder content: @escaping ( @escaping () -> Void) -> some View) {
            self.id = UUID()
            self.placement = placement
            self.content = { action in AnyView(content(action))}
        }
        
        public static func == (lhs: SKToolbarItem.Data, rhs: SKToolbarItem.Data) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    enum Placement{
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
    @Environment(\.sheetSize) var sheetSize
    public var id: UUID{
        data.id
    }
    
    var data: SKToolbarItem.Data
    

    public var body: some View {
        switch data.placement{
        case .primary:
            data.content(primaryAction)
                .buttonStyle(SKPrimaryButtonStyle(isEnabled: true, accentColor: accentColor, colorScheme: colorScheme))
        case .secondary:
            data.content({})
                .buttonStyle(SKSecondaryButtonStyle(isEnabled: true, accentColor: accentColor))
        case .navigation:
            data.content(navigationAction)
                .buttonStyle(SKNavigationButtonStyle(colorScheme: colorScheme, sheetSize: sheetSize, isEnabled: true, accentColor: accentColor))
        case .note:
            data.content({})
                .buttonStyle(SKNoteButtonStyle(isEnabled: true, accentColor: accentColor, colorScheme: colorScheme))
        }
    }
    
    public init(placement: SKToolbarItem.Placement, @ViewBuilder content: @escaping ( @escaping () -> Void) -> some View) {
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
