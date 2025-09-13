//
//  SKTextFieldMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//
import SwiftUI

#if os(macOS)
// MARK: - Text Field View
struct SKTextFieldViewMACOS: View {
    @Environment(\.colorScheme) var colorScheme
    let data: SKTextFieldData
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    let prompt: Text?
    @Binding var text: String
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .clear
        }
    }

    init(text: Binding<String>, prompt: Text? = nil, data: SKTextFieldData) {
        self._text = text
        self.data = data
        self.prompt = prompt
    }

    var body: some View {
        TextField(data.title, text: $text, prompt: prompt)
            .textFieldStyle(.plain)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                    .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
            )
            .contentShape(Rectangle())
            .accessibilityElement()
            .accessibilityLabel(data.title)
            .accessibilityValue(text)
            .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Decimal Field View
struct SKDecimalFieldViewMACOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Double {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    let data: SKTextFieldData
    @Binding var value: Double
    private let format: F
    private let prompt: Text?
    private let defaultValue: Double
    @FocusState private var isFocused: Bool
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .clear
        }
    }
    
    init(value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil, data: SKTextFieldData) {
        self.data = data
        self._value = value
        self.defaultValue = defaultValue
        self.format = format
        self.prompt = prompt
    }

    var body: some View {
        ZStack {
            TextField(data.title, value: $value, format: format, prompt: prompt)
                .textFieldStyle(.plain)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(autoBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                        .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
                )
                .contentShape(Rectangle())
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
                .accessibilityElement()
                .accessibilityLabel(data.title)
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
            TextField(data.title, text: .constant(""), prompt: prompt)
                .textFieldStyle(.plain)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(autoBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                        .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
                )
                .contentShape(Rectangle())
                .allowsHitTesting(false)
                .opacity(isFocused ? 0 : value == defaultValue ? 1 : 0)
                .accessibilityElement()
                .accessibilityLabel(data.title)
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
        }
    }
}

// MARK: - Integer Field View
struct SKIntFieldViewMACOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Int {
    let data: SKTextFieldData
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    @Binding var value: Int
    private let format: F
    private let prompt: Text?
    private let defaultValue: Int
    @FocusState private var isFocused: Bool
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .clear
        }
    }
    
    init(value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil, data: SKTextFieldData) {
        self._value = value
        self.defaultValue = defaultValue
        self.format = format
        self.prompt = prompt
        self.data = data
    }

    var body: some View {
        ZStack {
            TextField(data.title, value: $value, format: format, prompt: prompt)
                .textFieldStyle(.plain)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(autoBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                        .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
                )
                .contentShape(Rectangle())
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
                .accessibilityElement()
                .accessibilityLabel(data.title)
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
            TextField(data.title, text: .constant(""), prompt: prompt)
                .textFieldStyle(.plain)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(autoBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                        .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
                )
                .contentShape(Rectangle())
                .allowsHitTesting(false)
                .opacity(isFocused ? 0 : value == defaultValue ? 1 : 0)
                .accessibilityElement()
                .accessibilityLabel(data.title)
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
        }
    }
}
#endif
