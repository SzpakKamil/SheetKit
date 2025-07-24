//
//  SKTitleTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKTitleTVOS: View {
    @Environment(\.alignment) var alignment
    var data: SKTitle.Data
    
    var fontAuto: Font {
        data.font ?? .body
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
            return .leading
        }
    }
    
    var paddingBottomAuto: CGFloat {
        return -10
    }
    var body: some View {
        HStack {
            if [TextAlignment.trailing, .center].contains(alignmentAuto) {
                Spacer()
            }
            Text(data.title)
                .padding(.vertical, -0.25)
                .padding(.bottom, paddingBottomAuto)
                .font(fontAuto)
                .multilineTextAlignment(alignmentAuto)
                .foregroundStyle(data.color)
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
