# ``SheetKit/SKSheetBuilder/buildBlock(_:)-([SKPage]...)``

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

A result builder function that processes multiple arrays of ``SKPage`` structs into a flattened array for use in ``SKSheetView``.

## Overview

The ``SKSheetBuilder/buildBlock(_:)-([SKPage]...)`` function, specifically for multiple arrays of ``SKPage``, is a component of the ``SKSheetBuilder`` result builder in the `SheetKit` package. It takes a variadic sequence of arrays of ``SKPage`` structs and flattens them into a single array of ``SKPage``. This function works in pair with ``SKSheetBuilder/buildExpression(_:)`` to process page passages. The `@resultBuilder` attribute ensures that the pages are automatically transformed, allowing seamless integration into the ``SKSheetView`` structure.

This function is used internally by the ``SKSheetBuilder`` when processing pages passed to an ``SKSheetView`` initializer, such as `@SKSheetBuilder pages: [SKPage]`, to handle cases where pages are provided as multiple arrays.

## Example

The following example demonstrates how ``SKSheetBuilder`` (including ``SKSheetBuilder/buildBlock(_:)-([SKPage]...)`` for multiple arrays) is used to create a sheet with multiple pages:

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
                        SKHeaderImage(systemName: "camera")
                        SKTitle("First Page")
                        Text("This is the first page of the sheet.")
                    }
                    SKPage {
                        Text("Second Page Content")
                            .font(.title)
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing two ``SKPage`` structs: one with a header image, title, and SwiftUI `Text` view, and another with a custom `Text` view. The ``SKSheetBuilder/buildExpression(_:)`` function processes the variadic sequence of ``SKPage``, and the ``SKSheetBuilder/buildBlock(_:)-([SKPage]...)`` function transforms these into a final array of ``SKPage`` for rendering within the ``SKSheetView``. The `@resultBuilder` ensures that the page types are automatically handled. The ``SKSheetManager/show(id:view:)`` method presents the sheet.