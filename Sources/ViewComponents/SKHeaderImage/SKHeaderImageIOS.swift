//
//  SKHeaderImageIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

#if os(iOS)
import SwiftUI

struct SKHeaderImageIOS: View {
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    @Environment(\.skAlignment) var skAlignment
    @Environment(\.skIsUsingFullScreenCover) var skIsUsingFullScreenCover
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.skAccentColor) var skAccentColor
    var data: SKHeaderImage.Data
    
    var autoVerticalPadding: SKHeaderImage.VerticalPadding{
        if let verticalPadding = data.verticalPadding{
            return verticalPadding
        }else{
            if #available(iOS 26.0, *){
                return .medium
            }else{
                return .small
            }
        }
    }
    
    var autoSize: SKHeaderImage.Size{
        if let size = data.size{
            return size
        }else{
            return .medium
        }
    }
    
    var autoAlignment: HorizontalAlignment{
        if let skAlignment{
            return skAlignment
        }else{
            if #available(iOS 26.0, *), skIsUsingFullScreenCover && horizontalSizeClass == .regular{
                return .leading
            }else{
                return .center
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0){
            if [HorizontalAlignment.center, .trailing].contains(autoAlignment){
                Spacer()
            }
            data.image
                .resizable()
                .scaledToFit()
                .symbolVariant(data.variant.getSymbolVariant())
                .symbolRenderingMode(data.renderingMode.getSymbolRenderingMode())
                .foregroundStyle(skAccentColor)
                .fontWeight(data.weight)
                .if{content in
                    if #available(iOS 17.0, *), !accessibilityReduceMotion{
                        content
                            .contentTransition(.symbolEffect(.replace))
                    }else{
                        content
                    }
                }
                .frame(width: autoSize.rawValue, height: autoSize.rawValue)
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
