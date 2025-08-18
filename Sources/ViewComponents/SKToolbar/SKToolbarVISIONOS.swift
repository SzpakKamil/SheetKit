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
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.placement == .primary }
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
    }
    
    init(data: SKToolbar.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview(windowStyle: .automatic){
    PreviewViewSKToolbar()
}
#endif
#endif
