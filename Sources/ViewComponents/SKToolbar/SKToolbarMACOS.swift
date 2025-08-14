//
//  SKToolbarMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKToolbarMACOS: View {
    @Environment(\.skSheetSize) var skSheetSize
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .primary }
        VStack{
            VStack(spacing: 5){
                ForEach(noteItems){ buttons in
                    buttons
                }
                
                if skSheetSize == .small{
                    VStack(spacing: 10){
                        if primaryItems.isEmpty{
                            SKToolbarItem(placement: .primary) {SKButton("Continue") {}}
                        }else{
                            ForEach(primaryItems){ buttons in
                                buttons
                            }
                        }
                        ForEach(secondaryItems){ buttons in
                            buttons
                        }
                    }
                }
            }
            if skSheetSize != .small{
                HStack(spacing: 10){
                    ForEach(secondaryItems){ buttons in
                        buttons
                    }
                    Spacer()
                    if navigationItems.isEmpty && (!isCloseButtonHidden || isShowingBackButton) && skSheetSize == .large {
                        SKToolbarItem(placement: .navigation, actionType: .dismiss) {SKButton("Back"){}}
                    }else{
                        ForEach(navigationItems){ buttons in
                            buttons
                        }
                    }
                    if primaryItems.isEmpty{
                        SKToolbarItem(placement: .primary) {SKButton("Continue") {}}
                    }else{
                        ForEach(primaryItems){ buttons in
                            buttons
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
