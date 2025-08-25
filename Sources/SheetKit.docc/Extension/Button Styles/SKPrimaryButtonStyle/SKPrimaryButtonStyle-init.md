# ``SheetKit/SKPrimaryButtonStyle/init(isEnabled:accentColor:sheetStyle:colorScheme:)``

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

Initializes a custom `ButtonStyle` for creating primary buttons in the `SheetKit` framework.

## Overview

The `init(isEnabled:accentColor:sheetStyle:colorScheme:)` initializer creates an instance of ``SKPrimaryButtonStyle``, a custom `ButtonStyle` used within the `SheetKit` framework to style primary buttons. This initializer accepts parameters to configure the button’s appearance and behavior, as `@Environment` properties are not supported in `ButtonStyle` structs for Xcode versions earlier than 26. By passing these values explicitly, the initializer ensures compatibility and flexibility across different environments.

### Parameters

- `isEnabled`: A Boolean indicating whether the button is enabled. When `false`, the button may appear disabled and not respond to user interactions.
- `accentColor`: A `Color` value defining the accent color for the button, used to customize its visual appearance.
- `sheetStyle`: An optional ``SKSheetStyle`` that specifies the styling configuration for the sheet containing the button. If `nil`, a default style is applied.
- `colorScheme`: A `ColorScheme` value (e.g., `.light` or `.dark`) that determines the color scheme for the button’s appearance, ensuring consistency with the app’s environment.

## Example

The following example demonstrates how to use `SKPrimaryButtonStyle` to style a button within a `SheetKit` sheet:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button("Primary Action") {
            // Perform action
        }
        .buttonStyle(SKPrimaryButtonStyle(
            isEnabled: true,
            accentColor: .blue,
            sheetStyle: .default,
            colorScheme: colorScheme
        ))
    }
}
```

In this example, a button is styled using ``SKPrimaryButtonStyle`` with an enabled state, a blue accent color, a default sheet style, and the current environment’s color scheme. The button is part of a page within an ``SKSheetView``, presented using the ``SKSheetManager``.

## Declaration

```swift
public init(isEnabled: Bool, accentColor: Color, sheetStyle: SKSheetStyle?, colorScheme: ColorScheme) {
    self.isEnabled = isEnabled
    self.sheetStyle = sheetStyle
    self.accentColor = accentColor
    self.colorScheme = colorScheme
}
```

## See Also

- ``SKPrimaryButtonStyle``
- ``SKSecondaryButtonStyle``
- ``SKNavigationButtonStyle``
- ``SKNoteButtonStyle``
