//
//  SKAlignmentKey.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SKAlignmentKey: EnvironmentKey {
    static let defaultValue: HorizontalAlignment? = nil
}
public extension EnvironmentValues {
    var skAlignment: HorizontalAlignment? {
        get { self[SKAlignmentKey.self] }
        set { self[SKAlignmentKey.self] = newValue }
    }
}
