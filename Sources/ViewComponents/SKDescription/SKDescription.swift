//
//  SKTitle.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

extension SKDescription{
    struct Data{
        var title: LocalizedStringKey
        var weight: Font.Weight
        var font: Font?
            
        init(titleKey: LocalizedStringKey) {
            self.title = titleKey
            self.weight = .regular
            self.font = nil
        }
        
        init(verbatim: String) {
            self.title = LocalizedStringKey(stringLiteral: verbatim)
            self.weight = .regular
            self.font = nil
        }
    }
}

public struct SKDescription: View, SKComponent {
    public let type: SKComponentType = .header
    var data: SKDescription.Data
    
    public var body: some View {
        #if os(iOS)
        SKDescriptionIOS(data: data)
        #elseif os(macOS)
        SKDescriptionMACOS(data: data)
        #elseif os(tvOS)
        SKDescriptionTVOS(data: data)
        #elseif os(visionOS)
        SKDescriptionVISIONOS(data: data)
        #elseif os(watchOS)
        SKDescriptionWATCHOS(data: data)
        #else
        EmptyView()
        #endif
    }
    
    public init(_ titleKey: LocalizedStringKey){
        self.data = .init(titleKey: titleKey)
    }
    
    public init(verbatim: String){
        self.data = .init(verbatim: verbatim)
    }
}

