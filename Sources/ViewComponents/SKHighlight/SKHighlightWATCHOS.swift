//
//  SKHighlightWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKHighlightWATCHOS: View {
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.alignment) var alignment
    var data: SKHighlight.Data
    
    var autoSpacing: CGFloat{
        return 5
    }
    var autoAlignment: HorizontalAlignment{
        if let alignment{
           return alignment
        }else{
            return .center
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
            return .center
        }
    }
    
    var autoTintColor: Color{
        data.tintColor ?? accentColor
    }
    
    var body: some View {
        VStack{
            SKHeaderImage(image: data.image)
                .skTint(autoTintColor)
                .skAlignment(autoAlignment)
            SKTitle(data.title)
                .skAlignment(autoTextAlignment)
                .skTint(.primary)
            SKDescription(data.description)
                .skTint(.secondary)
                .skAlignment(autoTextAlignment)
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
