//
//  ViewToComponent.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/07/2025.
//

import SwiftUI

extension View {
    var asComponent: SKComponent {
        SKCustomView(type: .customView) {
            self
        }
    }
}
