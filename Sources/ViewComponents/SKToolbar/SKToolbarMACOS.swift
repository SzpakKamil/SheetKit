//
//  SKToolbarMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKToolbarMACOS: View {
    @Environment(\.skSheetStyle) var skSheetStyle
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
    @Environment(\.skIsBackDefaultButtonHidden) var skIsBackDefaultButtonHidden
    @Environment(\.skIsBackButtonHidden) var skIsBackButtonHidden
    @Environment(\.skIsContinueButtonHidden) var skIsContinueButtonHidden
    let items: [SKToolbarItem]
    var body: some View {
        let noteItems: [SKToolbarItem] = items.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = items.filter{ $0.placement == .secondary }
        let navigationItems: [SKToolbarItem] = items.filter{ $0.placement == .navigation || $0.placement == .dismiss }
        let primaryItems: [SKToolbarItem] = items.filter{ $0.placement == .primary }
        VStack{
            VStack(spacing: 5){
                ForEach(noteItems.indices){ index in
                    noteItems[index]
                }
                
                if #unavailable(macOS 26.0), skSheetStyle != .prominent, (!secondaryItems.isEmpty || (!navigationItems.isEmpty || !isCloseButtonHidden) || (!primaryItems.isEmpty || !skIsContinueButtonHidden)){
                    Divider()
                        .padding(.horizontal, -15)
                        .padding(.bottom, 5)
                        .padding(.top, 3)
                }
                if skSheetStyle == .prominent{
                    VStack(spacing: 10){
                        if primaryItems.isEmpty && !skIsContinueButtonHidden{
                            SKToolbarItem(placement: .primary) {SKButton(verbatim: SKTranslation.SKButton.continue.value) {}}
                        }else{
                            ForEach(primaryItems.indices){ index in
                                primaryItems[index]
                            }
                        }
                        ForEach(secondaryItems.indices){ index in
                            secondaryItems[index]
                        }
                    }
                }
            }
            if skSheetStyle != .prominent{
                HStack(spacing: 10){
                    ForEach(secondaryItems.indices){ index in
                        secondaryItems[index]
                    }
                    Spacer()
                    if #available(macOS 26.0, *){
                        if skSheetStyle == .default{
                            if navigationItems.isEmpty && (!isCloseButtonHidden || isShowingBackButton || (skIsBackButtonHidden && skIsBackDefaultButtonHidden)) {
                                SKToolbarItem(placement: .navigation, actionType: .dismiss) {SKButton(verbatim: SKTranslation.SKButton.back.value){}}
                            }else{
                                ForEach(navigationItems.indices){ index in
                                    navigationItems[index]
                                }
                            }
                        }
                    }else{
                        if navigationItems.isEmpty && (!isCloseButtonHidden || isShowingBackButton || (skIsBackButtonHidden && skIsBackDefaultButtonHidden)) {
                            SKToolbarItem(placement: .navigation, actionType: .dismiss) {SKButton(verbatim: SKTranslation.SKButton.back.value){}}
                        }else{
                            ForEach(navigationItems.indices){ index in
                                navigationItems[index]
                            }
                        }
                    }

                    if primaryItems.isEmpty && !skIsContinueButtonHidden{
                        SKToolbarItem(placement: .primary) {SKButton(verbatim: SKTranslation.SKButton.continue.value) {}}
                    }else{
                        ForEach(primaryItems.indices){ index in
                            primaryItems[index]
                        }
                    }
                }
            }
        }
    }
    
    init(items: [SKToolbarItem]) {
        self.items = items
    }
}

#endif
