//
//  SKToolbarWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKToolbarWATCHOS: View {
    @Environment(\.skSheetSize) var sheetSize
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .primary }
        Text("")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    SKToolbarItem(placement: .navigation, actionType: .dismiss) {
                        SKButton(systemImage: "chevron.backward"){}
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ForEach(navigationItems){ item in
                        item
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if secondaryItems.isEmpty && navigationItems.isEmpty{
                        Button(""){
                            
                        }
                        .buttonStyle(.plain)
                    }else{
                        ForEach(secondaryItems){ item in
                            item
                        }
                    }
                    ForEach(noteItems){ item in
                        item
                    }
                    
                    if primaryItems.isEmpty{

                        SKToolbarItem(placement: .primary, actionType: .primary) {
                            SKButton("Continue", systemImage: "checkmark"){}
                        }
                    }else{
                        ForEach(primaryItems){ item in
                            item
                        }
                    }
                }
            }
    }
    
    init(data: SKToolbar.Data) {
        self.data = data
    }
    
    
}

#if DEBUG
#Preview {
    PreviewViewSKToolbar()
}
#endif
#endif
