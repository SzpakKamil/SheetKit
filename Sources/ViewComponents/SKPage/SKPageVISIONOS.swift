//
//  SKPageVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(visionOS)
struct SKPageVISIONOS: View{
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var presentAlert: Bool = false
    @State private var toolbarFactor: CGFloat = 0
    @State private var toolbarHeight: CGFloat = 0
    var data: SKPage.Data
    var autoStyle: SKPage.BackgroundStyle{
        if let backgroundStyle = data.backgroundStyle{
            return backgroundStyle
        }else{
            if data.content.contains(where: { $0.type == .field}){
                return .form
            }else{
                return .list
            }
        }
    }

    var body: some View {
            SKScrollView(backgroundStyle: autoStyle, toolbar: data.toolbar) {
                ForEach(data.content.indices, id: \.self){index in
                    data.content[index].erasedContent()
                }
            }
            .toolbar {
                let navigationButtons = data.toolbar.data.buttons.filter{ $0.data.placement == .navigation}
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !isCloseButtonHidden{
                        SKToolbarItem(placement: .navigation, actionType: .close) {
                            SKButton("Close", systemImage: "xmark"){}
                        }
                    }
                    ForEach(navigationButtons) { button in
                        button
                    }
                }
            }
    }
    
    init(data: SKPage.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewSKPageContent()
}
#endif
#endif
