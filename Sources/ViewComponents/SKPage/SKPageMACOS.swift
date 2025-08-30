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
    @Environment(\.skRowSpacing) var skRowSpacing
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
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
            SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar) {
                VStack(spacing: skRowSpacing){
                    ForEach(data.content.indices, id: \.self){index in
                        data.content[index].erasedContent()
                    }
                }
                .if{ content in
                    if data.pageStyle == .plain{
                        content
                    }else{ content
                        .padding(.top, 55)
                        .frame(width: sheetStyle.frameWidth)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            if #available(macOS 26.0, *), sheetStyle != .default{
                HStack{
                    let navigationAction = data.toolbar.items.filter{
                        $0.placement == .navigation
                    }
                    if (!isCloseButtonHidden || isShowingBackButton) {
                        SKToolbarItem(placement: .navigation, actionType: .dismiss) {
                            if isShowingBackButton{
                                SKButton("Back", systemImage: "chevron.backward") {}
                            }else{
                                SKButton("Close", systemImage: "xmark") {}
                            }
                        }
                    }
                    Spacer()
                    ForEach(navigationAction.indices) { index in
                        navigationAction[index]
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }else if sheetStyle == .prominent{
                HStack{
                    let navigationAction = data.toolbar.items.filter{
                        $0.placement == .navigation
                    }
                    if (!isCloseButtonHidden || isShowingBackButton) {
                        SKToolbarItem(placement: .navigation, actionType: .dismiss) {
                            if isShowingBackButton{
                                SKButton("Back", systemImage: "chevron.backward") {}
                            }else{
                                SKButton("Close", systemImage: "xmark") {}
                            }
                        }
                    }
                    Spacer()
                    ForEach(navigationAction.indices) { index in
                        navigationAction[index]
                    }
                    
                }
                .padding(.horizontal, 20)
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
