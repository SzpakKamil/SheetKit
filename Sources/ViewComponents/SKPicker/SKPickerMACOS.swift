//
//  SKPickerMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKPickerMACOS<SelectionValue: Hashable, Content: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Environment(\.colorScheme) var colorScheme
    var data: SKPicker<SelectionValue, Content>.Data
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
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
                _VariadicView.Tree(SKPickerOptions(selectedValue: data.selection)) {
                    data.content
                }
                if let footerView = data.footerView{
                    footerView
                }
            }label: {
                HStack(spacing: 2){
                    Text(verbatim: String(describing: data.selection.wrappedValue))
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
        .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: data.cornerRadius ?? 6, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
        )
        .contentShape(Rectangle())
    }
    
    init(data: SKPicker<SelectionValue, Content>.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKPicker()
}
#endif
#endif
