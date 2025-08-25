# ``SheetKit/SKNavigationButtonStyle/init(colorScheme:sheetStyle:isEnabled:accentColor:)``

@Metadata {
    @SupportedLanguage(swift)
    @Available(iOS, introduced: "17.0")
    @Available(iPadOS, introduced: "17.0")
    @Available(tvOS, introduced: "17.0")
    @Available(macOS, introduced: "14.0")
    @Available(watchOS, introduced: "10.0")
    @Available(visionOS, introduced: "1.0")
    @Available(Xcode, introduced: "15.0")
    @Available(swift, introduced: "5.9")
    @DocumentationExtension(mergeBehavior: override)
}

@Options {
    @AutomaticTitleHeading(enabled)
    @AutomaticSeeAlso(disabled)
    @AutomaticArticleSubheading(disabled)
}

Initializes a custom `ButtonStyle` for creating navigation action buttons in the `SheetKit` framework.

## Overview

The `init(colorScheme:sheetStyle:isEnabled:accentColor:)` initializer creates an instance of ``SKNavigationButtonStyle``, a custom `ButtonStyle` used within the `SheetKit` framework to style navigation action buttons. This initializer accepts parameters to configure the button’s appearance and behavior, as `@Environment` properties are not supported in `ButtonStyle` structs for Xcode versions earlier than 26. By passing these values explicitly, the initializer ensures compatibility and flexibility across different environments. This style is ideal for navigation actions, such as moving to another screen when a secondary action is provided or implementing a custom close button, but it should not be used for forward navigation, which is reserved for primary buttons.

### Parameters

- `colorScheme`: A `ColorScheme` value (e.g., `.light` or `.dark`) that determines the color scheme for the button’s appearance, ensuring consistency with the app’s environment.
- `sheetStyle`: An optional `SKSheetStyle` that specifies the styling configuration for the sheet containing the button. If `nil`, a default style is applied.
- `isEnabled`: A Boolean indicating whether the button is enabled. When `false`, the button may appear disabled and not respond to user interactions.
- `accentColor`: A `Color` value defining the accent color for the button, used to customize its visual appearance.

## Example

The following example demonstrates how to use ``SKNavigationButtonStyle`` to style a navigation action button within a `SheetKit` sheet:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button("Back") {
            // Perform navigation action (e.g., custom close)
        }
        .buttonStyle(SKNavigationButtonStyle(
            colorScheme: colorScheme,
            sheetStyle: .default,
            isEnabled: true,
            accentColor: .blue
        ))
    }
}
```

In this example, a button is styled using ``SKNavigationButtonStyle`` with the current environment’s color scheme, a default sheet style, an enabled state, and a blue accent color. The button, labeled "Back," is part of a page within an ``SKSheetView``, presented using the ``SKSheetManager``, and is used for a navigation action such as a custom close.

## Declaration

```swift
public init(colorScheme: ColorScheme, sheetStyle: SKSheetStyle?, isEnabled: Bool, accentColor: Color) {
    self.colorScheme = colorScheme
    self.sheetStyle = sheetStyle
    self.isEnabled = isEnabled
    self.accentColor = accentColor
}
```

## See Also

- ``SKSecondaryButtonStyle``
- ``SKPrimaryButtonStyle``
- ``SKNavigationButtonStyle``
- ``SKNoteButtonStyle``
