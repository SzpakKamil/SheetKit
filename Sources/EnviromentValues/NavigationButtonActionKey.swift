//
//  NavigationButtonActionKey.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct NavigationButtonAction: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}
extension EnvironmentValues {
    var navigationAction: () -> Void {
        get { self[NavigationButtonAction.self] }
        set { self[NavigationButtonAction.self] = newValue }
    }
}
