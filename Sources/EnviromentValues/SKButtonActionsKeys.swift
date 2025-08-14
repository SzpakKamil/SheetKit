//
//  SKButtonActionsKeys.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SKDismissButtonActionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}
private struct SKCloseButtonActionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}
private struct SKPrimaryButtonActionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}
private struct SKToolbarButtonActionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}
public extension EnvironmentValues {
    var skDismissButtonAction: () -> Void {
        get { self[SKDismissButtonActionKey.self] }
        set { self[SKDismissButtonActionKey.self] = newValue }
    }
    var skCloseButtonAction: () -> Void {
        get { self[SKCloseButtonActionKey.self] }
        set { self[SKCloseButtonActionKey.self] = newValue }
    }
    var skPrimaryButtonAction: () -> Void {
        get { self[SKPrimaryButtonActionKey.self] }
        set { self[SKPrimaryButtonActionKey.self] = newValue }
    }
    var skToolbarButtonAction: () -> Void {
        get { self[SKToolbarButtonActionKey.self] }
        set { self[SKToolbarButtonActionKey.self] = newValue }
    }
}
