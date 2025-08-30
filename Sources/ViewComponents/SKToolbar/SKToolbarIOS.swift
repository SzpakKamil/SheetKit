//
//  SKToolbarIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(iOS)
struct SKToolbarIOS: View {
    @Environment(\.skIsContinueButtonHidden) var skIsContinueButtonHidden
    @Environment(\.skIsCloseButtonHidden) var skIsCloseButtonHidden
    let items: [SKToolbarItem]
    var body: some View {
        let noteItems: [SKToolbarItem] = items.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = items.filter{ $0.placement == .secondary }
        let navigationItems: [SKToolbarItem] = items.filter{ $0.placement == .navigation }
        let primaryItems: [SKToolbarItem] = items.filter{ $0.placement == .primary }
        VStack{
            VStack{
                ForEach(noteItems.indices){ index in
                    noteItems[index]
                }
            }
            .padding(.bottom, 8)
            if primaryItems.isEmpty && !skIsContinueButtonHidden{
                SKToolbarItem(placement: .primary) {
                    SKButton("Continue") {}
                }
            }else{
                ForEach(primaryItems.indices){ index in
                    primaryItems[index]
                }
            }
            ForEach(secondaryItems.indices){ index in
                secondaryItems[index]
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if !skIsCloseButtonHidden{
                    SKToolbarItem(placement: .navigation, actionType: .close) {
                        if #available(iOS 26.0, *){
                            SKButton("Close", systemImage: "xmark"){}
                        }else{
                            SKButton("Close"){}
                        }
                        
                    }
                }
                ForEach(navigationItems.indices) { index in
                    navigationItems[index]
                }
            }
        }
    }
    
    init(items: [SKToolbarItem]) {
        self.items = items
    }
}

#if DEBUG
#Preview {
    PreviewViewSKToolbar()
}
#endif
#endif
