//
//  SKTextField.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

struct SKTextFieldData{
    let title: String
    
    init(title: String) {
        self.title = title
    }
}


public struct SKTextField: SKComponent{
    public let type: SKComponentType = .field
    let content: AnyView
    var data: SKTextFieldData
    
    public var body: some View {
        content
    }
    
    #if os(iOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) {
        self.data = .init(title: title)
        self.content = AnyView(SKTextFieldViewIOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Double{
        self.data = .init(title: title)
        self.content = AnyView(SKDecimalFieldViewIOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }

    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Int{
        self.data = .init(title: title)
        self.content = AnyView(SKIntFieldViewIOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(macOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) {
        self.data = .init(title: title)
        self.content = AnyView(SKTextFieldViewMACOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Double {
        self.data = .init(title: title)
        self.content = AnyView(SKDecimalFieldViewMACOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Int {
        self.data = .init(title: title)
        self.content = AnyView(SKIntFieldViewMACOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(tvOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) {
        self.data = .init(title: title)
        self.content = AnyView(SKTextFieldViewTVOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Double {
        self.data = .init(title: title)
        self.content = AnyView(SKDecimalFieldViewTVOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Int {
        self.data = .init(title: title)
        self.content = AnyView(SKIntFieldViewTVOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(visionOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) {
        self.data = .init(title: title)
        self.content = AnyView(SKTextFieldViewVISIONOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Double {
        self.data = .init(title: title)
        self.content = AnyView(SKDecimalFieldViewVISIONOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Int {
        self.data = .init(title: title)
        self.content = AnyView(SKIntFieldViewVISIONOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(watchOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) {
        self.data = .init(title: title)
        self.content = AnyView(SKTextFieldViewWATCHOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Double {
        self.data = .init(title: title)
        self.content = AnyView(SKDecimalFieldViewWATCHOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Int {
        self.data = .init(title: title)
        self.content = AnyView(SKIntFieldViewWATCHOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #endif
}
