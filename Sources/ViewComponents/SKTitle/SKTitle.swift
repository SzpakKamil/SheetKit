//
//  SKTitle.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

extension SKTitle{
    struct Data{
        var title: LocalizedStringKey
        var key: String?
        var weight: Font.Weight
        var font: Font?
            
        init(titleKey: LocalizedStringKey) {
            self.title = titleKey
            self.weight = .bold
            self.font = nil
        }
        
        init(verbatim: String) {
            self.title = LocalizedStringKey(stringLiteral: verbatim)
            self.weight = .bold
            self.font = nil
        }
    }
}

public struct SKTitle: View, SKComponent {

    public let type: SKComponentType = .header
    var data: SKTitle.Data
    public var body: some View {
        #if os(iOS)
        SKTitleIOS(data: data)
        #elseif os(macOS)
        SKTitleMACOS(data: data)
        #elseif os(tvOS)
        SKTitleTVOS(data: data)
        #elseif os(visionOS)
        SKTitleVISIONOS(data: data)
        #elseif os(watchOS)
        SKTitleWATCHOS(data: data)
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
