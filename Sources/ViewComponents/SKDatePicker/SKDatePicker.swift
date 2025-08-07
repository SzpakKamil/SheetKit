//
//  SKDatePicker.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

public extension SKDatePicker{
    struct Data{
        let title: LocalizedStringKey
        let date: Binding<Date>
        let range: ClosedRange<Date>?
        #if !os(tvOS)
        let components: DatePicker.Components
        #endif
        var backgroundColor: Color?
        var cornerRadius: CGFloat?
        
        #if !os(tvOS)
        public init(title: LocalizedStringKey, backgroundColor: Color? = nil, cornerRadius: CGFloat? = nil, range: ClosedRange<Date>? = nil, selection: Binding<Date>, components: DatePicker.Components = .date) {
            self.title = title
            self.backgroundColor = backgroundColor
            self.components = components
            self.range = range
            self.date = selection
            self.cornerRadius = cornerRadius
        }
        #else
        public init(title: LocalizedStringKey, backgroundColor: Color? = nil, range: ClosedRange<Date>? = nil, cornerRadius: CGFloat? = nil, selection: Binding<Date>) {
            self.title = title
            self.backgroundColor = backgroundColor
            self.date = selection
            self.range = range
            self.cornerRadius = cornerRadius
        }
        #endif
    }
}

public struct SKDatePicker: View, SKComponent {
    public let type: SKComponentType = .field
    var data: SKDatePicker.Data
    
    public var body: some View {
        #if os(iOS)
        SKDatePickerIOS(data: data)
        #elseif os(macOS)
        SKDatePickerMACOS(data: data)
        #elseif os(tvOS)
        SKDatePickerTVOS(data: data)
        #elseif os(visionOS)
        SKDatePickerVISIONOS(data: data)
        #elseif os(watchOS)
        SKDatePickerWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }
    #if os(tvOS)
    public init(_ title: LocalizedStringKey, selection: Binding<Date>, in range: ClosedRange<Date>? = nil) {
        self.data = .init(title: title, range: range, selection: selection)
    }
    #else
    public init(_ title: LocalizedStringKey, selection: Binding<Date>, in range: ClosedRange<Date>? = nil, components: DatePicker.Components = .date) {
        self.data = .init(title: title, range: range, selection: selection, components: components)
    }
    #endif

}

#if DEBUG
struct PreviewViewSKDatePicker: View {
    @State private var selection = "John"
    
    var body: some View {
        VStack{
            SKDatePicker("Test", selection: .constant(.now))
        }
        .padding(.horizontal)
        .navigationTitle("Custom Picker")
    }
}
#Preview {
    PreviewViewSKDatePicker()
}
#endif
