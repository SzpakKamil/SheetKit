//
//  SKTitleMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKTitleMACOS: View {
    @Environment(\.skSheetSize) var sheetSize
    @Environment(\.alignment) var alignment
    var data: SKTitle.Data
    
    var fontAuto: Font {
        if let font = data.font{
            font
        }else if #available(macOS 26.0, *), sheetSize != .small{
            .title2
        }else{
            .largeTitle
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
            if #available(macOS 26.0, *), sheetSize != .small{
                
                return .leading
            }else{
                return .center
            }
        }
    }
    
    var paddingBottomAuto: CGFloat {
        if #available(macOS 26.0, *){
            if sheetSize == .small{
                return 5
            }else{
                return -4
            }
        }else{
            return 8
        }
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
