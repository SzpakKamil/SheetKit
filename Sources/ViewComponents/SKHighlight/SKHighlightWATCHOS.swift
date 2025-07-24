//
//  SKHighlightWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

struct SKHighlightWATCHOS: View {
    @Environment(\.accentColor) var accentColor
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
                .tint(autoTintColor)
                .alignment(autoAlignment)
            SKTitle(data.title)
                .alignment(autoTextAlignment)
                .tint(autoTintColor)
            SKDescription(data.description)
                .tint(autoTintColor)
                .alignment(autoTextAlignment)
        }
    }
    
    init(data: SKHighlight.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKHighlight()
}
#endif
