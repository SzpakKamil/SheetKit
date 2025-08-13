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
    @Environment(\.skSheetSize) var sheetSize
    @Environment(\.alignment) var alignment
    @Environment(\.skAccentColor) var accentColor
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
            if sheetSize == .small{
                return .small
            }else{
                return .medium
            }
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
            if #available(macOS 26.0, *), sheetSize != .small{
                return .leading
            }else{
                return .center
            }
        }
    }
    var autoLeadingPadding: CGFloat{
        if sheetSize == .medium{
            return 5
        }else{
            return 0
        }
    }
    var autoTopPadding: CGFloat{
        if sheetSize == .medium{
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
                .foregroundStyle(autoAccentColor.gradient)
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
