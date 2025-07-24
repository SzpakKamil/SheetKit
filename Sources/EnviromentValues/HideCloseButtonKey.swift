//
//  AlignmentKey
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct HideCloseButtonKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
extension EnvironmentValues {
    var closeButtonHidden: Bool {
        get { self[HideCloseButtonKey.self] }
        set { self[HideCloseButtonKey.self] = newValue }
    }
}
