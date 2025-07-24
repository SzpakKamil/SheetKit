//
//  SKDatePickerWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(watchOS)
public struct SKDatePickerWATCHOS: View {
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
            HStack{
                Text(data.title)
                    .lineLimit(1)
                Spacer()
                HStack(spacing: 5){
                    Text(data.date.wrappedValue, format: .dateTime.day().month().year())
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 10)
                .clipShape(.capsule)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
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
#Preview{
    VStack{
        SKDatePickerWATCHOS(data: .init(title: "Date", selection: .constant(.now)))
    }
}
#endif
#endif
