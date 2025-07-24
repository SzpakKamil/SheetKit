//
//  AlignmentKey
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct AccentColorKey: EnvironmentKey {
    #if os(tvOS)
    static let defaultValue: Color = .blue
    #else
    static let defaultValue: Color = .accentColor
    #endif
}
extension EnvironmentValues {
    var accentColor: Color {
        get { self[AccentColorKey.self] }
        set { self[AccentColorKey.self] = newValue }
    }
}
