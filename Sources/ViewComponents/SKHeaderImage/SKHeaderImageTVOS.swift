//
//  SKHeaderImageTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

#if os(tvOS)
import SwiftUI

struct SKHeaderImageTVOS: View {
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    @Environment(\.skAlignment) var skAlignment
    @Environment(\.skIsUsingFullScreenCover) var skIsUsingFullScreenCover
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
            return .medium
        }
    }
    
    
    var autoAlignment: HorizontalAlignment{
        if let skAlignment{
            return skAlignment
        }else{
            if #available(tvOS 26.0, *), !skIsUsingFullScreenCover{
                return .center
            }else{
                return .leading
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
                .foregroundStyle(skAccentColor.gradient)
                .fontWeight(data.weight)
                .contentTransition(.symbolEffect(.replace))
                .frame(width: autoSize.rawValue, height: autoSize.rawValue)
            
            if [HorizontalAlignment.center, .leading].contains(autoAlignment){
                Spacer()
            }
        }
        .padding(.vertical, (autoVerticalPadding).rawValue)
        .accessibilityHidden(true)
    }
    
    init(data: SKHeaderImage.Data) {
        self.data = data
    }

}

#endif
