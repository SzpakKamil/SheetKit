//
//  SKPickerIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(iOS)
struct SKPickerIOS<SelectionValue: Hashable, Content: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Environment(\.colorScheme) var colorScheme
    var data: SKPicker<SelectionValue, Content>.Data
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
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
                    .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 100, style: .continuous))
            }else{
                content
                    .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 13, style: .continuous))
            }
        }
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
