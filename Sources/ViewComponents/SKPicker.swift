//
//  SKPicker.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI
#if !os(watchOS)

public extension SKPicker{
    struct Data{
        let title: LocalizedStringKey
        let selection: Binding<SelectionValue>
        let content: Content
        var cornerRadius: CGFloat?
        var backgroundColor: Color?
        let headerView: AnyView?
        let footerView: AnyView?
        
        public init(
            _ title: LocalizedStringKey,
            selection: Binding<SelectionValue>,
            backgroundColor: Color? = nil,
            cornerRadius: CGFloat? = nil,
            @ViewBuilder content: () -> Content
        ) {
            self.title = title
            self.selection = selection
            self.headerView = nil
            self.footerView = nil
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.content = content()
        }
        
        public init(
            _ title: LocalizedStringKey,
            selection: Binding<SelectionValue>,
            backgroundColor: Color? = nil,
            cornerRadius: CGFloat? = nil,
            @ViewBuilder content: () -> Content,
            @ViewBuilder headerView: () -> some View
        ) {
            self.title = title
            self.selection = selection
            self.headerView = AnyView(headerView())
            self.footerView = nil
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.content = content()
        }
        
        public init(
            _ title: LocalizedStringKey,
            selection: Binding<SelectionValue>,
            backgroundColor: Color? = nil,
            cornerRadius: CGFloat? = nil,
            @ViewBuilder content: () -> Content,
            @ViewBuilder headerView: () -> some View,
            @ViewBuilder footerView: () -> some View
        ) {
            self.title = title
            self.selection = selection
            self.headerView = AnyView(headerView())
            self.footerView = AnyView(footerView())
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.content = content()
        }
        
        public init(
            _ title: LocalizedStringKey,
            selection: Binding<SelectionValue>,
            backgroundColor: Color? = nil,
            cornerRadius: CGFloat? = nil,
            @ViewBuilder content: () -> Content,
            @ViewBuilder footerView: () -> some View
        ) {
            self.title = title
            self.selection = selection
            self.headerView = nil
            self.footerView = AnyView(footerView())
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius    
            self.content = content()
        }
    }
}

public struct SKPicker<SelectionValue: Hashable, Content: View>: View, SKComponent {
    public let type: SKComponentType = .field
    @Environment(\.colorScheme) var colorScheme
    var data: SKPicker.Data
    
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
        }
    }
    
    var menuIndicatorColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else if colorScheme == .dark{
            return Color(red: 0.2, green: 0.2196078431, blue: 0.2274509804)
        }else{
            return Color(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647)
        }
    }
    
    public var body: some View {
        #if os(tvOS)
        tvOSStyle()
        #else
        ZStack{
            #if os(visionOS)
            TextField(text: .constant(""), label: {
                Text("")
                    .padding(.vertical)
            })
                .textFieldStyle(.roundedBorder)
                .allowsHitTesting(false)
            #endif
            HStack{
                Text(data.title)
                Spacer()
                Menu{
                    #if os(macOS)
                    if let headerView = data.headerView{
                        headerView
                    }
                    #else
                    if let footerView = data.footerView{
                        footerView
                    }
                    #endif
                    _VariadicView.Tree(SKPickerOptions(selectedValue: data.selection)) {
                        data.content
                    }
                    #if os(macOS)
                    if let footerView = data.footerView{
                        footerView
                    }
                    #else
                    if let headerView = data.headerView{
                        headerView
                    }
                    #endif
                }label: {
                    HStack(spacing: 5){
                        Text(verbatim: String(describing: data.selection.wrappedValue))
                            #if os(macOS)
                            .font(.body)
                            .padding(.horizontal, 11)
                            #else
                            .font(.callout)
                            #endif
                        #if os(macOS) || os(tvOS)
                        Spacer()
                        #endif
                        Image(systemName: "chevron.up.chevron.down")
                            #if os(macOS)
                            .if{content in
                                if #available(macOS 13.0, *) {
                                    content
                                        .fontWeight(.semibold)
                                } else {
                                    content
                                }
                            }
                            .padding(.trailing, 7)
                            #endif
                            .imageScale(.small)
                    }
                    #if os(macOS)
                    .padding(.vertical, 4)
                    .background(menuIndicatorColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    #elseif os(iOS)
                    .foregroundStyle(.secondary)
                    #endif
                }
                #if os(visionOS)
                .buttonStyle(.borderless)
                .buttonBorderShape(.roundedRectangle)
                #else
                .buttonStyle(.plain)
                #endif
                .tint(.primary)
            }
            #if os(iOS)
            .if{ content in
                if #available(iOS 26.0, *){
                    content
                        .padding(.horizontal)
                        .padding(.vertical, 15)
                        .background(autoBackgroundColor)
                        .if {content in
                            if let cornerRadius = data.cornerRadius{
                                content
                                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                            }else{
                                content
                                    .clipShape( .capsule)
                            }
                        }
                }else{
                    content
                        .padding(.horizontal, 19)
                        .padding(.vertical, 12)
                        .background(autoBackgroundColor)
                        .if {content in
                            if let cornerRadius = data.cornerRadius{
                                content
                                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                            }else{
                                content
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                        }
                }
            }
            #elseif os(visionOS)
            .padding(.leading)
            #endif
        }
        #endif
    }
    @ViewBuilder
    public func tvOSStyle() -> some View {
        Menu{
            #if os(macOS) || os(tvOS)
            if let headerView = data.headerView{
                headerView
            }
            #else
            if let footerView = data.footerView{
                footerView
            }
            #endif
            _VariadicView.Tree(SKPickerOptions(selectedValue: data.selection)) {
                data.content
            }
            #if os(macOS) || os(tvOS)
            if let footerView = data.footerView{
                footerView
            }
            #else
            if let headerView = data.headerView{
                headerView
            }
            #endif
        }label: {
            HStack(spacing: 5){
                Text(data.title)
                Spacer()
                HStack(spacing: 5){
                    Text(verbatim: String(describing: data.selection.wrappedValue))
                        .font(.callout)
                    Image(systemName: "chevron.up.chevron.down")
                        .fontWeight(.semibold)
                        .imageScale(.small)
                }
            }
            .padding(.vertical, 3)
            .padding(.leading, -7)
            .padding(.trailing, -15)

        }
        .buttonStyle(.borderedProminent)
        .tint(colorScheme == .dark ? .black : .white)
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content
    ) {
        self.data = .init(title, selection: selection, content: content)
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder headerView: () -> some View
    ) {
        self.data = .init(title, selection: selection, content: content, headerView: headerView)
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder headerView: () -> some View,
        @ViewBuilder footerView: () -> some View
    ) {
        self.data = .init(title, selection: selection, content: content, headerView: headerView, footerView: footerView)
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        backgroundColor: Color? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footerView: () -> some View
    ) {
        self.data = .init(title, selection: selection, content: content, footerView: footerView)
    }
}

