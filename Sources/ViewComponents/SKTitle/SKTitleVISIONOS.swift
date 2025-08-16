//
//  SKTitleVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

import SwiftUI

#if os(visionOS)
struct SKTitleVISIONOS: View {
    @Environment(\.skAlignment) var skAlignment
    @Environment(\.skPrimaryColor) var skPrimaryColor
    var data: SKTitle.Data
    
    var fontAuto: Font {
        if let font = data.font{
            font
        }else if #available(visionOS 26.0, *){
            .title2
        }else{
            .largeTitle
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
            if #available(visionOS 26.0, *){
                return .leading
            }else{
                return .center
            }
        }
    }
    
    var paddingBottomAuto: CGFloat {
        return 10
    }
    var body: some View {
        HStack {
            if [TextAlignment.trailing, .center].contains(alignmentAuto) {
                Spacer()
            }
            Text(data.title)
                .lineSpacing(3)
                .padding(.vertical, -0.25)
                .padding(.bottom, paddingBottomAuto)
                .font(fontAuto)
                .multilineTextAlignment(alignmentAuto)
                .foregroundStyle(skPrimaryColor ?? .primary)
                .fontWeight(data.weight)
                
            if [TextAlignment.leading, .center].contains(alignmentAuto)  {
                Spacer()
            }
        }
        .accessibilityElement()
        .accessibilityLabel(data.title)
        .accessibilityAddTraits([.isHeader, .isStaticText])
    }
    
    init(data: SKTitle.Data) {
        self.data = data
    }
}
#endif

#if DEBUG
#Preview {
    PreviewViewSKTitle()
}
#endif
