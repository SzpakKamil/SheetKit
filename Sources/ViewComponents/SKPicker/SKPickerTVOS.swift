//
//  SKPickerTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKPickerTVOS<SelectionValue: Hashable, Content: View, HeaderContent: View, FooterContent: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Binding var selection: SelectionValue
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    var data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            if #available(tvOS 26.0, *){
                return colorScheme == .dark ? .black.opacity(0.5) : .white.opacity(0.5)
            }else if #available(tvOS 18.0, *){
                return colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)
            }else{
                return colorScheme == .dark ? .white : .black
            }
        }
    }
    
    var body: some View {
        Menu{
            if let headerView = data.headerView{
                headerView
            }
            _VariadicView.Tree(SKPickerOptions(selectedValue: $selection)) {
                data.content
            }
            if let footerView = data.footerView{
                footerView
            }
        }label: {
            HStack(spacing: 5){
                Text(data.title)
                Spacer()
                HStack(spacing: 3){
                    Text(verbatim: String(describing: $selection))
                    Image(systemName: "chevron.up.chevron.down")
                        .fontWeight(.semibold)
                        .imageScale(.small)
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 15)
                .background(autoBackgroundColor)
                .if{ content in
                    if #available(tvOS 26.0, *){
                        content
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 50))
                    }else{
                        content
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12))
                    }
                }
            }
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            .padding(.vertical, 2)
            .padding(.leading, -7)
            .if{ content in
                if #available(tvOS 26.0, *){
                    content
                        .padding(.trailing, -21)
                }else{
                    content
                        .padding(.trailing, -24)
                }
            }
        }
        .buttonStyle(.borderedProminent)
        .if{ content in
            if #available(tvOS 26.0, *){
                content
                    .buttonBorderShape(.roundedRectangle(radius: skRowShape ?? 50))
            }else{
                content
                    .buttonBorderShape(.roundedRectangle(radius: skRowShape ?? 12))
            }
        }
        .tint(autoBackgroundColor)
        .padding(.vertical, -5)
    }
    
    init(selection: Binding<SelectionValue>, data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data) {
        self._selection = selection
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKPicker()
}
#endif
#endif
