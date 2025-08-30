//
//  SKToolbar.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public struct SKToolbar: View {
    let items: [SKToolbarItem]
    public var body: some View {
        #if os(iOS)
        SKToolbarIOS(items: items)
        #elseif os(macOS)
        SKToolbarMACOS(items: items)
        #elseif os(tvOS)
        SKToolbarTVOS(items: items)
        #elseif os(visionOS)
        SKToolbarVISIONOS(items: items)
        #elseif os(watchOS)
        SKToolbarWATCHOS(items: items)
        #else
        EmptyView()
        #endif
    }
    
    public init(items: [SKToolbarItem]) {
        self.items = items
    }
    
    init(@SKToolbarBuilder items: () -> [SKToolbarItem]) {
        self.items = items()
    }
    
}


#if DEBUG
struct PreviewViewSKToolbar: View {
    var body: some View{
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
}
    
#Preview {
    PreviewViewSKToolbar()
}
#endif
