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

A result builder for constructing arrays of ``SKPage`` structs in an ``SKSheetView`` for creating polished, native-looking sheets across all Apple platforms with the same code.

## Overview

The ``SKSheetBuilder`` is a result builder that enables declarative construction of sheet content in the `SheetKit` package. It collects and processes ``SKPage`` structs, which can contain components like headers, titles, descriptions, or custom SwiftUI views, returning an array of ``SKPage`` for use within an ``SKSheetView`` struct. This allows developers to compose complex sheet layouts with pages in a SwiftUI-like syntax.

To use ``SKSheetBuilder``, you define it inside the initializer, like `@SKSheetBuilder pages: [SKPage]`. This allows the builder to process the pages and return an array for rendering.

The builder supports various control flow constructs, such as conditionals, loops, and optional pages, ensuring flexibility in building dynamic sheet content.

### Supported Features

The ``SKSheetBuilder`` supports the following features for constructing sheet content:

- **Linear Sequences**: Define multiple ``SKPage`` structs in a straightforward, sequential manner, processed into a single array.
- **Empty Initialization**: Handle cases where no pages are provided, returning an empty `[SKPage]` array.
- **If-Else Statements**: Conditionally include ``SKPage`` structs using `if` and `else` branches, supporting dynamic content based on runtime conditions.
- **Optional Elements**: Process optional ``SKPage`` structs, including them only when present, or returning an empty array if `nil`.
- **For Loops with SKForEach**: Generate multiple ``SKPage`` structs dynamically using the ``SKForEach`` component to iterate over a data collection.

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

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing two ``SKPage`` structs: one with a header image, title, and SwiftUI `Text` view, and another with a custom `Text` view. The ``SKSheetManager/show(id:view:)`` method presents the sheet, and the ``SKSheetBuilder`` processes the provided ``SKPage`` structs into an array for rendering.