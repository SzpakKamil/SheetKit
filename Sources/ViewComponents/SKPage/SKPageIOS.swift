//
//  SKPageIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(iOS)
struct SKPageIOS: View{
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.skRowSpacing) var skRowSpacing
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var presentAlert: Bool = false
    @State private var toolbarFactor: CGFloat = 0
    @State private var toolbarHeight: CGFloat = 0
    var data: SKPageableData
    var autoStyle: SKPageBackgroundStyle{
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
        Group{
            SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar, toolbarAnimations: nil, animationValue: nil) {
                VStack(spacing: skRowSpacing){
                    ForEach(data.content.indices, id: \.self){index in
                        data.content[index].erasedContent()
                    }
                }
                .if{ content in
                    if data.pageStyle == .plain{ content }else{
                        content
                            .padding(.horizontal, 30)
                    }
                }
            }
        }
    }
    
    init(data: SKPageableData) {
        self.data = data
    }
}

#endif
