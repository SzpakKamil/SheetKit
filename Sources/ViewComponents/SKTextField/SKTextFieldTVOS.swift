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
    let data: SKTextField.Data
    let prompt: Text?
    @State private var isFocused = false
    @Binding var text: String
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return colorScheme == .dark ? .black : .white
        }
    }

    init(text: Binding<String>, prompt: Text? = nil, data: SKTextField.Data) {
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
                                .foregroundStyle(.secondary)
                        }else{
                            Text(data.title)
                                .foregroundStyle(.secondary)
                        }
                    }else{
                        Text(text)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, -7)
            }
            .buttonStyle(.borderedProminent)
            .tint(autoBackgroundColor)
            .accessibilityElement()
            .accessibilityLabel(data.title + " Field")
            .accessibilityHint("Tap to input text.")
            .accessibilityValue(text)
            .accessibilityAddTraits(.isButton)
        }
    }
}

// MARK: - Decimal Field View
struct SKDecimalFieldViewTVOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Double {
    @Environment(\.colorScheme) var colorScheme
    let data: SKTextField.Data
    @Binding var value: Double
    private let format: F
    private let prompt: Text?
    private let defaultValue: Double
    @State private var isFocused = false
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return colorScheme == .dark ? .black : .white
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
        ZStack{
            SKTKeyboardTriggerDouble(value: $value, isKeyboardVisible: $isFocused)
            Button{
                isFocused = true
            }label:{
                HStack{
                    if value.isZero{
                        Text(data.title)
                            .foregroundStyle(.secondary)
                    }else{
                        Text(value, format: format)
                    }

                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, -7)
            }
            .buttonStyle(.borderedProminent)
            .tint(autoBackgroundColor)
            .accessibilityElement()
            .accessibilityLabel(data.title + " Field")
            .accessibilityHint("Tap to input text.")
            .accessibilityValue("\(value)")
            .accessibilityAddTraits(.isButton)

        }
    }
}

// MARK: - Integer Field View
struct SKIntFieldViewTVOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Int {
    let data: SKTextField.Data
    @Environment(\.colorScheme) var colorScheme
    @Binding var value: Int
    private let format: F
    private let prompt: Text?
    private let defaultValue: Int
    @State private var isFocused = false
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return colorScheme == .dark ? .black : .white
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
        ZStack{
            SKTKeyboardTriggerInt(value: $value, isKeyboardVisible: $isFocused)
            Button{
                isFocused = true
            }label:{
                HStack{
                    if value == 0{
                        Text(data.title)
                            .foregroundStyle(.secondary)
                    }else{
                        Text(value, format: format)
                    }

                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, -7)
            }
            .buttonStyle(.borderedProminent)
            .tint(autoBackgroundColor)
            .accessibilityElement()
            .accessibilityLabel(data.title + " Field")
            .accessibilityHint("Tap to input text.")
            .accessibilityValue("\(value)")
            .accessibilityAddTraits(.isButton)
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
