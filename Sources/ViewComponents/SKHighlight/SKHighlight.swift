//
//  SKHighlight.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

extension SKHighlight{
    struct Data{
        var title: LocalizedStringKey
        var description: LocalizedStringKey
        var image: Image
        var tintColor: Color?
            
        init(title: LocalizedStringKey, description: LocalizedStringKey, image: Image, tintColor: Color? = nil) {
            self.title = title
            self.description = description
            self.image = image
            self.tintColor = tintColor
        }
        init(titleVerbatim: String, descriptionVerbatim: String, image: Image, tintColor: Color? = nil) {
            self.title = LocalizedStringKey(stringLiteral: titleVerbatim)
            self.description = LocalizedStringKey(stringLiteral: descriptionVerbatim)
            self.image = image
            self.tintColor = tintColor
        }
    }
}

public struct SKHighlight: View, SKComponent {

    public let type: SKComponentType = .highlight
    var data: SKHighlight.Data
    
    public var body: some View {
        #if os(iOS)
        SKHighlightIOS(data: data)
        #elseif os(macOS)
        SKHighlightMACOS(data: data)
        #elseif os(tvOS)
        SKHighlightTVOS(data: data)
        #elseif os(visionOS)
        SKHighlightVISIONOS(data: data)
        #elseif os(watchOS)
        SKHighlightWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }
    
    public init(title: LocalizedStringKey, description: LocalizedStringKey, image: Image) {
        self.data = .init(title: title, description: description, image: image)
    }
    
    public init(title: LocalizedStringKey, description: LocalizedStringKey, systemName: String) {
        self.data = .init(title: title, description: description, image: Image(systemName: systemName))
    }
    
    public init(titleVerbatim: String, descriptionVerbatim: String, image: Image) {
        self.data = .init(titleVerbatim: titleVerbatim, descriptionVerbatim: descriptionVerbatim, image: image)
    }
    
    public init(titleVerbatim: String, descriptionVerbatim: String, systemName: String) {
        self.data = .init(titleVerbatim: titleVerbatim, descriptionVerbatim: descriptionVerbatim, image: Image(systemName: systemName))
    }
}

#if DEBUG
struct PreviewViewSKHighlight: View {
    @State private var title = "Hello World"
    @State private var description = "Hello World wjfhawh fhewdhne whfdwe hdwhe"
    @State private var systemName = "siri"
    @State private var tintColor = Color.accentColor
    @State private var textColor = Color.primary
    var body: some View{
        List{
            SKHighlight(titleVerbatim: title, descriptionVerbatim: description, systemName: systemName)
                .skAlignment(.leading)
                .skPrimaryTextColor(textColor)
            Section{
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                Picker("SystemName", selection: $systemName) {
                    ForEach(["siri", "wifi", "airpods.max", "music.note", "signature"], id: \.self){ name in
                        Text(name.capitalized)
                    }
                }

            }
        }
        #if os(macOS)
        .listStyle(.sidebar)
        #endif
    }
}
#Preview {
    PreviewViewSKHighlight()
}
#endif
