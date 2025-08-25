//  Copyright © 2023 Paramount. All rights reserved.
#if os(tvOS)
internal import UIKit

@_documentation(visibility: internal)
struct SKTPickerViewStyle: Equatable {
    var componentSpacing: CGFloat

    struct Backgrounds: Equatable {
        var selectedCellBackgroundColor: UIColor
        var focusedCellBackgroundColor: UIColor

        init(selectedCellBackgroundColor: UIColor, focusedCellBackgroundColor: UIColor) {
            self.selectedCellBackgroundColor = selectedCellBackgroundColor
            self.focusedCellBackgroundColor = focusedCellBackgroundColor
        }
    }
    var backgrounds: Backgrounds

    struct Labels: Equatable {
        var selectedCellTextColor: UIColor
        var unselectedCellTextColor: UIColor
        var focusedCellTextColor: UIColor
        var disabledCellTextColor: UIColor
        var font: UIFontDescriptor?
        var focusedFont: UIFontDescriptor?

        init(
            selectedCellTextColor: UIColor,
            unselectedCellTextColor: UIColor,
            focusedCellTextColor: UIColor,
            disabledCellTextColor: UIColor,
            font: UIFontDescriptor? = nil,
            focusedFont: UIFontDescriptor? = nil
        ) {
            self.selectedCellTextColor = selectedCellTextColor
            self.unselectedCellTextColor = unselectedCellTextColor
            self.focusedCellTextColor = focusedCellTextColor
            self.disabledCellTextColor = disabledCellTextColor
            self.font = font
            self.focusedFont = focusedFont
        }
    }
    var labels: Labels

    init(
        componentSpacing: CGFloat,
        backgrounds: Backgrounds,
        labels: Labels
    ) {
        self.componentSpacing = componentSpacing
        self.backgrounds = backgrounds
        self.labels = labels
    }
}

@_documentation(visibility: internal)
extension SKTPickerViewStyle {
    static let `default` = SKTPickerViewStyle(
        componentSpacing: 0,
        backgrounds: .init(
            selectedCellBackgroundColor: .lightGray,
            focusedCellBackgroundColor: .white
        ),
        labels: .init(
            selectedCellTextColor: .black,
            unselectedCellTextColor: .white,
            focusedCellTextColor: .black,
            disabledCellTextColor: .white.withAlphaComponent(0.3)
        )
    )
}
#endif
