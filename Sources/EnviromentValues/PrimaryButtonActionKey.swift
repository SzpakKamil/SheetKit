//
//  PrimaryButtonActionKey.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct PrimaryActionEnvironmentKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}
extension EnvironmentValues {
    var primaryAction: () -> Void {
        get { self[PrimaryActionEnvironmentKey.self] }
        set { self[PrimaryActionEnvironmentKey.self] = newValue }
    }
}
