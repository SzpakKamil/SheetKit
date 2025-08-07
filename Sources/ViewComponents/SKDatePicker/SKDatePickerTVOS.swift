//
//  SKDatePickerTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(tvOS)
public struct SKDatePickerTVOS: View {
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    @State private var isUsingDatePicker: Bool = false
    @State private var tempDate: Date = .now
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            if #available(tvOS 26.0, *){
                return colorScheme == .dark ? .black.opacity(0.5) : .white.opacity(0.5)
            }else if #available(tvOS 18.0, *){
                return colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)
            }else{
                return colorScheme == .dark ? .white : .black
            }
        }
    }
    
    public var body: some View {
        Button {
            isUsingDatePicker = true
            tempDate = data.date.wrappedValue
        }label:{
            HStack{
                Text(data.title)
                    .foregroundStyle(.primary)
                    .tint(.primary)
                    .lineLimit(1)
                Spacer()
                HStack(spacing: 5){
                    Text(data.date.wrappedValue, format: .dateTime.day().month().year())
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 10)
                .clipShape(.capsule)
            }
            .padding(.vertical, 3)
            .padding(.leading, -7)
            .padding(.trailing, -15)
        }
        .foregroundStyle(colorScheme == .dark ? .white : .black)
        .buttonStyle(.borderedProminent)
        .padding(.vertical, -13)
        .tint(autoBackgroundColor)
        .fullScreenCover(isPresented: $isUsingDatePicker) {
            NavigationStack{
                GeometryReader{ geo in
                    ZStack{
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                        HStack{
                            SKTDatePicker(date: $tempDate, minDate: data.range?.lowerBound ?? .distantPast, maxDate: data.range?.upperBound ?? .distantFuture)
                                .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.5)
                            VStack{
                                Button("Submit", role: .cancel) {
                                    isUsingDatePicker = false
                                    data.date.wrappedValue = tempDate
                                }
                                Button("Reset", role: .destructive) {
                                    tempDate = data.date.wrappedValue
                                }
                            }
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
