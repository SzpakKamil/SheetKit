# ``SheetKit/SKSheetBuilder/buildOptional(_:)``

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

A result builder function that processes an optional array of ``SKPage`` for use in ``SKSheetView``.

## Overview

The ``SKSheetBuilder/buildOptional(_:)`` function is a component of the ``SKSheetBuilder`` result builder in the `SheetKit` package. It takes an optional array of `SKPage` components (`[SKPage]?`) and returns either the provided pages or an empty array if the input is `nil`. This function is used to handle optional page declarations, ensuring that the ``SKSheetView`` structure can process cases where pages may or may not be provided. The `@resultBuilder` attribute ensures that the pages are automatically transformed into an array of `SKPage`, making the specific input type irrelevant for seamless integration.

This function is used internally by the ``SKSheetBuilder`` when processing pages passed to an ``SKSheetView`` initializer, such as `@SKSheetBuilder pages: [SKPage]`, to handle optional page groups.

## Example

The following example demonstrates how ``SKSheetBuilder`` (including ``SKSheetBuilder/buildOptional(_:)``) is used to create a sheet with an optional set of pages:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    @State private var showExtraPage = false
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage {
                        SKHeaderImage(systemName: "camera")
                        SKTitle("SKPage Example")
                        SKDescription("This is a sample description for the page.")
                    }
                    if showExtraPage {
                        // Optional page processed by buildOptional(_:)
                        SKPage {
                            SKHeaderImage(systemName: "photo")
                            SKTitle("Extra Page")
                            SKDescription("This is an optional page.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing a primary page and an optional page that is included only when `showExtraPage` is `true`. The ``SKSheetBuilder/buildOptional(_:)`` function processes the optional page, returning it as an array of `SKPage` if present, or an empty array if `nil`. This array is then processed by ``SKSheetBuilder/buildBlock(_:)-(SKPage...)`` or other relevant ``SKSheetBuilder/buildBlock()`` functions to create the final array for rendering within the ``SKSheetView``. The `@resultBuilder` ensures that the page types are automatically handled. The ``SKSheetManager/show(id:view:)`` method presents the sheet.