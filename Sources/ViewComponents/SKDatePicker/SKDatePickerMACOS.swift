//
//  SKDatePickerMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(macOS)
public struct SKDatePickerMACOS: View {
    @Binding var date: Date
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .clear
        }
    }
    
    public var body: some View {
        HStack{
            Text(data.title)
            Spacer()
            DatePicker(data.title, selection: $date, in: data.range ?? Date.distantPast...Date.distantFuture, displayedComponents: data.components)
                .labelsHidden()
                .scaleEffect(0.75)
        }
        .padding(.leading, 6)
        .padding(.trailing, -6.5)
        .padding(.vertical, 0.75)
        .background(autoBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
        )
        .contentShape(Rectangle())
    }
    
    public init(date: Binding<Date>, data: SKDatePicker.Data) {
        self._date = date
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKDatePicker()
}
#endif
#endif
