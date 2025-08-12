//
//  SKPicker.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

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
    var data: SKPicker.Data

    public var body: some View {
        #if os(iOS)
        SKPickerIOS(data: data)
        #elseif os(macOS)
        SKPickerMACOS(data: data)
        #elseif os(tvOS)
        SKPickerTVOS(data: data)
        #elseif os(visionOS)
        SKPickerVISIONOS(data: data)
        #elseif os(watchOS)
        SKPickerWATCHOS(data: data)
        #else
        EmptyView()
        #endif
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
    
    public init(data: SKPicker<SelectionValue, Content>.Data) {
        self.data = data
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

struct SKPickerOptions<Value: Hashable>: _VariadicView.MultiViewRoot {
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

struct SKPickerOption<Content: View, Value: Hashable>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.skAccentColor) private var accentColor
    
    let selectedValue: Binding<Value>
    let value: Value?
    let content: Content
    
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
                #if os(watchOS)
                dismiss()
                #endif
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

struct CustomTagValueTraitKey<V: Hashable>: _ViewTraitKey {
    enum Value {
        case untagged
        case tagged(V)
    }
    
    static var defaultValue: CustomTagValueTraitKey<V>.Value {
        .untagged
    }
}

#if DEBUG
struct PreviewViewSKPicker: View {
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
            } headerView: {
                Button("Header"){
                    
                }
            } footerView: {
                Text("Footer")
            }
//            .backgroundColor(.red)
        }
        .padding(.horizontal)
        .navigationTitle("Custom Picker")
    }
}


#Preview {
    PreviewViewSKPicker()
}
#endif
