//
//  SKToolbarKeys
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SKIsCloseButtonHiddenKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
private struct SKIsShowingBackButtonKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
private struct SKToolbarPlacementKey: EnvironmentKey {
    static let defaultValue: SKToolbarItem.Placement? = nil
}
extension EnvironmentValues {
    var skIsCloseButtonHidden: Bool {
        get { self[SKIsCloseButtonHiddenKey.self] }
        set { self[SKIsCloseButtonHiddenKey.self] = newValue }
    }
    var skIsShowingBackButton: Bool {
        get { self[SKIsShowingBackButtonKey.self] }
        set { self[SKIsShowingBackButtonKey.self] = newValue }
    }
    var skToolbarPlacement: SKToolbarItem.Placement? {
        get { self[SKToolbarPlacementKey.self] }
        set { self[SKToolbarPlacementKey.self] = newValue }
    }
}

