//
//  ViewToComponent.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/07/2025.
//

import SwiftUI

public
extension View {
    public var asComponent: SKComponent {
        SKCustomView(type: .highlight) {
            self
        }
    }
}
