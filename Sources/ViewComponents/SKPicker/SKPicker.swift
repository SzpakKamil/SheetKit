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
        let content: Content
        let headerView: HeaderContent?
        let footerView: FooterContent?
        
        public init(
            _ title: LocalizedStringKey,
            @ViewBuilder content: () -> Content
        )  where HeaderContent == EmptyView, FooterContent == EmptyView{
            self.title = title
            self.headerView = nil
            self.footerView = nil
            self.content = content()
        }
        
        public init(
            _ title: LocalizedStringKey,
            @ViewBuilder content: () -> Content,
            @ViewBuilder headerView: () -> HeaderContent
        )  where FooterContent == EmptyView {
            self.title = title
            self.headerView = headerView()
            self.footerView = nil
            self.content = content()
        }
        
        public init(
            _ title: LocalizedStringKey,
            @ViewBuilder content: () -> Content,
            @ViewBuilder headerView: () -> HeaderContent,
            @ViewBuilder footerView: () -> FooterContent
        ) {
            self.title = title
            self.headerView = headerView()
            self.footerView = footerView()
            self.content = content()
        }
        
        public init(
            _ title: LocalizedStringKey,
            @ViewBuilder content: () -> Content,
            @ViewBuilder footerView: () -> FooterContent
        ) where HeaderContent == EmptyView {
            self.title = title
            self.headerView = nil
            self.footerView = footerView()
            self.content = content()
        }
    }
}

public struct SKPicker<SelectionValue: Hashable, Content: View, HeaderContent: View, FooterContent: View>: View, SKComponent {
    public let type: SKComponentType = .field
    @Binding var selection: SelectionValue
    var data: SKPicker.Data

    public var body: some View {
        #if os(iOS)
        SKPickerIOS(selection: $selection, data: data)
        #elseif os(macOS)
        SKPickerMACOS(selection: $selection, data: data)
        #elseif os(tvOS)
        SKPickerTVOS(selection: $selection, data: data)
        #elseif os(visionOS)
        SKPickerVISIONOS(selection: $selection, data: data)
        #elseif os(watchOS)
        SKPickerWATCHOS(selection: $selection, data: data)
        #endif
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content
    ) where HeaderContent == EmptyView, FooterContent == EmptyView {
        self._selection = selection
        self.data = .init(title, content: content)
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder headerView: () -> HeaderContent
    )  where FooterContent == EmptyView {
        self._selection = selection
        self.data = .init(title, content: content, headerView: headerView)
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder headerView: () -> HeaderContent,
        @ViewBuilder footerView: () -> FooterContent
    ) {
        self._selection = selection
        self.data = .init(title, content: content, headerView: headerView, footerView: footerView)
    }
    
    public init(selection: Binding<SelectionValue>, data: SKPicker<SelectionValue, Content, HeaderContent, FooterContent>.Data) {
        self._selection = selection
        self.data = data
    }
    
    public init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        backgroundColor: Color? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footerView: () -> FooterContent
    ) where HeaderContent == EmptyView {
        self._selection = selection
        self.data = .init(title, content: content, headerView: {EmptyView()}, footerView: footerView)
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
                .contentShape(Rectangle())
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
