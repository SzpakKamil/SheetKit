# ``SheetKit/SKSheetBuilder/buildBlock(_:)-(SKPage...)``

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

A result builder function that processes a variadic sequence of ``SKPage`` into an array for use in ``SKSheetView``.

## Overview

The ``SKSheetBuilder/buildBlock(_:)-(SKPage...)`` function, specifically for variadic ``SKPage`` sequences, is a component of the ``SKSheetBuilder`` result builder in the `SheetKit` package. It takes a variadic sequence of `SKPage` components and converts them into an array of `SKPage`. This function works in conjunction with ``SKSheetBuilder/buildExpression(_:)`` to process linear page declarations, ensuring seamless integration into the ``SKSheetView`` structure. The `@resultBuilder` attribute ensures that the type of pages passed is automatically transformed, so the specific input type does not matter.

This function is used internally by the ``SKSheetBuilder`` when processing pages passed to an ``SKSheetView`` initializer, such as `@SKSheetBuilder pages: [SKPage]`, to handle straightforward, linear page declarations.

## Example

The following example demonstrates how ``SKSheetBuilder`` (including ``SKSheetBuilder/buildBlock(_:)-(SKPage...)`` for variadic pages) is used to create a sheet with a linear sequence of pages:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    // Linear sequence of pages processed by buildBlock(_:)-variadic
                    SKPage {
                        SKHeaderImage(systemName: "camera")
                        SKTitle("First Page")
                        SKDescription("This is the first page of the sheet.")
                    }
                    SKPage {
                        SKHeaderImage(systemName: "photo")
                        SKTitle("Second Page")
                        SKDescription("This is the second page of the sheet.")
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing two pages, each with a header image, title, and description. The ``SKSheetBuilder/buildExpression(_:)`` function processes the variadic sequence of ``SKPage`` into an array, which is then passed to ``SKSheetBuilder/buildBlock(_:)-(SKPage...)`` to create the final array of `SKPage` for rendering within the ``SKSheetView``. The `@resultBuilder` ensures that the page types are automatically handled. The ``SKSheetManager/show(id:view:)`` method presents the sheet.