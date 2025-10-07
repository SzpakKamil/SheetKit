//
//  SKAlert.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import Foundation
import SwiftUI

public enum Style{
    case plain
    case `default`
}
    
public struct SKAlert{
    let title: String
    let description: String
    let content: AnyView
    let type: AlertType?
    var isPresented: Binding<Bool>
    
    public init(isPresented: Binding<Bool>, title: String, description: String, type: AlertType? = nil, @ViewBuilder content: @escaping () -> some View) {
        self.isPresented = isPresented
        self.title = title
        self.description = description
        self.type = type
        self.content = AnyView(content())
    }
    
    public enum AlertType{
        case confirmation
        case dismissal
    }
}
