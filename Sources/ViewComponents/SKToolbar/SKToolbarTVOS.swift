//
//  SKToolbarTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKToolbarTVOS: View {
    @Environment(\.skSheetSize) var sheetSize
    let data: SKToolbar.Data
    var body: some View {
        let noteItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .note }
        let secondaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .secondary }
        let navigationItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .navigation }
        let primaryItems: [SKToolbarItem] = data.buttons.filter{ $0.data.placement == .primary }
        VStack{
            if #available(tvOS 26.0, *){
                VStack(spacing: 5){
                    ForEach(noteItems){ buttons in
                        buttons
                    }
                }
            }
            HStack(spacing: 10){
                ForEach(secondaryItems){ buttons in
                    buttons
                }
                Spacer()
                if #unavailable(tvOS 26.0){
                    VStack(spacing: 5){
                        ForEach(noteItems){ buttons in
                            buttons
                        }
                    }
                    Spacer()
                }
                
                if navigationItems.isEmpty, sheetSize != .medium{
                    SKToolbarItem(placement: .navigation) {SKButton("Back"){}}
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
