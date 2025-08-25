# ``SheetKit/SKPageBuilder/buildEither(second:)``

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

A result builder function that processes an array of ``SKComponent`` for the false branch of a conditional statement.

## Overview

The ``SKPageBuilder/buildEither(second:)`` function is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes an array of components conforming to the ``SKComponent`` protocol (`[any SKComponent]`) and processes them for inclusion in the `false` branch of a conditional statement. This function returns the provided components as an array of `[any SKComponent]`, ensuring they are included in the ``SKPage`` structure when the condition evaluates to `false`.

This function is used internally by the ``SKPageBuilder`` when processing components passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle the `false` branch of conditional logic in a declarative, SwiftUI-like syntax.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildEither(second:)``) is used to create a sheet with components conditionally included in the `false` branch:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    @State private var isFeatureEnabled = false
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage {
                        SKHeaderImage(systemName: "camera")
                        SKTitle("SKPage Example")
                        SKDescription("This is a sample description for the page.")
                        if isFeatureEnabled {
                            SKDescription("Feature is enabled.")
                        } else {
                            // Handled by buildEither(second:)
                            SKDescription("Feature is disabled.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, a description, and a conditional description included only when `isFeatureEnabled` is `false`. The ``SKPageBuilder/buildEither(second:)`` function processes the components in the `false` branch, incorporating them into the final array of `[any SKComponent]` for rendering within the ``SKSheetView``. The ``SKSheetManager/show(id:view:)`` method presents the sheet.
