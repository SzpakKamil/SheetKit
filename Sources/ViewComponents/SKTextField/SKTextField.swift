//
//  SKTextField.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

struct SKTextFieldData{
    let title: String
    
    public init(title: String) {
        self.title = title
    }
}


public struct SKTextField<Content: View>: SKComponent{
    public let type: SKComponentType = .field
    let content: Content
    var data: SKTextFieldData
    
    public var body: some View {
        content
    }
    
    #if os(iOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) where Content == SKTextFieldViewWrapper {
        self.data = .init(title: title)
        self.content = SKTextFieldViewWrapper(data: data, content: SKTextFieldViewIOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where Content == SKDecimalFieldViewWrapper<F>{
        self.data = .init(title: title)
        self.content = SKDecimalFieldViewWrapper(data: data, content: SKDecimalFieldViewIOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }

    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where Content == SKIntFieldViewWrapper<F>{
        self.data = .init(title: title)
        self.content = SKIntFieldViewWrapper(data: data, content: SKIntFieldViewIOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(macOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) where Content == SKTextFieldViewWrapper {
        self.data = .init(title: title)
        self.content = SKTextFieldViewWrapper(data: data, content: SKTextFieldViewMACOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where Content == SKDecimalFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKDecimalFieldViewWrapper(data: data, content: SKDecimalFieldViewMACOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where Content == SKIntFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKIntFieldViewWrapper(data: data, content: SKIntFieldViewMACOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(tvOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) where Content == SKTextFieldViewWrapper {
        self.data = .init(title: title)
        self.content = SKTextFieldViewWrapper(data: data, content: SKTextFieldViewTVOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where Content == SKDecimalFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKDecimalFieldViewWrapper(data: data, content: SKDecimalFieldViewTVOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where Content == SKIntFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKIntFieldViewWrapper(data: data, content: SKIntFieldViewTVOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(visionOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) where Content == SKTextFieldViewWrapper {
        self.data = .init(title: title)
        self.content = SKTextFieldViewWrapper(data: data, content: SKTextFieldViewVISIONOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where Content == SKDecimalFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKDecimalFieldViewWrapper(data: data, content: SKDecimalFieldViewVISIONOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where Content == SKIntFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKIntFieldViewWrapper(data: data, content: SKIntFieldViewVISIONOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #elseif os(watchOS)
    public init(_ title: String, text: Binding<String>, prompt: Text? = nil) where Content == SKTextFieldViewWrapper {
        self.data = .init(title: title)
        self.content = SKTextFieldViewWrapper(data: data, content: SKTextFieldViewWATCHOS(text: text, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Double>, defaultValue: Double = 0, format: F, prompt: Text? = nil) where Content == SKDecimalFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKDecimalFieldViewWrapper(data: data, content: SKDecimalFieldViewWATCHOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    public init<F: ParseableFormatStyle>(_ title: String, value: Binding<Int>, defaultValue: Int = 0, format: F, prompt: Text? = nil) where Content == SKIntFieldViewWrapper<F> {
        self.data = .init(title: title)
        self.content = SKIntFieldViewWrapper(data: data, content: SKIntFieldViewWATCHOS<F>(value: value, defaultValue: defaultValue, format: format, prompt: prompt, data: data))
    }
    #endif
}


public struct SKTextFieldViewWrapper: View{
    var data: SKTextFieldData
    #if os(iOS)
    let content: SKTextFieldViewIOS
    init(data: SKTextFieldData, content: SKTextFieldViewIOS) {
        self.data = data
        self.content = content
    }
    #elseif os(macOS)
    let content: SKTextFieldViewMACOS
    init(data: SKTextFieldData, content: SKTextFieldViewMACOS) {
        self.data = data
        self.content = content
    }
    #elseif os(tvOS)
    let content: SKTextFieldViewTVOS
    init(data: SKTextFieldData, content: SKTextFieldViewTVOS) {
        self.data = data
        self.content = content
    }
    #elseif os(visionOS)
    let content: SKTextFieldViewVISIONOS
    init(data: SKTextFieldData, content: SKTextFieldViewVISIONOS) {
        self.data = data
        self.content = content
    }
    #elseif os(watchOS)
    let content: SKTextFieldViewWATCHOS
    init(data: SKTextFieldData, content: SKTextFieldViewWATCHOS) {
        self.data = data
        self.content = content
    }
    #else
    let content: EmptyView
    #endif
    public var body: some View{
        content
    }
    

}
public struct SKDecimalFieldViewWrapper<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Double{
    var data: SKTextFieldData
    #if os(iOS)
    let content: SKDecimalFieldViewIOS<F>
    init(data: SKTextFieldData, content: SKDecimalFieldViewIOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(macOS)
    let content: SKDecimalFieldViewMACOS<F>
    init(data: SKTextFieldData, content: SKDecimalFieldViewMACOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(tvOS)
    let content: SKDecimalFieldViewTVOS<F>
    init(data: SKTextFieldData, content: SKDecimalFieldViewTVOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(visionOS)
    let content: SKDecimalFieldViewVISIONOS<F>
    init(data: SKTextFieldData, content: SKDecimalFieldViewVISIONOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(watchOS)
    let content: SKDecimalFieldViewWATCHOS<F>
    init(data: SKTextFieldData, content: SKDecimalFieldViewWATCHOS<F>) {
        self.data = data
        self.content = content
    }
    #else
    let content: EmptyView
    init(data: SKTextFieldData, content: EmptyView){
        self.data = data
        self.content = content
    }
    #endif
    public var body: some View{
        content
    }
}

public struct SKIntFieldViewWrapper<F: ParseableFormatStyle>: View where F.FormatOutput == String, F.FormatInput == Int{
    var data: SKTextFieldData
    #if os(iOS)
    let content: SKIntFieldViewIOS<F>
    init(data: SKTextFieldData, content: SKIntFieldViewIOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(macOS)
    let content: SKIntFieldViewMACOS<F>
    init(data: SKTextFieldData, content: SKIntFieldViewMACOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(tvOS)
    let content: SKIntFieldViewTVOS<F>
    init(data: SKTextFieldData, content: SKIntFieldViewTVOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(visionOS)
    let content: SKIntFieldViewVISIONOS<F>
    init(data: SKTextFieldData, content: SKIntFieldViewVISIONOS<F>) {
        self.data = data
        self.content = content
    }
    #elseif os(watchOS)
    let content: SKIntFieldViewWATCHOS<F>
    init(data: SKTextFieldData, content: SKIntFieldViewWATCHOS<F>) {
        self.data = data
        self.content = content
    }
    #else
    let content: EmptyView
    init(data: SKTextFieldData, content: EmptyView){
        self.data = data
        self.content = content
    }
    #endif
    public var body: some View{
        content
    }
}

