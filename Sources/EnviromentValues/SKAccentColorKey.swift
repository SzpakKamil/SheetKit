//
//  AlignmentKey
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SKAccentColorKey: EnvironmentKey {
    #if os(tvOS)
    static let defaultValue: Color = .blue
    #else
    static let defaultValue: Color = .accentColor
    #endif
}
extension EnvironmentValues {
    var skAccentColor: Color {
        get { self[SKAccentColorKey.self] }
        set { self[SKAccentColorKey.self] = newValue }
    }
}
