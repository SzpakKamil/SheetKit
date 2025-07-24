//
//  SKTitle.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

public extension SKTitle{
    struct Data{
        var title: String
        var weight: Font.Weight
        var font: Font?
        var color: Color
        var alignment: TextAlignment?
            
        public init(title: String, weight: Font.Weight = .bold, font: Font? = nil, color: Color = .primary, alignment: TextAlignment? = nil) {
            self.title = title
            self.weight = weight
            self.font = font
            self.color = color
            self.alignment = alignment
        }
    }
}

public struct SKTitle: View, SKComponent {

    public let type: SKComponentType = .header
    var data: SKTitle.Data
    public var body: some View {
        #if os(iOS)
        SKTitleIOS(data: data)
        #elseif os(macOS)
        SKTitleMACOS(data: data)
        #elseif os(tvOS)
        SKTitleTVOS(data: data)
        #elseif os(visionOS)
        SKTitleVISIONOS(data: data)
        #elseif os(watchOS)
        SKTitleWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }
    
    public init(data: SKTitle.Data) {
        self.data = data
    }
    
    public init(_ title: String){
        self.data = .init(title: title)
    }
}

#if DEBUG
struct PreviewViewSKTitle: View {
    @State private var text = "Hello World"
    @State private var font: Font? = nil
    @State private var weight: Font.Weight = .bold
    @State private var color: Color = .primary
    @State private var alignment: TextAlignment? = nil
    var body: some View{
        List{
            SKTitle(text)
                .font(font)
                .tint(color)
                .alignment(alignment)
                .weight(weight)
            
            Section{
                let fonts: [Font?] = [nil, .largeTitle, .title, .title2, .title3, .headline, .subheadline, .body, .callout, .footnote, .caption, .caption2]
                let alignments: [TextAlignment?] = [nil, .leading, .center, .trailing]
                TextField("Text", text: $text)
                Picker("Font", selection: $font){
                    ForEach(fonts, id: \.self){ font in
                        switch font{
                        case .largeTitle:
                            Text("Large Title")
                        case .title:
                            Text("Title")
                        case .title2:
                            Text("Title 2")
                        case .title3:
                            Text("Title 3")
                        case .headline:
                            Text("Headline")
                        case .subheadline:
                            Text("Subheadline")
                        case .body:
                            Text("Body")
                        case .callout:
                            Text("Callout")
                        case .footnote:
                            Text("Footnote")
                        case .caption:
                            Text("Caption")
                        case .caption2:
                            Text("Caption 2")
                        case .none:
                            Text("Auto")
                        default:
                            Text("Default")
                        }
                    }
                }
                Picker("Weight", selection: $weight){
                    ForEach([Font.Weight.black, .heavy, .bold, .semibold, .medium, .regular, .light, .ultraLight], id: \.self){ weight in
                        switch weight{
                        case .black:
                            Text("Black")
                        case .heavy:
                            Text("Heavy")
                        case .bold:
                            Text("Bold")
                        case .semibold:
                            Text("Semibold")
                        case .medium:
                            Text("Medium")
                        case .regular:
                            Text("Regular")
                        case .light:
                            Text("Light")
                        case .ultraLight:
                            Text("Ultra Light")
                        default:
                            Text("Default")
                        }
                    }
                }

                Picker("Alignment", selection: $alignment){
                    ForEach(alignments, id: \.self){ alignment in
                        switch alignment {
                        case .leading:
                            Text("Leading")
                        case .center:
                            Text("Center")
                        case .trailing:
                            Text("Trailing")
                        case nil:
                            Text("Auto")
                        }
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
    PreviewViewSKTitle()
}
#endif
