//
//  SKToggle.swift
//  SheetKit
//
//  Created by Kamil Szpak on 07/09/2025.
//

import SwiftUI

extension SKToggle{
    struct Data{
        let title: LocalizedStringKey
        
        init(title: LocalizedStringKey){
            self.title = title
        }
    }
}

public struct SKToggle: View, SKComponent {
    @Binding var isOn: Bool
    public let type: SKComponentType = .field
    var data: SKToggle.Data
    
    public var body: some View {
        #if os(iOS)
        SKToggleIOS(isOn: $isOn, data: data)
        #elseif os(macOS)
        SKToggleMACOS(isOn: $isOn, data: data)
        #elseif os(tvOS)
        SKToggleTVOS(isOn: $isOn, data: data)
        #elseif os(visionOS)
        SKToggleVISIONOS(isOn: $isOn, data: data)
        #elseif os(watchOS)
        SKToggleWATCHOS(isOn: $isOn, data: data)
        #else
        EmptyView()
        #endif
    }
    public init(_ title: LocalizedStringKey, isOn: Binding<Bool>) {
        self._isOn = isOn
        self.data = .init(title: title)
    }
}
