//
//  SKDatePickerWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(watchOS)
public struct SKDatePickerWATCHOS: View {
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
    
    public var body: some View {
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
        .fullScreenCover(isPresented: $isUsingDatePicker) {
            NavigationStack{
                VStack{
                    DatePicker(data.title, selection: $date, in: data.range ?? Date.distantPast...Date.distantFuture, displayedComponents: data.components)
                    HStack{
                        Button("Submit", role: .cancel) {
                            isUsingDatePicker = false
                            date = tempDate
                        }
                        Button("Reset", role: .destructive) {
                            tempDate = date
                        }
                    }
                }
                .navigationTitle("Select a Date")
            }
        }
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
