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
    
    var highlights: [SKHighlight]{
        var components: [SKHighlight] = []
        if data.content.count >= 3{
            if let headerImage = data.content[0] as? SKHeaderImage, let title = data.content[1] as? SKTitle, let description = data.content[2] as? SKDescription{
                components.append(SKHighlight(title: title.data.title, description: description.data.title, image: headerImage.data.image))
            }
            components.append(contentsOf: data.content.compactMap{ return $0 as? SKHighlight })
        }else{
            components.append(contentsOf: data.content.compactMap{ return $0 as? SKHighlight })
        }
        
        return components
    }
    var body: some View {
        TabView{
            ForEach(highlights.indices){ index in
                SKScrollView(backgroundStyle: autoStyle, toolbar: data.toolbar) {
                    highlights[index]
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
                    .opacity(data.hideCloseButton ?? isCloseButtonHidden ? 0 : 1)
                }
            }
        }
        .tabViewStyle(.carousel)
        .environment(\.alignment, data.alignment)
        .environment(\.skIsCloseButtonHidden, data.hideCloseButton ?? isCloseButtonHidden)
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
