//
//  SKToolbarTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKToolbarTVOS: View {
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
    @Environment(\.skIsContinueButtonHidden) var skIsContinueButtonHidden
    let items: [SKToolbarItem]
    var body: some View {
        let noteItems: [SKToolbarItem] = items.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = items.filter{ $0.placement == .secondary }
        let navigationItems: [SKToolbarItem] = items.filter{ $0.placement == .navigation }
        let primaryItems: [SKToolbarItem] = items.filter{ $0.placement == .primary }
        VStack{
            if #available(tvOS 26.0, *){
                VStack(spacing: 5){
                    ForEach(noteItems.indices){ index in
                        noteItems[index]
                    }
                }
            }
            HStack(spacing: 10){
                ForEach(secondaryItems.indices){ index in
                    secondaryItems[index]
                }
                if #unavailable(tvOS 26.0){
                    VStack(spacing: 5){
                        ForEach(noteItems.indices){ index in
                            noteItems[index]
                        }
                    }
                    if !secondaryItems.isEmpty{
                        Spacer()
                    }
                }else{
                    Spacer()
                }
                
                if navigationItems.isEmpty && (!isCloseButtonHidden || isShowingBackButton){
                    SKToolbarItem(placement: .navigation, actionType: .dismiss) {SKButton("Back"){}}
                }else{
                    ForEach(navigationItems.indices){ index in
                        navigationItems[index]
                    }
                }
                if primaryItems.isEmpty && !skIsContinueButtonHidden{
                    SKToolbarItem(placement: .primary) {SKButton("Continue") {}}
                }else{
                    ForEach(primaryItems.indices){ index in
                        primaryItems[index]
                    }
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
