//
//  SKDatePicker.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

extension SKDatePicker{
    struct Data{
        let title: LocalizedStringKey
        let range: ClosedRange<Date>?
        #if !os(tvOS)
        let components: DatePicker.Components
        #endif
        
        #if !os(tvOS)
        init(title: LocalizedStringKey, range: ClosedRange<Date>? = nil, components: DatePicker.Components = .date) {
            self.title = title
            self.components = components
            self.range = range
        }
        #else
        init(title: LocalizedStringKey, range: ClosedRange<Date>? = nil) {
            self.title = title
            self.range = range
        }
        #endif
    }
}

public struct SKDatePicker: View, SKComponent {
    @Binding var date: Date
    public let type: SKComponentType = .field
    var data: SKDatePicker.Data
    
    public var body: some View {
        #if os(iOS)
        SKDatePickerIOS(date: $date, data: data)
        #elseif os(macOS)
        SKDatePickerMACOS(date: $date, data: data)
        #elseif os(tvOS)
        SKDatePickerTVOS(date: $date, data: data)
        #elseif os(visionOS)
        SKDatePickerVISIONOS(date: $date, data: data)
        #elseif os(watchOS)
        SKDatePickerWATCHOS(date: $date, data: data)
        #else
        EmptyView()
        #endif
    }
    #if os(tvOS)
    public init(_ title: LocalizedStringKey, selection: Binding<Date>, in range: ClosedRange<Date>? = nil) {
        self._date = selection
        self.data = .init(title: title, range: range)
    }
    #else
    public init(_ title: LocalizedStringKey, selection: Binding<Date>, in range: ClosedRange<Date>? = nil, components: DatePicker.Components = .date) {
        self._date = selection
        self.data = .init(title: title, range: range, components: components)
    }
    #endif

}
