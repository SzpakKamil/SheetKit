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
    @Environment(\.skIsContinueButtonHidden) var skIsContinueButtonHidden
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .primary }
        VStack{
            VStack(spacing: 5){
                ForEach(noteItems.indices){ index in
                    noteItems[index]
                }
                
                if #unavailable(macOS 26.0), skSheetStyle != .prominent, (!secondaryItems.isEmpty || !navigationItems.isEmpty || !primaryItems.isEmpty){
                    Divider()
                        .padding(.horizontal, -15)
                        .padding(.bottom, 5)
                        .padding(.top, 3)
                }
                if skSheetStyle == .prominent{
                    VStack(spacing: 10){
                        if primaryItems.isEmpty && !skIsContinueButtonHidden{
                            SKToolbarItem(placement: .primary) {SKButton("Continue") {}}
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
                            if navigationItems.isEmpty && (!isCloseButtonHidden || isShowingBackButton) && skSheetStyle == .default {
                                SKToolbarItem(placement: .navigation, actionType: .dismiss) {SKButton("Back"){}}
                            }else{
                                ForEach(navigationItems.indices){ index in
                                    navigationItems[index]
                                }
                            }
                        }
                    }else{
                        if skSheetStyle != .prominent{
                            if navigationItems.isEmpty && (!isCloseButtonHidden || isShowingBackButton) && skSheetStyle == .default {
                                SKToolbarItem(placement: .navigation, actionType: .dismiss) {SKButton("Back"){}}
                            }else{
                                ForEach(navigationItems.indices){ index in
                                    navigationItems[index]
                                }
                            }
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
