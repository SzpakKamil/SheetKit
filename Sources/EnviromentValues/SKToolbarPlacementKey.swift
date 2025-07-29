//
//  AlignmentKey
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SKToolbarPlacementKey: EnvironmentKey {
    static let defaultValue: SKToolbarItem.Placement? = nil
}
extension EnvironmentValues {
    var skToolbarPlacement: SKToolbarItem.Placement? {
        get { self[SKToolbarPlacementKey.self] }
        set { self[SKToolbarPlacementKey.self] = newValue }
    }
}
