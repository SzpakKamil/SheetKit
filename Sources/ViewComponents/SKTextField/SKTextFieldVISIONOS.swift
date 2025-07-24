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
    let data: SKTextField.Data
    let prompt: Text?
    @Binding var text: String
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .clear
        }
    }

    init(text: Binding<String>, prompt: Text? = nil, data: SKTextField.Data) {
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
    let data: SKTextField.Data
    @Binding var value: Double
    private let format: F
    private let prompt: Text?
    private let defaultValue: Double
    @FocusState private var isFocused: Bool
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .clear
        }
    }
    
    init(value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil, data: SKTextField.Data) {
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
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
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
    let data: SKTextField.Data
    @Environment(\.colorScheme) var colorScheme
    @Binding var value: Int
    private let format: F
    private let prompt: Text?
    private let defaultValue: Int
    @FocusState private var isFocused: Bool
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .clear
        }
    }
    
    init(value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil, data: SKTextField.Data) {
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
                .focused($isFocused)
                .opacity(isFocused ? 1 : value != defaultValue ? 1 : 0.05)
                .allowsHitTesting(true)
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
