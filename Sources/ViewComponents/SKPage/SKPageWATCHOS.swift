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
                }
            )
        }
        components.append(contentsOf: data.content.filter{ $0.type == .highlight })
        return components
    }
    var body: some View {
        TabView{

            ForEach(highlights.indices, id: \.self){ index in
                SKScrollView(backgroundStyle: autoStyle, toolbar: data.toolbar) {
                    highlights[index].erasedContent()
                }
            }
            
            let fields = data.content.filter{ $0.type == .field}
            
            if !fields.isEmpty{
                SKScrollView(backgroundStyle: autoStyle, toolbar: data.toolbar) {
                    VStack{
                        ForEach(fields.indices){ index in
                            fields[index].erasedContent()
                        }
                    }
                }
                .navigationTitle("Enter Fields")
            }
        }
        .toolbar{
            if isShowingBackButton{
                ToolbarItem(placement: .cancellationAction) {
                    SKToolbarItem(placement: .navigation, actionType: .dismiss) {
                        SKButton("Back", systemImage: "chevron.backward") {}
                    }
                }
            }else{
                ToolbarItem(placement: .cancellationAction) {
                    SKToolbarItem(placement: .navigation, actionType: .close) {
                        SKButton("Close", systemImage: "xmark") {}
                    }
                    .opacity(isCloseButtonHidden ? 0 : 1)
                }
            }
        }
        .tabViewStyle(.carousel)
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
