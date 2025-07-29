//
//  SKHeaderImageVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 19/07/2025.
//

#if os(visionOS)
import SwiftUI

struct SKHeaderImageVISIONOS: View {
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    @Environment(\.alignment) var alignment
    @Environment(\.accentColor) var accentColor
    var data: SKHeaderImage.Data
    
    var autoVerticalPadding: SKHeaderImage.VerticalPadding{
        if let verticalPadding = data.verticalPadding{
            return verticalPadding
        }else{
            return .medium
        }
    }
    
    var autoAccentColor: Color{
        if let color = data.color{
            return color
        }else{
            return accentColor
        }
    }
    
    var autoAlignment: HorizontalAlignment{
        if let alignment = data.alignment{
            return alignment
        }else if let alignment{
            return alignment
        }else{
            if #available(visionOS 26.0, *){
                return .leading
            }else{
                return .center
            }
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
                .foregroundStyle(autoAccentColor.gradient)
                .fontWeight(data.weight)
                .contentTransition(.symbolEffect(.replace))
                .frame(width: data.size.rawValue, height: data.size.rawValue)
                .accessibilityHidden(true)
            
            if [HorizontalAlignment.center, .leading].contains(autoAlignment){
                Spacer()
            }
        }
        .padding(.bottom, (autoVerticalPadding).rawValue)
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
