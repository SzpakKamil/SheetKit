# ``SheetKit/SKNoteButtonStyle/init(isEnabled:accentColor:colorScheme:textAlignment:)``

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

Initializes a custom `ButtonStyle` for creating note action buttons in the `SheetKit` framework.

## Overview

The `init(isEnabled:accentColor:colorScheme:textAlignment:)` initializer creates an instance of ``SKNoteButtonStyle``, a custom `ButtonStyle` used within the `SheetKit` framework to style note action buttons. This initializer accepts parameters to configure the button’s appearance and behavior, as `@Environment` properties are not supported in `ButtonStyle` structs for Xcode versions earlier than 26. By passing these values explicitly, the initializer ensures compatibility and flexibility across different environments. This style is ideal for informational actions, such as linking to privacy notes or "know more" content, providing a subtle and accessible appearance across supported platforms. On watchOS, the button uses a specific 'i' icon (`systemImage: "info.circle"`) and is positioned in the middle of the bottom bar, ignoring text and text alignment.

### Parameters

- `isEnabled`: A Boolean indicating whether the button is enabled. When `false`, the button may appear disabled and not respond to user interactions.
- `accentColor`: A `Color` value defining the accent color for the button, used to customize its visual appearance.
- `colorScheme`: A `ColorScheme` value (e.g., `.light` or `.dark`) that determines the color scheme for the button’s appearance, ensuring consistency with the app’s environment.
- `textAlignment`: A `TextAlignment` value (defaulting to `.leading`) that specifies the alignment of the button’s text. This parameter is ignored on watchOS, where only the 'i' icon is used.

## Example

The following example demonstrates how to use ``SKNoteButtonStyle`` to style a note action button within a `SheetKit` sheet:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button("Learn More") {
            // Navigate to informational content
        }
        .buttonStyle(SKNoteButtonStyle(
            isEnabled: true,
            accentColor: .blue,
            colorScheme: colorScheme,
            textAlignment: .leading
        ))
    }
}
```

In this example, a button is styled using ``SKNoteButtonStyle`` with the current environment’s color scheme, an enabled state, a blue accent color, and leading text alignment. The button, labeled "Learn More," is part of a page within an ``SKSheetView``, presented using the ``SKSheetManager``, and is used for a note action such as navigating to informational content. On watchOS, the button would display an 'i' icon instead of the text.

## Declaration

```swift
public init(isEnabled: Bool, accentColor: Color, colorScheme: ColorScheme, textAlignment: TextAlignment = .leading) {
    self.isEnabled = isEnabled
    self.accentColor = accentColor
    self.colorScheme = colorScheme
    self.textAlignment = textAlignment
}
```

## See Also

- ``SKPrimaryButtonStyle``
- ``SKSecondaryButtonStyle``
- ``SKNavigationButtonStyle``
- ``SKNoteButtonStyle``
