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
private struct SKIsContinueButtonHiddenKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
private struct SKIsShowingBackButtonKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
private struct SKToolbarPlacementKey: EnvironmentKey {
    static let defaultValue: SKToolbarItemPlacement? = nil
}
private struct SKIsFinalPageKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
public extension EnvironmentValues {
    var skIsCloseButtonHidden: Bool {
        get { self[SKIsCloseButtonHiddenKey.self] }
        set { self[SKIsCloseButtonHiddenKey.self] = newValue }
    }
    var skIsContinueButtonHidden: Bool {
        get { self[SKIsContinueButtonHiddenKey.self] }
        set { self[SKIsContinueButtonHiddenKey.self] = newValue }
    }
    var skIsShowingBackButton: Bool {
        get { self[SKIsShowingBackButtonKey.self] }
        set { self[SKIsShowingBackButtonKey.self] = newValue }
    }
    var skToolbarPlacement: SKToolbarItemPlacement? {
        get { self[SKToolbarPlacementKey.self] }
        set { self[SKToolbarPlacementKey.self] = newValue }
    }
    var skIsFinalPage: Bool {
        get { self[SKIsFinalPageKey.self] }
        set { self[SKIsFinalPageKey.self] = newValue }
    }
}

