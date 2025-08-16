//
//  SKToolbarWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKToolbarWATCHOS: View {
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
    @Environment(\.skIsFinalPage) var IsFinalPage
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .primary }
        Text("")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ForEach(navigationItems){ item in
                        item
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if secondaryItems.isEmpty && noteItems.isEmpty{
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
                            if IsFinalPage{
                                SKButton("Continue", systemImage: "checkmark"){}
                            }else{
                                SKButton("Continue", systemImage: "chevron.forward"){}
                            }
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
