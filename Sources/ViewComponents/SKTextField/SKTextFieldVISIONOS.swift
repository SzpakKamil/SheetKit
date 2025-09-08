//
//  SKTextFieldVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//
import SwiftUI

#if os(visionOS)
// MARK: - Text Field View
struct SKTextFieldViewVISIONOS: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    
    let data: SKTextFieldData
    let prompt: Text?
    @Binding var text: String
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .black.opacity(0.4)
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
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(LinearGradient(
                colors: [
                    autoBackgroundColor,
                    autoBackgroundColor.opacity(0.75)
                ],
                startPoint: .top,
                endPoint: .bottom
            ))
            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                    .stroke(LinearGradient(
                        colors: [
                            autoBackgroundColor,
                            .white.opacity(0.3)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ), lineWidth: 1.25)
            )
            .contentShape(Rectangle())
            .hoverEffect()
            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
            .accessibilityElement()
            .accessibilityLabel(data.title + " Field")
            .accessibilityHint("Tap to input text.")
            .accessibilityValue(text)
            .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Decimal Field View
struct SKDecimalFieldViewVISIONOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Double {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
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
            return .black.opacity(0.4)
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
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(LinearGradient(
                    colors: [
                        autoBackgroundColor,
                        autoBackgroundColor.opacity(0.75)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                        .stroke(LinearGradient(
                            colors: [
                                autoBackgroundColor,
                                .white.opacity(0.3)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 1.25)
                )
                .contentShape(Rectangle())
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
                .hoverEffect()
                .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
            TextField(data.title, text: .constant(""), prompt: prompt)
                .textFieldStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(LinearGradient(
                    colors: [
                        autoBackgroundColor,
                        autoBackgroundColor.opacity(0.75)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                        .stroke(LinearGradient(
                            colors: [
                                autoBackgroundColor,
                                .white.opacity(0.3)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 1.25)
                )
                .contentShape(Rectangle())
                .allowsHitTesting(false)
                .opacity(isFocused ? 0 : value == defaultValue ? 1 : 0)
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
        }
    }
}

// MARK: - Integer Field View
struct SKIntFieldViewVISIONOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Int {
    let data: SKTextFieldData
    @Environment(\.colorScheme) var colorScheme
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
            return .black.opacity(0.4)
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
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(LinearGradient(
                    colors: [
                        autoBackgroundColor,
                        autoBackgroundColor.opacity(0.75)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                        .stroke(LinearGradient(
                            colors: [
                                autoBackgroundColor,
                                .white.opacity(0.3)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 1.25)
                )
                .contentShape(Rectangle())
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
                .hoverEffect()
                .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
            TextField(data.title, text: .constant(""), prompt: prompt)
                .textFieldStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(LinearGradient(
                    colors: [
                        autoBackgroundColor,
                        autoBackgroundColor.opacity(0.75)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                        .stroke(LinearGradient(
                            colors: [
                                autoBackgroundColor,
                                .white.opacity(0.3)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 1.25)
                )
                .contentShape(Rectangle())
                .allowsHitTesting(false)
                .opacity(isFocused ? 0 : value == defaultValue ? 1 : 0)
                .accessibilityLabel(data.title + " Field")
                .accessibilityHint("Tap to input a value.")
                .accessibilityValue(value.formatted(format))
                .accessibilityAddTraits(.isButton)
        }
    }
}

#Preview(windowStyle: .automatic){
    ZStack{
//        Color(.white)
//            .ignoresSafeArea()
        VStack{
            TextField("Text", text: .constant(""))
                .textFieldStyle(.roundedBorder)
            SKTextField("Text", text: .constant(""), prompt: Text("Text"))
            SKTextField("Cost", value: .constant(0), format: .currency(code: "USD"), prompt: Text("Text"))
        }
    }
    .frame(width: 200, height: 200, alignment: .center)
}
#endif
