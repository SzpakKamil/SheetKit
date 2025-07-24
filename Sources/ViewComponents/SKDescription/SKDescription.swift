//
//  SKTitle.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

public extension SKDescription{
    struct Data{
        var title: String
        var weight: Font.Weight
        var font: Font?
        var color: Color?
        var alignment: TextAlignment?
            
        public init(title: String, weight: Font.Weight = .regular, font: Font? = nil, color: Color? = nil, alignment: TextAlignment? = nil) {
            self.title = title
            self.weight = weight
            self.font = font
            self.color = color
            self.alignment = alignment
        }
    }
}

public struct SKDescription: View, SKComponent {
    public let type: SKComponentType = .header
    var data: SKDescription.Data
    
    public var body: some View {
        #if os(iOS)
        SKDescriptionIOS(data: data)
        #elseif os(macOS)
        SKDescriptionMACOS(data: data)
        #elseif os(tvOS)
        SKDescriptionTVOS(data: data)
        #elseif os(visionOS)
        SKDescriptionVISIONOS(data: data)
        #elseif os(watchOS)
        SKDescriptionWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }
    
    public init(data: SKDescription.Data) {
        self.data = data
    }
    
    public init(_ title: String){
        self.data = .init(title: title)
    }

}

#if DEBUG
struct PreviewViewSKDescription: View {
    @State private var text = "Hello World Hello World Hello World Hello World Hello World"
    @State private var font: Font? = nil
    @State private var weight: Font.Weight = .regular
    @State private var color: Color? = nil
    @State private var alignment: TextAlignment? = nil
    var body: some View{
        List{
            VStack{
                SKDescription(text)
                    .font(font)
                    .tint(color)
                    .alignment(alignment)
                    .weight(weight)
            }
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
#if DEBUG
#Preview {
    PreviewViewSKDescription()
}
#endif
#endif
