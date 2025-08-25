//
//  SKTitle.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

extension SKTitle{
    struct Data{
        var title: LocalizedStringKey
        var key: String?
        var weight: Font.Weight
        var font: Font?
            
        init(titleKey: LocalizedStringKey) {
            self.title = titleKey
            self.weight = .bold
            self.font = nil
        }
        
        init(verbatim: String) {
            self.title = LocalizedStringKey(stringLiteral: verbatim)
            self.weight = .bold
            self.font = nil
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
    public init(_ titleKey: LocalizedStringKey){
        self.data = .init(titleKey: titleKey)
    }
    public init(verbatim: String){
        self.data = .init(verbatim: verbatim)
    }
}

#if DEBUG
struct PreviewViewSKTitle: View {
    @State private var text = "Hello World"
    @State private var font: Font? = nil
    @State private var weight: Font.Weight = .bold
    @State private var color: Color = .primary
    @State private var alignment: HorizontalAlignment? = nil
    var body: some View{
        List{
            SKTitle(verbatim: text)
                .skFont(font)
                .skFontWeight(weight)
                .skAccentColor(color)
                .skAlignment(alignment)
            
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
