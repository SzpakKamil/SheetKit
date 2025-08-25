# ``SheetKit/SKSheetBuilder/buildBlock(_:)-([SKPage])``

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

A result builder function that processes a single array of ``SKPage`` for use in ``SKSheetView``.

## Overview

The ``SKSheetBuilder/buildBlock(_:)-([SKPage])`` function, specifically for a single array of ``SKPage``, is a component of the ``SKSheetBuilder`` result builder in the `SheetKit` package. It takes a single array of `SKPage` components and returns it unchanged as an array of `SKPage`. This function works in pair with ``SKSheetBuilder/buildExpression(_:)`` to process linear page passages. The `@resultBuilder` attribute ensures that the type of pages passed is automatically transformed, so the specific input type does not matter, allowing seamless integration into the ``SKSheetView`` structure.

This function is used internally by the ``SKSheetBuilder`` when processing pages passed to an ``SKSheetView`` initializer, such as `@SKSheetBuilder pages: [SKPage]`, to handle cases where pages are provided as a single array.

## Example

The following example demonstrates how ``SKSheetBuilder`` (including ``SKSheetBuilder/buildBlock(_:)-([SKPage])`` for a single array) is used to create a sheet with a single page:

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
                        SKTitle("SKPage Example")
                        SKDescription("This is a sample description for the page.")
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing a single page with a header image, title, and description. The ``SKSheetBuilder/buildExpression(_:)`` function processes the variadic sequence of ``SKPage``, and the ``SKSheetBuilder/buildBlock(_:)-([SKPage])`` function transforms these into a final array of `SKPage` for rendering within the ``SKSheetView``. The `@resultBuilder` ensures that the page types are automatically handled. The ``SKSheetManager/show(id:view:)`` method presents the sheet.