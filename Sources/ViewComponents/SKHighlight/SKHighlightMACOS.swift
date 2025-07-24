//
//  SKHighlightMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKHighlightMACOS: View {
    @Environment(\.accentColor) var accentColor
    @Environment(\.alignment) var alignment
    var data: SKHighlight.Data
    
    var autoSpacing: CGFloat{
        return 0
    }
    var autoAlignment: HorizontalAlignment{
        if let alignment{
           return alignment
        }else{
            return .leading
        }
    }
    var autoTextAlignment: TextAlignment{
        if let alignment{
            switch alignment{
            case .trailing:
                return .trailing
            default:
                return .leading
            }
        }else{
            return .leading
        }
    }
    
    var autoTintColor: Color{
        data.tintColor ?? accentColor
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
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(data.textColor)
                Text(data.description)
                    .font(.headline)
                    .fontWeight(.regular)
                    .if{ content in
                        if #available(macOS 14.0, *){
                            content
                                .foregroundStyle(data.textColor.secondary)
                        }else{
                            content
                                .foregroundStyle(data.textColor.opacity(0.6))
                        }
                    }
                    
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
                .foregroundStyle(autoTintColor)
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
