//
//  SKToolbarIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(iOS)
struct SKToolbarIOS: View {
    @Environment(\.skSheetSize) var sheetSize
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .primary }
        VStack{
            VStack{
                ForEach(noteItems){ buttons in
                    buttons
                }
            }
            .padding(.bottom, 8)
            if primaryItems.isEmpty{
                SKToolbarItem(placement: .primary) {
                    SKButton("Continue") {}
                }
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
