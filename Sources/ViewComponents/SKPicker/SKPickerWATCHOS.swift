//
//  SKPickerWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKPickerWATCHOS<SelectionValue: Hashable, Content: View, HeaderContent: View, FooterContent: View>: View, SKComponent {
    let type: SKComponentType = .field
    @Binding var selection: SelectionValue
    var data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @State private var isUsingPicker = false
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
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
                Text(verbatim: String(describing: selection))
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(data.title)
        .accessibilityValue(Text(verbatim: String(describing: selection)))
        .accessibilityAddTraits(.isButton)
        .fullScreenCover(isPresented: $isUsingPicker) {
            NavigationStack{
                List{
                    if let headerView = data.headerView{
                        headerView
                            .simultaneousGesture(TapGesture().onEnded{isUsingPicker.toggle()})
                    }
                    _VariadicView.Tree(SKPickerOptions(selectedValue: $selection)) {
                        data.content
                    }
                    if let footerView = data.footerView{
                        footerView
                            .simultaneousGesture(TapGesture().onEnded{isUsingPicker.toggle()})
                    }
                }
                .navigationTitle(SKTranslation.SKPicker.title.value)
            }
        }
    }
    
    init(selection: Binding<SelectionValue>, data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data) {
        self._selection = selection
        self.data = data
    }
}

#endif
