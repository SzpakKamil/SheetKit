//
//  SKTextFieldIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

#if os(iOS)
// MARK: - Text Field View
struct SKTextFieldViewIOS: View {
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    let data: SKTextFieldData
    let prompt: Text?
    @Binding var text: String
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
        }
    }

    init(text: Binding<String>, prompt: Text? = nil, data: SKTextFieldData) {
        self._text = text
        self.data = data
        self.prompt = prompt
    }

    var body: some View {
        TextField(data.title, text: $text, prompt: prompt)
            .padding(.horizontal)
            .padding(.vertical, 12.5)
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
            .accessibilityElement()
            .accessibilityLabel(data.title + " Field")
            .accessibilityHint("Tap to input text.")
            .accessibilityValue(text)
            .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Decimal Field View
struct SKDecimalFieldViewIOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Double {
    @Environment(\.skAccentColor) var skAccentColor
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
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
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
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
                .keyboardType(.decimalPad)
                .if{ content in
                    if #available(iOS 26.0, *){
                        content
                            .padding(.horizontal)
                            .padding(.vertical, 15)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
                    }else{
                        content
                            .padding(.horizontal, 19)
                            .padding(.vertical, 12)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 10, style: .continuous))
                    }
                }
                .contentShape(Rectangle())
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
            TextField(data.title, text: .constant(""), prompt: prompt)
                .keyboardType(.decimalPad)
                .if{ content in
                    if #available(iOS 26.0, *){
                        content
                            .padding(.horizontal)
                            .padding(.vertical, 15)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
                    }else{
                        content
                            .padding(.horizontal, 19)
                            .padding(.vertical, 12)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 10, style: .continuous))
                    }
                }
                .contentShape(Rectangle())
                .allowsHitTesting(false)
                .opacity(isFocused ? 0 : value == defaultValue ? 1 : 0)
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
        }
        .toolbar {
            if isFocused{
                ToolbarItem(placement: .primaryAction) {
                    if #available(iOS 26.0, *){
                        Button("Submit", systemImage: "checkmark"){
                            isFocused = false
                        }
                        #if compiler(>=6.2)
                        .buttonStyle(.glassProminent)
                        #endif
                        .tint(skAccentColor)
                        .contentShape(Rectangle())
                    }else{
                        Button("Submit"){
                            isFocused = false
                        }
                        .tint(skAccentColor)
                    }
                }
            }
        }
    }
}

// MARK: - Integer Field View
struct SKIntFieldViewIOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Int {
    let data: SKTextFieldData
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skAccentColor) var skAccentColor
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Binding var value: Int
    private let format: F
    private let prompt: Text?
    private let defaultValue: Int
    @FocusState private var isFocused: Bool
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
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
                .keyboardType(.numberPad)
                .if{ content in
                    if #available(iOS 26.0, *){
                        content
                            .padding(.horizontal)
                            .padding(.vertical, 15)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
                    }else{
                        content
                            .padding(.horizontal, 19)
                            .padding(.vertical, 12)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 10, style: .continuous))
                    }
                }
                .contentShape(Rectangle())
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
            TextField(data.title, text: .constant(""), prompt: prompt)
                .keyboardType(.numberPad)
                .if{ content in
                    if #available(iOS 26.0, *){
                        content
                            .padding(.horizontal)
                            .padding(.vertical, 15)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
                    }else{
                        content
                            .padding(.horizontal, 19)
                            .padding(.vertical, 12)
                            .background(autoBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 10, style: .continuous))
                    }
                }
                .contentShape(Rectangle())
                .allowsHitTesting(false)
                .opacity(isFocused ? 0 : value == defaultValue ? 1 : 0)
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
        }
        .toolbar {
            if isFocused{
                ToolbarItem(placement: .primaryAction) {
                    if #available(iOS 26.0, *){
                        Button("Submit", systemImage: "checkmark"){
                            isFocused = false
                        }
                        #if compiler(>=6.2)
                        .buttonStyle(.glassProminent)
                        #endif
                        .tint(skAccentColor)
                        .contentShape(Rectangle())
                    }else{
                        Button("Submit"){
                            isFocused = false
                        }
                        .tint(skAccentColor)
                    }
                }
            }
        }
    }
}

#Preview{
    VStack{
        TextField("Text", text: .constant(""))
        SKTextField("Text", text: .constant(""), prompt: Text("Banana"))
    }
    .frame(width: 200, height: 200, alignment: .center)
}
#endif
