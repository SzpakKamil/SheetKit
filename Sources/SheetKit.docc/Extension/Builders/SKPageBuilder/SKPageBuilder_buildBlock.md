# ``SheetKit/SKPageBuilder/buildBlock()``

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

A result builder function that returns an empty array when no components or views are provided for use in ``SKPage``.

## Overview

The ``SKPageBuilder/buildBlock()`` function is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It returns an empty array of `[any SKComponent]` when no components or SwiftUI views are provided to the ``SKPageBuilder``. This function ensures that the ``SKPage`` can handle cases where no content is specified, maintaining a valid array structure for rendering in a declarative, SwiftUI-like syntax.

This function is used internally by the ``SKPageBuilder`` when processing components or SwiftUI views passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle scenarios where no content is included.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildBlock()``) is used to create a sheet with no components or views:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage {
                        // No components or views provided, handled by buildBlock()
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet with no components or views specified. The ``SKPageBuilder/buildBlock()`` function within ``SKPageBuilder`` returns an empty array of `[any SKComponent]`, ensuring the ``SKSheetView`` can still render the sheet without errors. The ``SKSheetManager/show(id:view:)`` method presents the sheet.