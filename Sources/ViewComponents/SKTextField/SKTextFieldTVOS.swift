//
//  SKTextFieldTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//
import SwiftUI

#if os(tvOS)
// MARK: - Text Field View
struct SKTextFieldViewTVOS: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    let data: SKTextFieldData
    let prompt: Text?
    @State private var isFocused = false
    @Binding var text: String
    
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
    
    init(text: Binding<String>, prompt: Text? = nil, data: SKTextFieldData) {
        self._text = text
        self.data = data
        self.prompt = prompt
    }

    var body: some View {
        ZStack{
            SKTKeyboardTrigger(text: $text, isKeyboardVisible: $isFocused)
            Button{
                isFocused = true
            }label:{
                HStack{
                    if text.isEmpty{
                        if let prompt{
                            prompt
                                .if{ content in
                                    if #available(tvOS 26.0, *){
                                        content
                                            .foregroundStyle(textColor.secondary)
                                    }else{
                                        content
                                            .foregroundStyle(textColor.secondary)
                                    }
                                }
                        }else{
                            Text(data.title)
                                .if{ content in
                                    if #available(tvOS 26.0, *){
                                        content
                                            .foregroundStyle(.secondary)
                                            .foregroundStyle(textColor.secondary)
                                    }else{
                                        content
                                            .foregroundStyle(textColor.secondary)
                                    }
                                }
                        }
                    }else{
                        Text(text)
                            .if{ content in
                                if #available(tvOS 26.0, *){
                                    content
                                        .tint(.primary)
                                }else{
                                    content
                                        .foregroundStyle(textColor)
                                }
                            }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, -7)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(skIsInSection ? .roundedRectangle(radius: 0) : skRowShape == nil ? .automatic : .roundedRectangle(radius: skRowShape!))
            .tint(autoBackgroundColor)
            .accessibilityElement()
            .accessibilityLabel(data.title)
            .accessibilityValue(text)
            .accessibilityAddTraits(.isButton)
            .if{ content in
                if #unavailable(tvOS 26.0){
                    content
                        .padding(.vertical, -13)
                }else{
                    content
                }
            }
        }
    }
}

// MARK: - Decimal Field View
struct SKDecimalFieldViewTVOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Double {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    let data: SKTextFieldData
    @Binding var value: Double
    private let format: F
    private let prompt: Text?
    private let defaultValue: Double
    @State private var isFocused = false
    
    
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
    
    init(value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil, data: SKTextFieldData) {
        self.data = data
        self._value = value
        self.defaultValue = defaultValue
        self.format = format
        self.prompt = prompt
    }

    var body: some View {
        ZStack{
            SKTKeyboardTriggerDouble(value: $value, isKeyboardVisible: $isFocused)
            Button{
                isFocused = true
            }label:{
                HStack{
                    if value.isZero{
                        if let prompt{
                            prompt
                                .if{ content in
                                    if #available(tvOS 26.0, *){
                                        content
                                            .foregroundStyle(.secondary)
                                            .foregroundStyle(textColor.secondary)
                                    }else{
                                        content
                                            .foregroundStyle(textColor.secondary)
                                    }
                                }
                        }else{
                            Text(data.title)
                                .if{ content in
                                    if #available(tvOS 26.0, *){
                                        content
                                            .foregroundStyle(.secondary)
                                            .foregroundStyle(textColor.secondary)
                                    }else{
                                        content
                                            .foregroundStyle(textColor.secondary)
                                    }
                                }
                        }
                    }else{
                        Text(value, format: format)
                            .if{ content in
                                if #available(tvOS 26.0, *){
                                    content
                                        .tint(.primary)
                                }else{
                                    content
                                        .foregroundStyle(textColor)
                                }
                            }
                    }

                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, -7)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(skIsInSection ? .roundedRectangle(radius: 0) : skRowShape == nil ? .automatic : .roundedRectangle(radius: skRowShape!))
            .tint(autoBackgroundColor)
            .accessibilityElement()
            .accessibilityLabel(data.title)
            .accessibilityValue(value.formatted(format))
            .accessibilityAddTraits(.isButton)

        }
    }
}

// MARK: - Integer Field View
struct SKIntFieldViewTVOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Int {
    let data: SKTextFieldData
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Binding var value: Int
    private let format: F
    private let prompt: Text?
    private let defaultValue: Int
    @State private var isFocused = false
    
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
    
    
    init(value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil, data: SKTextFieldData) {
        self._value = value
        self.defaultValue = defaultValue
        self.format = format
        self.prompt = prompt
        self.data = data
    }

    var body: some View {
        ZStack{
            SKTKeyboardTriggerInt(value: $value, isKeyboardVisible: $isFocused)
            Button{
                isFocused = true
            }label:{
                HStack{
                    if value == 0{
                        if let prompt{
                            prompt
                                .if{ content in
                                    if #available(tvOS 26.0, *){
                                        content
                                            .foregroundStyle(.secondary)
                                            .foregroundStyle(textColor.secondary)
                                    }else{
                                        content
                                            .foregroundStyle(textColor.secondary)
                                    }
                                }
                        }else{
                            Text(data.title)
                                .if{ content in
                                    if #available(tvOS 26.0, *){
                                        content
                                            .foregroundStyle(.secondary)
                                            .foregroundStyle(textColor.secondary)
                                    }else{
                                        content
                                            .foregroundStyle(textColor.secondary)
                                    }
                                }
                        }
                    }else{
                        Text(value, format: format)
                            .if{ content in
                                if #available(tvOS 26.0, *){
                                    content
                                        .foregroundStyle(.secondary)
                                        .foregroundStyle(textColor.secondary)
                                }else{
                                    content
                                        .foregroundStyle(textColor.secondary)
                                }
                            }
                    }

                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, -7)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(skIsInSection ? .roundedRectangle(radius: 0) : skRowShape == nil ? .automatic : .roundedRectangle(radius: skRowShape!))
            .tint(autoBackgroundColor)
            .accessibilityElement()
            .accessibilityLabel(data.title)
            .accessibilityValue(value.formatted(format))
            .accessibilityAddTraits(.isButton)
        }
    }
}

#endif
