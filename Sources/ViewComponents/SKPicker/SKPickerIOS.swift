//
//  SKPickerIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(iOS)
struct SKPickerIOS<SelectionValue: Hashable, Content: View, HeaderContent: View, FooterContent: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Binding var selection: SelectionValue
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    var isUsingPicker: String = ""
    var data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data
    
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
                _VariadicView.Tree(SKPickerOptions(selectedValue: $selection)) {
                    data.content
                }
                if let footerView = data.footerView{
                    footerView
                }
            }label: {
                HStack(spacing: 5){
                    Text(verbatim: String(describing: selection))
                        .font(.callout)
                    Image(systemName: "chevron.up.chevron.down")
                        .imageScale(.small)
                }
                .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            .tint(.primary)
        }
        .padding(.vertical, 13)
        .padding(.leading)
        .padding(.trailing)
        .background(autoBackgroundColor)
        .if{ content in
            if #available(iOS 26.0, *){
                content
                    .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
            }else{
                content
                    .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 13, style: .continuous))
            }
        }
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityValue(Text(verbatim: String(describing: selection)))
        .accessibilityRemoveTraits(.isButton)
        
    }
    
    init(selection: Binding<SelectionValue>, data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data) {
        self._selection = selection
        self.data = data
    }
}

#endif
