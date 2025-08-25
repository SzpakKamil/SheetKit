# ``SheetKit/SKSecondaryButtonStyle/init(sheetStyle:isEnabled:accentColor:)``

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

Initializes a custom `ButtonStyle` for creating secondary buttons in the `SheetKit` framework.

## Overview

The `init(sheetStyle:isEnabled:accentColor:)` initializer creates an instance of ``SKSecondaryButtonStyle``, a custom `ButtonStyle` used within the `SheetKit` framework to style secondary action buttons. This initializer accepts parameters to configure the button’s appearance and behavior, as `@Environment` properties are not supported in `ButtonStyle` structs for Xcode versions earlier than 26. By passing these values explicitly, the initializer ensures compatibility and flexibility across different environments. This style is ideal for secondary actions, such as "Log In" as an alternative to a primary action like "Continue without account."

### Parameters

- `sheetStyle`: An optional `SKSheetStyle` that specifies the styling configuration for the sheet containing the button. If `nil`, a default style is applied.
- `isEnabled`: A Boolean indicating whether the button is enabled. When `false`, the button may appear disabled and not respond to user interactions.
- `accentColor`: A `Color` value defining the accent color for the button, used to customize its visual appearance.

## Example

The following example demonstrates how to use ``SKSecondaryButtonStyle`` to style a secondary action button within a `SheetKit` sheet:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    var body: some View {
        Button("Log In") {
            // Perform secondary action
        }
        .buttonStyle(SKSecondaryButtonStyle(
            sheetStyle: .default,
            isEnabled: true,
            accentColor: .blue
        ))
    }
}
```

In this example, a button is styled using ``SKSecondaryButtonStyle`` with a default sheet style, an enabled state, and a blue accent color. The button, labeled "Log In," is part of a page within an ``SKSheetView``, presented using the ``SKSheetManager``.

## Declaration

```swift
public init(sheetStyle: SKSheetStyle?, isEnabled: Bool, accentColor: Color) {
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