private struct SKPickerOptions<Value: Hashable>: _VariadicView.MultiViewRoot {
    private let selectedValue: Binding<Value>
    
    init(selectedValue: Binding<Value>) {
        self.selectedValue = selectedValue
    }
    
    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        Section {
            ForEach(children) { child in
                SKPickerOption(
                    selectedValue: selectedValue,
                    value: child[CustomTagValueTraitKey<Value>.self]
                ) {
                    child
                }
            }
        }
    }
}

private struct SKPickerOption<Content: View, Value: Hashable>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accentColor) private var accentColor
    
    private let selectedValue: Binding<Value>
    private let value: Value?
    private let content: Content
    
    init(
        selectedValue: Binding<Value>,
        value: CustomTagValueTraitKey<Value>.Value,
        @ViewBuilder _ content: () -> Content
    ) {
        self.selectedValue = selectedValue
        self.value = if case .tagged(let tag) = value {
            tag
        } else {
            nil
        }
        self.content = content()
    }
    
    var body: some View {
        Button(
            action: {
                if let value {
                    selectedValue.wrappedValue = value
                }
            },
            label: {
                HStack {
                    content
                        .tint(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                            .foregroundStyle(accentColor)
                            .font(.body.weight(.semibold))
                            .accessibilityHidden(true)
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(isSelected ? .isSelected : [])
            }
        )
        .buttonStyle(.plain)
    }
    
    private var isSelected: Bool {
        selectedValue.wrappedValue == value
    }
}

extension View {
    public func pickerTag<V: Hashable>(_ tag: V) -> some View {
        _trait(CustomTagValueTraitKey<V>.self, .tagged(tag))
    }
}

private struct CustomTagValueTraitKey<V: Hashable>: _ViewTraitKey {
    enum Value {
        case untagged
        case tagged(V)
    }
    
    static var defaultValue: CustomTagValueTraitKey<V>.Value {
        .untagged
    }
}

private struct PreviewContent: View {
    @State private var selection = "John"
    
    var body: some View {
        VStack{
//            List {
//                Picker("Name", selection: $selection) {
//                    ForEach(["John", "Jean", "Juan"], id: \.self) { name in
//                        Text(verbatim: name)
//                        
//                    }
//                }
//            }
//            .frame(height: 200)
//            SKTextField("Test", text: .constant("Text"))
            SKPicker("Name", selection: $selection) {
                ForEach(["John", "Jean", "Juan"], id: \.self) { name in
                    Text(name)
                        .pickerTag(name)
                }
            }headerView: {
                Text("Banana")
            }footerView: {
                Text("Test")
            }
            .backgroundColor(.red)
        }
        .padding(.horizontal)
        .navigationTitle("Custom Picker")
    }
}

#if os(visionOS)
#Preview(windowStyle: .automatic) {
  PreviewContent()
}
#else
#Preview {
  PreviewContent()
}
#endif
#endif
