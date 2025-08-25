# ``SheetKit/SKSheetBuilder/buildBlock()``

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

A result builder function that returns an empty array when no pages are provided for use in ``SKSheetView``.

## Overview

The ``SKSheetBuilder/buildBlock()`` function is a component of the ``SKSheetBuilder`` result builder in the `SheetKit` package. It returns an empty array of `SKPage` when no pages are provided to the ``SKSheetBuilder``. This function ensures that the ``SKSheetView`` can handle cases where no content is specified, maintaining a valid array structure for rendering in a declarative, SwiftUI-like syntax.

This function is used internally by the ``SKSheetBuilder`` when processing pages passed to an ``SKSheetView`` initializer, such as `@SKSheetBuilder pages: [SKPage]`, to handle scenarios where no pages are included.

## Example

The following example demonstrates how ``SKSheetBuilder`` (including ``SKSheetBuilder/buildBlock()``) is used to create a sheet with no pages:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    // No pages provided, handled by buildBlock()
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet with no pages specified. The ``SKSheetBuilder/buildBlock()`` function within ``SKSheetBuilder`` returns an empty array of `SKPage`, ensuring the ``SKSheetView`` can still render the sheet without errors. The ``SKSheetManager/show(id:view:)`` method presents the sheet.