//
//  SKPageMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKPageMACOS: View{
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
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
        ZStack(alignment: .top){
            SKScrollView(backgroundStyle: autoStyle, toolbar: data.toolbar) {
                ForEach(data.content.indices, id: \.self){index in
                    data.content[index].erasedContent()
                }
                .frame(width: sheetStyle.frameWidth)
                .frame(maxWidth: .infinity)
            }
            if sheetStyle != .default{
                HStack{
                    let navigationAction = data.toolbar.data.buttons.filter{
                        $0.data.placement == .navigation
                    }
                    if navigationAction.isEmpty && (!(data.hideCloseButton ?? isCloseButtonHidden) || isShowingBackButton) {
                        SKToolbarItem(placement: .navigation, actionType: .dismiss) {
                            if isShowingBackButton{
                                SKButton("Back", systemImage: "chevron.backward") {}
                            }else{
                                SKButton("Close", systemImage: "xmark") {}
                            }
                        }
                    }else{
                        ForEach(navigationAction) { button in
                            button
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 20)
            }
        }
        .frame(width: sheetStyle.windowWidth, height: sheetStyle.height)
            
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
