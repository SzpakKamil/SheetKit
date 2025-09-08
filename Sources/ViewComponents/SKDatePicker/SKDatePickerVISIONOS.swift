//
//  SKDatePickerVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(visionOS)
struct SKDatePickerVISIONOS: View {
    @Binding var date: Date
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .black.opacity(0.4)
        }
    }
    
    var body: some View {
        HStack{
            Text(data.title)
            Spacer()
            DatePicker(data.title, selection: $date, in: data.range ?? Date.distantPast...Date.distantFuture, displayedComponents: data.components)
                .labelsHidden()
                .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
                .scaleEffect(0.70)
        }
        .padding(.leading, 16)
        .padding(.trailing, -12)
        .padding(.vertical, -1)
        .background(LinearGradient(
            colors: [
                autoBackgroundColor,
                autoBackgroundColor.opacity(0.75)
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                .stroke(LinearGradient(
                    colors: [
                        autoBackgroundColor,
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
    
    init(date: Binding<Date>, data: SKDatePicker.Data) {
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
