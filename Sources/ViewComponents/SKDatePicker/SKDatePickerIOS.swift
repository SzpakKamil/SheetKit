//
//  SKDatePickerIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(iOS)
public struct SKDatePickerIOS: View {
    @Binding var date: Date
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.colorScheme) var colorScheme
    var data: SKDatePicker.Data
    
    var autoBackgroundColor: Color{
        if let backgroundColor = skRowBackgroundColor{
            return backgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
        }
    }
    
    public var body: some View {
        HStack{
            Text(data.title)
            Spacer()
            DatePicker(data.title, selection: $date, in: data.range ?? Date.distantPast...Date.distantFuture, displayedComponents: data.components)
                .labelsHidden()
                .if{ content in
                    if #available(iOS 26.0, *){
                        content
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
                    }else{
                        content
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 10, style: .continuous))
                    }
                }
        }
        .padding(.leading, 16)
        .padding(.trailing, 7)
        .padding(.vertical, 6)
        .background(autoBackgroundColor)
        .if{ content in
            if #available(iOS 26.0, *){
                content
                    .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
            }else{
                content
                    .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 13, style: .continuous))
            }
        }
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
