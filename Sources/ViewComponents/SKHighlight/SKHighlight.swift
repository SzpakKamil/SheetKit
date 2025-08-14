//
//  SKHighlight.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

public extension SKHighlight{
    struct Data{
        var title: String
        var description: String
        var image: Image
        var tintColor: Color?
            
        public init(title: String, description: String, image: Image, tintColor: Color? = nil) {
            self.title = title
            self.description = description
            self.image = image
            self.tintColor = tintColor
        }
        
        public init(title: String, description: String, systemName: String, tintColor: Color? = nil) {
            self.title = title
            self.description = description
            self.image = Image(systemName: systemName)
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
    
    public init(data: SKHighlight.Data) {
        self.data = data
    }
    
    public init(title: String, description: String, image: Image) {
        self.data = .init(title: title, description: description, image: image)
    }
    
    public init(title: String, description: String, systemName: String) {
        self.data = .init(title: title, description: description, systemName: systemName)
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
            SKHighlight(title: title, description: description, systemName: systemName)
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
