//
//  SKDatePickerVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if os(visionOS)
public struct SKDatePickerVISIONOS: View {
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
                .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 12, style: .continuous))
        }
        .padding(.leading, 16)
        .padding(.trailing, 7)
        .padding(.vertical, 5)
        .background(LinearGradient(
            colors: [
                .black.opacity(0.4),
                .black.opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
        .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: data.cornerRadius ?? 12, style: .continuous)
                .stroke(LinearGradient(
                    colors: [
                        .black.opacity(0.4),
                        .white.opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ), lineWidth: 1.25)
        )
        .contentShape(Rectangle())
    }
    
    public init(data: SKDatePicker.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview(windowStyle: .automatic){
    ZStack{
        VStack{
            SKDatePickerVISIONOS(data: .init(title: "Date", selection: .constant(.now)))
        }
    }
    .frame(width: 400, height: 200, alignment: .center)
}
#endif
#endif
