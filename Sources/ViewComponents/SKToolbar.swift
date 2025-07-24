//
//  SKToolbar.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI


@resultBuilder
public struct SKToolbarBuilder {
    public static func buildBlock(_ components: SKToolbarItem...) -> [SKToolbarItem] {
        return components
    }
}

// MARK: - Toolbar Data Extension
public extension SKToolbar {
    struct Data {
        let buttons: [SKToolbarItem]
        
        public init(@SKToolbarBuilder content: () -> [SKToolbarItem]) {
            self.buttons = content()
        }
    }
}


public struct SKToolbar: View {
    @Environment(\.sheetSize) var sheetSize
    let data: SKToolbar.Data
    public var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .primary }
        #if os(macOS) || os(tvOS)
        VStack{
            VStack(spacing: 5){
                ForEach(noteItems){ buttons in
                    buttons
                }
            }
            HStack(spacing: 10){
                ForEach(secondaryItems){ buttons in
                    buttons
                }
                Spacer()
                if navigationItems.isEmpty, sheetSize != .medium{
                    SKToolbarItem(placement: .navigation) { action in
                        Button("Back"){
                            action()
                        }
                    }
                }else{
                    ForEach(navigationItems){ buttons in
                        buttons
                    }
                }
                if primaryItems.isEmpty{
                    SKToolbarItem(placement: .primary) { action in
                        Button("Continue"){
                            action()
                        }
                    }
                }else{
                    ForEach(primaryItems){ buttons in
                        buttons
                    }
                }
            }
        }
        #else
        VStack{
            VStack{
                ForEach(noteItems){ buttons in
                    buttons
                }
            }
            .padding(.bottom, 8)
            if primaryItems.isEmpty{
                SKToolbarItem(placement: .primary) { action in
                    Button("Continue"){
                        action()
                    }
                }
            }else{
                ForEach(primaryItems){ buttons in
                    buttons
                }
            }
            ForEach(secondaryItems){ buttons in
                buttons
            }
        }
        #endif
    }
    
    public init(data: SKToolbar.Data) {
        self.data = data
    }
    
    public init(@SKToolbarBuilder content: () -> [SKToolbarItem]) {
        self.data = .init(content: content)
    }
    
}

#Preview {
    SKToolbar {
        SKToolbarItem(placement: .secondary) { _ in
            Button("Secondary"){
                
            }
        }
        SKToolbarItem(placement: .navigation) { _ in
            Button("Navigation"){
                
            }
        }
        SKToolbarItem(placement: .note) { _ in
            Button("Test Note"){
                
            }
        }
        SKToolbarItem(placement: .primary) { _ in
            Button("Primary"){
            }
        }
    }

}
