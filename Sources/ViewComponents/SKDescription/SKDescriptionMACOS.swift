//
//  SKDescriptionMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKDescriptionMACOS: View {
    @Environment(\.skAlignment) var skAlignment
    @Environment(\.skPrimaryColor) var skPrimaryColor
    @Environment(\.skSecondaryColor) var skSecondaryColor
    @Environment(\.skSheetStyle) var skSheetStyle
    var data: SKDescription.Data
    
    var fontAuto: Font {
        if let font = data.font{
            font
        }else if #available(macOS 26.0, *), skSheetStyle != .prominent{
            .title2
        }else{
            .body
        }
    }
    var colorAuto: Color {
        if #available(macOS 26.0, *){
            return skSecondaryColor ?? .secondary
        }else{
            return skPrimaryColor ?? .primary
        }
    }

    var alignmentAuto: TextAlignment {
        if let skAlignment {
            switch skAlignment{
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            default:
                return .center
            }
        }else{
            if #available(macOS 26.0, *), skSheetStyle != .prominent{
                return .leading
            }else{
                return .center
            }
        }
    }
    
    var body: some View {
        HStack {
            if [TextAlignment.trailing, .center].contains(alignmentAuto) {
                Spacer()
            }
            Text(data.title)
                .font(fontAuto)
                .multilineTextAlignment(alignmentAuto)
                .lineSpacing(3)
                .padding(.bottom, 20)
                .foregroundStyle(colorAuto)
                .fontWeight(data.weight)

            if [TextAlignment.leading, .center].contains(alignmentAuto)  {
                Spacer()
            }
        }
        .accessibilityElement()
        .accessibilityLabel(data.title)
        .accessibilityAddTraits([.isHeader, .isStaticText])
    }
    
    init(data: SKDescription.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKDescription()
}
#endif
#endif
