//
//  SKFieldsSection.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/08/2025.
//

import SwiftUI

#if os(iOS) || os(macOS)
public extension SKFieldsSection{
    struct Data{
        let content: [any SKComponent]
        public init(@SKPageBuilder content: () -> [any SKComponent]) {
            self.content = content()
        }
    }
}
public struct SKFieldsSection: SKComponent {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowSpacing) var skRowSpacing
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    public let type: SKComponentType = .field
    var data: SKFieldsSection.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
        }
    }
    
    public var body: some View {
        VStack(spacing: skRowSpacing ?? 0){
            ForEach(data.content.indices){ index in
                data.content[index].erasedContent()
                if index != data.content.count - 1 && (skRowSpacing == nil || skRowSpacing == 0){
                    Divider()
                }
            }
        }
        .environment(\.skIsInSection, skRowSpacing == 0 || skRowSpacing == nil)
        #if os(iOS)
        .background(skRowSpacing == nil || skRowSpacing == 0 ? autoBackgroundColor : .clear)
        .if{ content in
            if skRowSpacing == nil || skRowSpacing == 0{
                if #available(iOS 26.0, *){
                    content
                        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 24, style: .continuous))
                }else{
                    content
                        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 13, style: .continuous))
                }
            }else{
                content
            }
        }
        #else
        .if{ content in
            if skRowSpacing == nil || skRowSpacing == 0{
                content
                    .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                            .stroke(.primary.opacity(0.06), lineWidth: 1)
                    )
            }else{
                content
            }
        }

        #endif
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent]) {
        self.data = .init(content: content)
    }
}
#endif
