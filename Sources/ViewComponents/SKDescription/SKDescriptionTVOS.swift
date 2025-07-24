//
//  SKDescriptionTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKDescriptionTVOS: View {
    @Environment(\.alignment) var alignment
    var data: SKDescription.Data
    
    var fontAuto: Font {
        if let font = data.font{
            font
        }else{
            .body
        }
    }
    var colorAuto: Color {
        if let color = data.color{
            color
        }else if #available(tvOS 26.0, *){
            .secondary
        }else{
            .primary
        }
    }

    var alignmentAuto: TextAlignment {
        if let alignment = data.alignment{
            return alignment
        }else if let alignment {
            switch alignment{
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            default:
                return .center
            }
        }else{
            if #available(tvOS 26.0, *){
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
                .padding(.bottom, 8)
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
