//
//  SKTextField.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

public extension SKTextField{
    struct Data{
        let title: String
        
        public init(title: String) {
            self.title = title
        }
    }
}

public struct SKTextField: SKComponent{
    public let type: SKComponentType = .field
    let anyView: AnyView
    var data: SKTextField.Data
    
    public var body: some View {
        anyView
    }
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) {
        self.data = .init(title: title)
        #if os(iOS)
        self.anyView = AnyView(SKTextFieldViewIOS(text: text, prompt: prompt, data: data))
        #elseif os(macOS)
        self.anyView = AnyView(SKTextFieldViewMACOS(text: text, prompt: prompt, data: data))
        #elseif os(tvOS)
        self.anyView = AnyView(SKTextFieldViewTVOS(text: text, prompt: prompt, data: data))
        #elseif os(visionOS)
        self.anyView = AnyView(SKTextFieldViewVISIONOS(text: text, prompt: prompt, data: data))
        #elseif os(watchOS)
        self.anyView = AnyView(SKTextFieldViewWATCHOS(text: text, prompt: prompt, data: data))
        #else
        self.anyView = AnyView(EmptyView())
        #endif
    }
    
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Double {
        self.data = .init(title: title)
        #if os(iOS)
        self.anyView = AnyView(SKDecimalFieldViewIOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(macOS)
        self.anyView = AnyView(SKDecimalFieldViewMACOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(tvOS)
        self.anyView = AnyView(SKDecimalFieldViewTVOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(visionOS)
        self.anyView = AnyView(SKDecimalFieldViewVISIONOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(watchOS)
        self.anyView = AnyView(SKDecimalFieldViewWATCHOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #else
        self.anyView = AnyView(EmptyView())
        #endif
    }
    
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where F.FormatOutput == String, F.FormatInput == Int {
        self.data = .init(title: title)
        #if os(iOS)
        self.anyView = AnyView(SKIntFieldViewIOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(macOS)
        self.anyView = AnyView(SKIntFieldViewMACOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(tvOS)
        self.anyView = AnyView(SKIntFieldViewTVOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(visionOS)
        self.anyView = AnyView(SKIntFieldViewVISIONOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #elseif os(watchOS)
        self.anyView = AnyView(SKIntFieldViewWATCHOS(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
        #else
        self.anyView = AnyView(EmptyView())
        #endif
    }
}
