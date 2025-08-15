//
//  SKHighlightMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKHighlightMACOS: View {
    @Environment(\.skAccentColor) var skAccentColor
    @Environment(\.skPrimaryColor) var skPrimaryColor
    @Environment(\.skSecondaryColor) var skSecondaryColor
    @Environment(\.skAlignment) var skAlignment
    @Environment(\.skSheetStyle) var skSheetStyle
    var data: SKHighlight.Data
    
    var autoSpacing: CGFloat{
        return 0
    }
    var autoAlignment: HorizontalAlignment{
        if let skAlignment{
           return skAlignment
        }else{
            return .leading
        }
    }
    var autoTextAlignment: TextAlignment{
        if let skAlignment{
            switch skAlignment{
            case .trailing:
                return .trailing
            default:
                return .leading
            }
        }else{
            return .leading
        }
    }
    
    var autoHeadlineFont: Font{
        if skSheetStyle == .small{
            return .subheadline
        }else{
            return .headline
        }
    }
    
    var autoDescriptionFont: Font{
        if skSheetStyle == .small{
            return .subheadline
        }else{
            return .headline
        }
    }
    
    var autoPrimaryTextColor: Color{
        if let skPrimaryColor{
            skPrimaryColor
        }else{
            .primary
        }
    }
    
    var autoSecondaryTextColor: Color{
        if let skSecondaryColor{
            return skSecondaryColor
        }else if let skPrimaryColor{
            return skPrimaryColor.opacity(0.6)
        }else{
            if #available(iOS 17.0, *){
                return .secondary
            }else{
                return .primary.opacity(0.6)
            }
        }
    }
    
    
    var body: some View {
        HStack(alignment: .top) {
            if [.trailing].contains(autoAlignment){
                Spacer()
            }
            
            if [HorizontalAlignment.center, .leading].contains(autoAlignment){
                imageView()
            }

            VStack(alignment: autoAlignment == .trailing ? .trailing : .leading, spacing: autoSpacing) {
                Text(data.title)
                    .font(autoHeadlineFont)
                    .fontWeight(.semibold)
                    .foregroundStyle(autoPrimaryTextColor)
                Text(data.description)
                    .font(autoDescriptionFont)
                    .fontWeight(.regular)
                    .foregroundStyle(autoSecondaryTextColor)
            }
            .multilineTextAlignment(autoTextAlignment)
            .padding(.top, -2)
            
            if [HorizontalAlignment.trailing].contains(autoAlignment){
                imageView()
            }
            
            if [HorizontalAlignment.center, .leading].contains(autoAlignment){
                Spacer()
            }
        }
        .padding(.bottom, 14)
    }
    
    private func imageView() -> some View {
        VStack(alignment: .leading){
            data.image
                .resizable()
                .scaledToFit()
                .frame(width: 33, height: 33)
                .if{ content in
                    if #available(macOS 26.0, *){
                        content.fontWeight(.light)
                    }else{
                        content
                    }
                }
                .frame(width: 50)
                .foregroundStyle(skAccentColor)
                .accessibilityHidden(true)
            
        }
    }
    
    init(data: SKHighlight.Data) {
        self.data = data
    }
}
#endif
#if DEBUG

#Preview {
    PreviewViewSKHighlight()
}
#endif
