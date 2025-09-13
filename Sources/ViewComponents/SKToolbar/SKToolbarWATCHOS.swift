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
    @Environment(\.skIsContinueButtonHidden) var skIsContinueButtonHidden
    let items: [SKToolbarItem]
    var body: some View {
        let noteItems: [SKToolbarItem] = items.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = items.filter{ $0.placement == .secondary }
        let navigationItems: [SKToolbarItem] = items.filter{ $0.placement == .navigation }
        let primaryItems: [SKToolbarItem] = items.filter{ $0.placement == .primary }
        Text(verbatim: "")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ForEach(navigationItems.indices){ index in
                        navigationItems[index]
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if secondaryItems.isEmpty{
                        Button{
                            
                        }label:{
                            Text(verbatim: "")
                        }
                        .buttonStyle(.plain)
                        .accessibilityHidden(true)
                    }else{
                        ForEach(secondaryItems.indices){ index in
                            secondaryItems[index]
                        }
                    }
                    if noteItems.isEmpty{
                        Button{
                            
                        }label:{
                            Text(verbatim: "")
                        }
                        .buttonStyle(.plain)
                        .accessibilityHidden(true)
                    }else{
                        ForEach(noteItems.indices){ index in
                            noteItems[index]
                        }
                    }

                    
                    if primaryItems.isEmpty && !skIsContinueButtonHidden{
                        SKToolbarItem(placement: .primary, actionType: .primary) {
                            if IsFinalPage{
                                SKButton(verbatim: SKTranslation.SKButton.continue.value, systemImage: "checkmark"){}
                            }else{
                                SKButton(verbatim: SKTranslation.SKButton.continue.value, systemImage: "chevron.forward"){}
                            }
                        }
                    }else{
                        if primaryItems.isEmpty{
                            Button{
                                
                            }label:{
                                Text(verbatim: "")
                            }
                            .buttonStyle(.plain)
                            .accessibilityHidden(true)
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
