//
//  SKDatePickerTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKDatePickerTVOS: View {
    @Binding var date: Date
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    @State private var isUsingDatePicker: Bool = false
    @State private var tempDate: Date = .now
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
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
    
    var textColor: Color{
        return colorScheme == .dark ? .white : .black
    }
    
    var body: some View {
        Button {
            isUsingDatePicker = true
            tempDate = date
        }label:{
            HStack{
                Text(data.title)
                    .if{ content in
                        if #available(tvOS 26.0, *){
                            content
                                .foregroundStyle(textColor)
                        }else{
                            content
                                .foregroundStyle(textColor)
                        }
                    }
                    .lineLimit(1)
                Spacer()
                HStack(spacing: 5){
                    Text(date, format: .dateTime.day().month().year())
                        .if{ content in
                            if #available(tvOS 26.0, *){
                                content
                                    .foregroundStyle(textColor.secondary)
                            }else{
                                content
                                    .foregroundStyle(textColor.secondary)
                            }
                        }
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 15)
                .background(autoBackgroundColor)
                .if{ content in
                    if #available(tvOS 26.0, *){
                        content
                            .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 50))
                    }else{
                        content
                            .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 12))
                    }
                }
            }
            .padding(.leading, -7)
            .if{ content in
                if #available(tvOS 26.0, *){
                    content
                        .padding(.vertical, 3)
                        .padding(.trailing, -21)
                }else{
                    content
                        .padding(.vertical, 2)
                        .padding(.trailing, -24)
                }
            }
        }
        .buttonStyle(.borderedProminent)
        .if{ content in
            if #available(tvOS 26.0, *){
                content
                    .buttonBorderShape(.roundedRectangle(radius: skIsInSection ? 0 : skRowShape ?? 50))
            }else{
                content
                    .buttonBorderShape(.roundedRectangle(radius: skIsInSection ? 0 : skRowShape ?? 12))
            }
        }
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
                                    date = tempDate
                                }
                                Button("Reset", role: .destructive) {
                                    tempDate = date
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Select a Date")
            }
        }
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
