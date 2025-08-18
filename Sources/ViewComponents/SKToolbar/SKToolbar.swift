//
//  SKToolbar.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI



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
    let data: SKToolbar.Data
    public var body: some View {
        #if os(iOS)
        SKToolbarIOS(data: data)
        #elseif os(macOS)
        SKToolbarMACOS(data: data)
        #elseif os(tvOS)
        SKToolbarTVOS(data: data)
        #elseif os(visionOS)
        SKToolbarVISIONOS(data: data)
        #elseif os(watchOS)
        SKToolbarWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }
    
    public init(data: SKToolbar.Data) {
        self.data = data
    }
    
    public init(@SKToolbarBuilder content: () -> [SKToolbarItem]) {
        self.data = .init(content: content)
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
