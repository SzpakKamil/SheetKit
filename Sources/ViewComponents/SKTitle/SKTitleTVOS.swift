//
//  SKTitleTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKTitleTVOS: View {
    @Environment(\.skAlignment) var skAlignment
    @Environment(\.skPrimaryColor) var skPrimaryColor
    var data: SKTitle.Data
    
    var fontAuto: Font {
        if let font =  data.font{
            return font
        }else{
            if #available(tvOS 26.0, *){
                return .body
            }else{
                return .headline
            }
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
            return .leading
        }
    }
    
    var paddingBottomAuto: CGFloat {
        if #available(tvOS 26.0, *){
            return -10
        }else{
            return -2
        }
        
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
