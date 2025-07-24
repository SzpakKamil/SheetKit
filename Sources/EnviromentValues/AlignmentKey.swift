//
//  AlignmentKey
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct AlignmentKey: EnvironmentKey {
    static let defaultValue: HorizontalAlignment? = nil
}
extension EnvironmentValues {
    var alignment: HorizontalAlignment? {
        get { self[AlignmentKey.self] }
        set { self[AlignmentKey.self] = newValue }
    }
}
