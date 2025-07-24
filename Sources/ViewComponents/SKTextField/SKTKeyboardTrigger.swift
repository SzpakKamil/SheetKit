//
//  SKTKeyboardTrigger.swift
//  SheetKit
//
//  Created by Kamil Szpak on 18/07/2025.
//


import SwiftUI
#if os(tvOS)
internal import UIKit

/// A SwiftUI wrapper for a hidden UITextField to trigger the tvOS keyboard.
struct SKTKeyboardTrigger: UIViewRepresentable {
    @Binding var text: String
    @Binding var isKeyboardVisible: Bool
    let keyboardType: UIKeyboardType
    
    init(text: Binding<String>, isKeyboardVisible: Binding<Bool>, keyboardType: UIKeyboardType = .default) {
        self._text = text
        self._isKeyboardVisible = isKeyboardVisible
        self.keyboardType = keyboardType
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SKTKeyboardTrigger

        init(_ parent: SKTKeyboardTrigger) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isKeyboardVisible = true
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isKeyboardVisible = false
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        textField.isHidden = true
        textField.accessibilityElementsHidden = true
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isKeyboardVisible {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    
}

/// A SwiftUI wrapper for a hidden UITextField to trigger the tvOS keyboard for Double input.
struct SKTKeyboardTriggerDouble: UIViewRepresentable {
    @Binding var value: Double
    @Binding var isKeyboardVisible: Bool
    let keyboardType: UIKeyboardType = .decimalPad
    let formatter: NumberFormatter

    init(value: Binding<Double>, isKeyboardVisible: Binding<Bool>, formatter: NumberFormatter = .defaultDecimalFormatter) {
        self._value = value
        self._isKeyboardVisible = isKeyboardVisible
        self.formatter = formatter
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SKTKeyboardTriggerDouble

        init(_ parent: SKTKeyboardTriggerDouble) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text, let number = parent.formatter.number(from: text) {
                parent.value = number.doubleValue
            } else {
                parent.value = 0.0 // Fallback to 0 if parsing fails
            }
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isKeyboardVisible = true
            textField.text = parent.formatter.string(from: NSNumber(value: parent.value))
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isKeyboardVisible = false
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        textField.isHidden = true
        textField.accessibilityElementsHidden = true
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if !uiView.isFirstResponder {
            uiView.text = formatter.string(from: NSNumber(value: value))
        }
        if isKeyboardVisible {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
}

/// A SwiftUI wrapper for a hidden UITextField to trigger the tvOS keyboard for Int input.
struct SKTKeyboardTriggerInt: UIViewRepresentable {
    @Binding var value: Int
    @Binding var isKeyboardVisible: Bool
    let keyboardType: UIKeyboardType = .numberPad
    let formatter: NumberFormatter

    init(value: Binding<Int>, isKeyboardVisible: Binding<Bool>, formatter: NumberFormatter = .defaultIntegerFormatter) {
        self._value = value
        self._isKeyboardVisible = isKeyboardVisible
        self.formatter = formatter
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SKTKeyboardTriggerInt

        init(_ parent: SKTKeyboardTriggerInt) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text, let number = parent.formatter.number(from: text) {
                parent.value = number.intValue
            } else {
                parent.value = 0 // Fallback to 0 if parsing fails
            }
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isKeyboardVisible = true
            textField.text = parent.formatter.string(from: NSNumber(value: parent.value))
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isKeyboardVisible = false
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        textField.isHidden = true
        textField.accessibilityElementsHidden = true
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if !uiView.isFirstResponder {
            uiView.text = formatter.string(from: NSNumber(value: value))
        }
        if isKeyboardVisible {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
}

/// Extension to provide default formatters for numeric input.
extension NumberFormatter {
    static var defaultDecimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = .autoupdatingCurrent
        return formatter
    }

    static var defaultIntegerFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none // No decimal places for integers
        formatter.locale = .autoupdatingCurrent
        return formatter
    }
}
#endif
