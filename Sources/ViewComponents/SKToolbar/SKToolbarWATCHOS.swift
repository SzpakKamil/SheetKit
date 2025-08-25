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
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .primary }
        Text("")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ForEach(navigationItems.indices){ index in
                        navigationItems[index]
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if secondaryItems.isEmpty{
                        Button(""){
                            
                        }
                        .buttonStyle(.plain)
                    }else{
                        ForEach(secondaryItems.indices){ index in
                            secondaryItems[index]
                        }
                    }
                    if noteItems.isEmpty{
                        Button(""){
                            
                        }
                        .buttonStyle(.plain)
                    }else{
                        ForEach(noteItems.indices){ index in
                            noteItems[index]
                        }
                    }

                    
                    if primaryItems.isEmpty && !skIsContinueButtonHidden{
                        SKToolbarItem(placement: .primary, actionType: .primary) {
                            if IsFinalPage{
                                SKButton("Continue", systemImage: "checkmark"){}
                            }else{
                                SKButton("Continue", systemImage: "chevron.forward"){}
                            }
                        }
                    }else{
                        if primaryItems.isEmpty{
                            Button(""){
                                
                            }
                            .buttonStyle(.plain)
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
