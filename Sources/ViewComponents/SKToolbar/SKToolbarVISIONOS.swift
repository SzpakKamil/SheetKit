//
//  SKToolbarVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(visionOS)
struct SKToolbarVISIONOS: View {
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skIsContinueButtonHidden) var skIsContinueButtonHidden
    @Environment(\.skIsCloseButtonHidden) var skIsCloseButtonHidden
    @Environment(\.skIsShowingBackButton) var skIsShowingBackButton
    @Environment(\.skIsBackButtonHidden) var skIsBackButtonHidden
    @Environment(\.skIsBackDefaultButtonHidden) var skIsBackDefaultButtonHidden
    let items: [SKToolbarItem]
    var body: some View {
        let noteItems: [SKToolbarItem] = items.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = items.filter{ $0.placement == .secondary }
        let dismissItems: [SKToolbarItem] = items.filter{ $0.placement == .dismiss }
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
                    SKButton(verbatim: SKTranslation.SKButton.continue.value) {}
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
            ToolbarItemGroup(placement: .topBarLeading){
                if skIsShowingBackButton && (!skIsBackButtonHidden && !skIsBackDefaultButtonHidden){
                    SKToolbarItem(placement: .dismiss, actionType: .dismiss) {
                        SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "xmark"){}
                    }
                }
                ForEach(dismissItems.indices) { index in
                    dismissItems[index]
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                if !skIsCloseButtonHidden{
                    SKToolbarItem(placement: .navigation, actionType: .close) {
                        SKButton(verbatim: SKTranslation.SKButton.close.value, systemImage: "xmark"){}
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

#endif
