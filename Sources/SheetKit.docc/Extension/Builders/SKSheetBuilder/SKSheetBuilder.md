# ``SheetKit/SKSheetBuilder``

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

A result builder for constructing arrays of ``SKPage`` in an ``SKSheetView`` for creating polished, native-looking sheets across all Apple platforms with the same code.

## Overview

The ``SKSheetBuilder`` is a result builder that enables declarative construction of sheet content in the `SheetKit` package. It collects and processes `SKPage` components, returning an array of `SKPage` for use within an ``SKSheetView`` struct. This allows developers to compose complex sheet layouts with pages containing headers, titles, and descriptions in a SwiftUI-like syntax.

To use ``SKSheetBuilder``, you need to define it inside the initializer, like `@SKSheetBuilder pages: [SKPage]`. This allows the builder to process the pages and return an array for usage.

The builder supports various control flow constructs, such as conditionals, loops, and optional pages, ensuring flexibility in building dynamic sheet content.

### Supported Features

The ``SKSheetBuilder`` supports the following features for constructing sheet content:

- **Linear Sequences**: Define multiple ``SKPage`` components in a straightforward, sequential manner, processed into a single array.
- **Empty Initialization**: Handle cases where no pages are provided, returning an empty `[SKPage]` array.
- **If-Else Statements**: Conditionally include ``SKPage`` components using `if` and `else` branches, supporting dynamic content based on runtime conditions.
- **Optional Elements**: Process optional ``SKPage`` components, including them only when present, or returning an empty array if `nil`.
- **For Loops with SKForEach**: Generate multiple ``SKPage`` components dynamically using the ``SKForEach`` component to iterate over a data collection.

## Example

The following example demonstrates how to use ``SKSheetBuilder`` within an ``SKSheetView`` to create a sheet with multiple pages:

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

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing two pages, each with a header image, title, and description. The ``SKSheetManager/show(id:view:)`` method presents the sheet, and the ``SKSheetBuilder`` processes the provided pages into an array of `SKPage` for rendering.
