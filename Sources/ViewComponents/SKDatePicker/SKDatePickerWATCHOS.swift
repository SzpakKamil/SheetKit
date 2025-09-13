//
//  SKDatePickerWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKDatePickerWATCHOS: View {
    @Binding var date: Date
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    @State private var isUsingDatePicker: Bool = false
    @State private var tempDate: Date = .now
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .primary.opacity(0.1)
        }
    }
    
    var body: some View {
        Button {
            isUsingDatePicker = true
            tempDate = date
        }label:{
            VStack(alignment: .leading){
                Text(data.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(date, format: .dateTime.day().month().year())
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
        .if{ content in
            if data.components == .date{
                content
                    .accessibilityValue(Text(date, format: .dateTime.day().month().year()))
            }else{
                content
                    .accessibilityValue(Text(date, format: .dateTime.hour().minute()))
            }
        }
        .accessibilityAddTraits(.isButton)
        .fullScreenCover(isPresented: $isUsingDatePicker) {
            NavigationStack{
                VStack{
                    DatePicker(data.title, selection: $date, in: data.range ?? Date.distantPast...Date.distantFuture, displayedComponents: data.components)
                    HStack{
                        Button(SKTranslation.SKDatePicker.submit.value, role: .cancel) {
                            isUsingDatePicker = false
                            date = tempDate
                        }
                        Button(SKTranslation.SKDatePicker.submit.value, role: .destructive) {
                            tempDate = date
                        }
                    }
                }
                .navigationTitle(SKTranslation.SKDatePicker.title.value)
            }
        }
    }
    
    init(date: Binding<Date>, data: SKDatePicker.Data) {
        self._date = date
        self.data = data
    }
}
#endif
