//
//  SKPageTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKPageTVOS: View{
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skRowSpacing) var skRowSpacing
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
        SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar) {
            VStack(spacing: skRowSpacing){
                ForEach(data.content.indices, id: \.self){index in
                    data.content[index].erasedContent()
                }
            }
            .padding(.bottom, toolbarHeight + 10)
            .if{ content in
                if data.pageStyle == .plain{
                    content
                }else{
                    content
                        .padding(.horizontal, 30)
                        .padding(.top, 55)
                        .padding(.bottom, toolbarHeight + 10)
                }
            }

        }
    }
    
    init(data: SKPage.Data) {
        self.data = data
    }
}

#endif
