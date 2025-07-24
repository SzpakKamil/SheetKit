//
//  SKTextFieldWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//
import SwiftUI

#if os(watchOS)
// MARK: - Text Field View
struct SKTextFieldViewWATCHOS: View {
    @Environment(\.colorScheme) var colorScheme
    let data: SKTextField.Data
    let prompt: Text?
    @State private var isFocused = false
    @Binding var text: String
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            return .primary.opacity(0.1)
        }
    }

    init(text: Binding<String>, prompt: Text? = nil, data: SKTextField.Data) {
        self._text = text
        self.data = data
        self.prompt = prompt
    }

    var body: some View {
        TextFieldLink {
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
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 100, style: .continuous))
        } onSubmit: { newValue in
            text = newValue
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .accessibilityElement()
        .accessibilityLabel(data.title + " Field")
        .accessibilityHint("Tap to input text.")
        .accessibilityValue(text)
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Decimal Field View
struct SKDecimalFieldViewWATCHOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Double {
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
            return .primary.opacity(0.1)
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
        TextFieldLink {
            HStack{
                if value == defaultValue{
                    if let prompt{
                        prompt
                            .foregroundStyle(.secondary)
                    }else{
                        Text(data.title)
                            .foregroundStyle(.secondary)
                    }
                    
                }else{
                    Text(value, format: format)
                }
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 100, style: .continuous))
        } onSubmit: { newValue in
            if let newValue = Double(newValue){
                value = newValue
            }
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .accessibilityElement()
        .accessibilityLabel(data.title + " Field")
        .accessibilityHint("Tap to input text.")
        .accessibilityValue(String(value))
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Integer Field View
struct SKIntFieldViewWATCHOS<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Int {
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
            return .primary.opacity(0.1)
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
        TextFieldLink {
            HStack{
                if value == defaultValue{
                    if let prompt{
                        prompt
                            .foregroundStyle(.secondary)
                    }else{
                        Text(data.title)
                            .foregroundStyle(.secondary)
                    }
                    
                }else{
                    Text(value, format: format)
                }
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 100, style: .continuous))
        } onSubmit: { newValue in
            if let newValue = Int(newValue){
                value = newValue
            }
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .accessibilityElement()
        .accessibilityLabel(data.title + " Field")
        .accessibilityHint("Tap to input text.")
        .accessibilityValue(String(value))
        .accessibilityAddTraits(.isButton)
    }
}

#Preview{
//    VStack{
//        TextField("Text", text: .constant(""))
        SKTextField("Text", text: .constant(""), prompt: Text("Banana"))
//    }
//    .frame(width: 200, height: 200, alignment: .center)
}
#endif
