//
//  SKDatePickerMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(macOS)
public struct SKDatePickerMACOS: View {
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .clear
        }
    }
    
    public var body: some View {
        HStack{
            Text(data.title)
            Spacer()
            DatePicker(data.title, selection: data.date, in: data.range ?? Date.distantPast...Date.distantFuture, displayedComponents: data.components)
                .labelsHidden()
                .scaleEffect(0.75)
        }
        .padding(.leading, 6)
        .padding(.trailing, -6.5)
        .padding(.vertical, 0.75)
        .background(autoBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: data.cornerRadius ?? 6, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
        )
        .contentShape(Rectangle())
    }
    
    public init(data: SKDatePicker.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKDatePicker()
}
#endif
#endif
