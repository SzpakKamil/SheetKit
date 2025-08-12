//
//  SKPickerWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKPickerWATCHOS<SelectionValue: Hashable, Content: View>: View, SKComponent {
    let type: SKComponentType = .field
    var data: SKPicker<SelectionValue, Content>.Data
    @State private var isUsingPicker = false
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .primary.opacity(0.1)
        }
    }
    
    var body: some View {
        Button {
            isUsingPicker = true
        }label:{
            VStack(alignment: .leading){
                Text(data.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(verbatim: String(describing: data.selection.wrappedValue))
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 100, style: .continuous))
        }
        .buttonStyle(.plain)
        .fullScreenCover(isPresented: $isUsingPicker) {
            NavigationStack{
                List{
                    if let headerView = data.headerView{
                        headerView
                    }
                    _VariadicView.Tree(SKPickerOptions(selectedValue: data.selection)) {
                        data.content
                    }
                    if let footerView = data.footerView{
                        footerView
                    }
                }
                .navigationTitle("Select Value")
            }
        }
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
