//
//  SKPickerMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKPickerMACOS<SelectionValue: Hashable, Content: View, HeaderContent: View, FooterContent: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Binding var selection: SelectionValue
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    var data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .clear
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
                HStack(spacing: 2){
                    Text(verbatim: String(describing: selection))
                        .font(.subheadline)
                    Image(systemName: "chevron.up.chevron.down")
                        .fontWeight(.semibold)
                        .imageScale(.small)
                }
                .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            .tint(.primary)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(autoBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
        )
        .contentShape(Rectangle())
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
