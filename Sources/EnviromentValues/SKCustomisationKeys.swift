//
//  SKCustomisationKeys.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/08/2025.
//

import SwiftUI


private struct SKRowBackgroundColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}
private struct SKRowShapeKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}
private struct SKRowSpacingKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}
private struct SKIsInSection: EnvironmentKey {
    static let defaultValue: Bool = false
}
private struct SKAccentColorKey: EnvironmentKey {
    #if os(tvOS)
    static let defaultValue: Color = .blue
    #else
    static let defaultValue: Color = .accentColor
    #endif
}
private struct SKPrimaryColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}
private struct SKSecondaryColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}
private struct SKSheetSizeKey: EnvironmentKey {
    static let defaultValue: SKSheetSize = .large
}
private struct SKSheetSizeDentsKey: EnvironmentKey {
    static let defaultValue: Set<PresentationDetent>? = nil
}
private struct SKSheetSizeDentsSelectionKey: EnvironmentKey {
    static let defaultValue: Binding<PresentationDetent>? = nil
}
private struct SKSheetDragIndicatorVisibilityKey: EnvironmentKey {
    static let defaultValue: Visibility = .hidden
}
private struct SKSheetInteractiveDismissDisabledKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var skRowBackgroundColor: Color? {
        get { self[SKRowBackgroundColorKey.self] }
        set { self[SKRowBackgroundColorKey.self] = newValue }
    }
    var skIsInSection: Bool {
        get { self[SKIsInSection.self] }
        set { self[SKIsInSection.self] = newValue }
    }
    var skRowShape: CGFloat? {
        get { self[SKRowShapeKey.self] }
        set { self[SKRowShapeKey.self] = newValue }
    }
    var skRowSpacing: CGFloat? {
        get { self[SKRowSpacingKey.self] }
        set { self[SKRowSpacingKey.self] = newValue }
    }
    var skAccentColor: Color {
        get { self[SKAccentColorKey.self] }
        set { self[SKAccentColorKey.self] = newValue }
    }
    var skPrimaryColor: Color? {
        get { self[SKPrimaryColorKey.self] }
        set { self[SKPrimaryColorKey.self] = newValue }
    }
    var skSecondaryColor: Color? {
        get { self[SKSecondaryColorKey.self] }
        set { self[SKSecondaryColorKey.self] = newValue }
    }
    var skSheetSize: SKSheetSize {
        get { self[SKSheetSizeKey.self] }
        set { self[SKSheetSizeKey.self] = newValue }
    }
    var skSheetSizeDents: Set<PresentationDetent>? {
        get { self[SKSheetSizeDentsKey.self] }
        set { self[SKSheetSizeDentsKey.self] = newValue }
    }
    var skSheetSizeDentsSelection: Binding<PresentationDetent>? {
        get { self[SKSheetSizeDentsSelectionKey.self] }
        set { self[SKSheetSizeDentsSelectionKey.self] = newValue }
    }
    var skSheetDragIndicatorVisibility: Visibility {
        get { self[SKSheetDragIndicatorVisibilityKey.self] }
        set { self[SKSheetDragIndicatorVisibilityKey.self] = newValue }
    }
    var skSheetInteractiveDismissDisabled: Bool {
        get { self[SKSheetInteractiveDismissDisabledKey.self] }
        set { self[SKSheetInteractiveDismissDisabledKey.self] = newValue }
    }
}
