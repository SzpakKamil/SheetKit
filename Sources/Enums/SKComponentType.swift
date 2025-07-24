//
//  SwiftUIView.swift
//  SheetKit
//
//  Created by Kamil Szpak on 20/07/2025.
//

import SwiftUI

public enum SKComponentType: Hashable, Identifiable, Equatable{
    case header
    case highlight
    case forEach
    case field
    
    public var name: String{
        switch self {
        case .header:
            "Header"
        case .highlight:
            "Hilight"
        case .forEach:
            "ForEach"
        case .field:
            "Field"
        }
    }
    
    public var id: String{
        return name
    }
    
    public static func ==(lhs: SKComponentType, rhs: SKComponentType) -> Bool{
        lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
