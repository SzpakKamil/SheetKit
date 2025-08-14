//
//  SKDatePickerWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(watchOS)
public struct SKDatePickerWATCHOS: View {
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    @State private var isUsingDatePicker: Bool = false
    @State private var tempDate: Date = .now
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .primary.opacity(0.1)
        }
    }
    
    public var body: some View {
        Button {
            isUsingDatePicker = true
            tempDate = data.date.wrappedValue
        }label:{
            VStack(alignment: .leading){
                Text(data.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(data.date.wrappedValue, format: .dateTime.day().month().year())
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
        .fullScreenCover(isPresented: $isUsingDatePicker) {
            NavigationStack{
                VStack{
                    DatePicker(data.title, selection: data.date, in: data.range ?? Date.distantPast...Date.distantFuture, displayedComponents: data.components)
                    HStack{
                        Button("Submit", role: .cancel) {
                            isUsingDatePicker = false
                            data.date.wrappedValue = tempDate
                        }
                        Button("Reset", role: .destructive) {
                            tempDate = data.date.wrappedValue
                        }
                    }
                }
                .navigationTitle("Select a Date")
            }
        }
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
