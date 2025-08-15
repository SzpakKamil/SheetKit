//
//  SKHeaderImageMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

#if os(macOS)
import SwiftUI

struct SKHeaderImageMACOS: View {
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    @Environment(\.skSheetStyle) var skSheetStyle
    @Environment(\.skAlignment) var skAlignment
    @Environment(\.skAccentColor) var skAccentColor
    var data: SKHeaderImage.Data
    
    var autoVerticalPadding: SKHeaderImage.VerticalPadding{
        if let verticalPadding = data.verticalPadding{
            return verticalPadding
        }else{
            return .medium
        }
    }
    
    var autoSize: SKHeaderImage.Size{
        if let size = data.size{
            return size
        }else{
            if skSheetStyle == .prominent{
                return .small
            }else{
                return .medium
            }
        }
    }

    var autoAlignment: HorizontalAlignment{
        if let skAlignment{
            return skAlignment
        }else{
            if #available(macOS 26.0, *), skSheetStyle != .prominent{
                return .leading
            }else{
                return .center
            }
        }
    }
    var autoLeadingPadding: CGFloat{
        if skSheetStyle == .compact{
            return 5
        }else{
            return 0
        }
    }
    var autoTopPadding: CGFloat{
        if skSheetStyle == .compact{
            return 3
        }else{
            return 0
        }
    }
    
    var body: some View {
        HStack{
            if [HorizontalAlignment.center, .trailing].contains(autoAlignment){
                Spacer()
            }
            data.image
                .resizable()
                .scaledToFit()
                .symbolVariant(data.variant.getSymbolVariant())
                .symbolRenderingMode(data.renderingMode.getSymbolRenderingMode())
                .foregroundStyle(skAccentColor.gradient)
                .fontWeight(data.weight)
                .if{content in
                    if #available(macOS 14.0, *), !accessibilityReduceMotion{
                        content
                            .contentTransition(.symbolEffect(.replace))
                    }else{
                        content
                    }
                }
                .frame(width: autoSize.rawValue, height: autoSize.rawValue)
                .padding(.leading, autoLeadingPadding)
                .padding(.top, autoTopPadding)
                .accessibilityHidden(true)
            
            if [HorizontalAlignment.center, .leading].contains(autoAlignment){
                Spacer()
            }
        }
        .padding(.vertical, (autoVerticalPadding).rawValue)
    }
    
    init(data: SKHeaderImage.Data) {
        self.data = data
    }

}
#endif

#if os(DEBUG)
#Preview {
    PreviewViewSKHeaderImage()
}
#endif
