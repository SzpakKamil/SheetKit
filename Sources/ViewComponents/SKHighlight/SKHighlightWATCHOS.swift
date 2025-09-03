//
//  SKHighlightWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKHighlightWATCHOS: View {
    var data: SKHighlight.Data

    var body: some View {
        VStack{
            SKHeaderImage(image: data.image)
            SKTitle(data.title)
            SKDescription(data.description)
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
