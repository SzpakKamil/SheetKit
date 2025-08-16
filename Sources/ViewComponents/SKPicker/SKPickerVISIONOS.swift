//
//  SKPickerVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(visionOS)
struct SKPickerVISIONOS<SelectionValue: Hashable, Content: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    var data: SKPicker<SelectionValue, Content>.Data
    
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
    
    var body: some View {
        HStack{
            Text(data.title)
            Spacer()
            Menu{
                if let headerView = data.headerView{
                    headerView
                }
                _VariadicView.Tree(SKPickerOptions(selectedValue: data.selection)) {
                    data.content
                }
                if let footerView = data.footerView{
                    footerView
                }
            }label: {
                HStack(spacing: 5){
                    Text(verbatim: String(describing: data.selection.wrappedValue))
                    Image(systemName: "chevron.up.chevron.down")
                        .imageScale(.small)
                }
                .padding(.trailing, -5)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .scaleEffect(0.7)
        }
        .padding(.leading, 16)
        .padding(.trailing, -6)
        .padding(.vertical, -1)
        .background(LinearGradient(
            colors: [
                .black.opacity(0.4),
                .black.opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                .stroke(LinearGradient(
                    colors: [
                        .black.opacity(0.4),
                        .white.opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ), lineWidth: 1.25)
        )
        .contentShape(Rectangle())
        .hoverEffect()
        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
    }
    
    init(data: SKPicker<SelectionValue, Content>.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview(windowStyle: .automatic){
    PreviewViewSKPicker()
}
#endif
#endif
