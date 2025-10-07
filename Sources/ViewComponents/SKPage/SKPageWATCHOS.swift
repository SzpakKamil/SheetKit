//
//  SKPageWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKPageWATCHOS: View{
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.skRowSpacing) var skRowSpacing
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skIsCloseButtonHidden) var isCloseButtonHidden
    @Environment(\.skIsShowingBackButton) var isShowingBackButton
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
    var header: [SKComponent] { data.content.filter{ $0.type == .header } }
    var highlights: [SKComponent]{
        var components: [SKComponent] = []
        if !header.isEmpty{
            components.append(
                SKCustomView(type: .highlight) {
                    VStack{
                        ForEach(header.indices){ index in
                            header[index].erasedContent()
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            )
        }
        components.append(contentsOf: data.content.filter{ $0.type == .highlight })
        return components
    }
    var body: some View {
        Group{
            if data.pageStyle != .plain{
                TabView{
                    let fields = data.content.filter{ $0.type == .field}
                    let customView = data.content.filter{ $0.type == .customView}
                    if highlights.isEmpty && fields.isEmpty{
                        SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar, toolbarAnimations: nil, animationValue: nil) {
                            SKHighlight(titleVerbatim: "", descriptionVerbatim: "", systemName: "")
                        }
                    }else{
                        ForEach(highlights.indices, id: \.self){ index in
                            SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar, toolbarAnimations: nil, animationValue: nil) {
                                highlights[index].erasedContent()
                            }
                        }
                    }
                    if !customView.isEmpty{
                        SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar, toolbarAnimations: nil, animationValue: nil) {
                            VStack(spacing: skRowSpacing){
                                ForEach(customView.indices){ index in
                                    customView[index].erasedContent()
                                }
                            }
                        }
                    }
                    
                    
                    if !fields.isEmpty{
                        SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar, toolbarAnimations: nil, animationValue: nil) {
                            VStack(spacing: skRowSpacing){
                                ForEach(fields.indices){ index in
                                    fields[index].erasedContent()
                                }
                            }
                        }
                        .navigationTitle(SKTranslation.SKPicker.title.value)
                    }
                }
            }else{
                SKScrollView(pageStyle: data.pageStyle ?? .default, backgroundStyle: autoStyle, toolbar: data.toolbar, toolbarAnimations: nil, animationValue: nil) {
                    VStack(spacing: skRowSpacing){
                        ForEach(data.content.indices){ index in
                            data.content[index].erasedContent()
                        }
                    }
                }

            }
        }
        .toolbar{
            if isShowingBackButton{
                ToolbarItem(placement: .cancellationAction) {
                    SKToolbarItem(placement: .navigation, actionType: .dismiss) {
                        SKButton(verbatim: SKTranslation.SKButton.back.value, systemImage: "chevron.backward") {}
                    }
                }
            }else{
                ToolbarItem(placement: .cancellationAction) {
                    SKToolbarItem(placement: .navigation, actionType: .close) {
                        SKButton(verbatim: SKTranslation.SKButton.close.value, systemImage: "xmark") {}
                    }
                    .opacity(isCloseButtonHidden ? 0 : 1)
                }
            }
        }
        .tabViewStyle(.carousel)
    }
    
    init(data: SKPageableData) {
        self.data = data
    }
}
#endif
