# ``SheetKit/SKPageBuilder``

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

A result builder for constructing arrays of ``SKComponent`` in an ``SKPage`` for creating polished, native-looking sheets across all Apple platforms with the same code.

## Overview

The ``SKPageBuilder`` is a result builder that enables declarative construction of page content in the `SheetKit` package. It collects and processes components conforming to the ``SKComponent`` protocol, returning an array of `[any SKComponent]` for use within an ``SKPage`` struct. This allows developers to compose complex page layouts with components such as headers, titles, descriptions, and other custom elements in a SwiftUI-like syntax.

To use ``SKPageBuilder``, you define it within the initializer of an ``SKPage``, such as `@SKPageBuilder components: () -> [any SKComponent]`. The builder processes the components and returns an array for rendering within the page.

The builder supports various control flow constructs, such as conditionals, loops, and optional components, ensuring flexibility in building dynamic page content.

### Supported Features

The ``SKPageBuilder`` supports the following features for constructing page content:

- **Linear Sequences**: Define multiple ``SKComponent`` instances in a straightforward, sequential manner, processed into a single array.
- **Empty Initialization**: Handle cases where no components are provided, returning an empty `[any SKComponent]` array.
- **If-Else Statements**: Conditionally include ``SKComponent`` instances using `if` and `else` branches, supporting dynamic content based on runtime conditions.
- **Optional Elements**: Process optional ``SKComponent`` instances, including them only when present, or returning an empty array if `nil`.
- **For Loops with SKForEach**: Generate multiple ``SKComponent`` instances dynamically using the ``SKForEach`` component to iterate over a data collection.

## Example

The following example demonstrates how to use ``SKPageBuilder`` within an ``SKPage`` to create a page with a header image, title, description, conditional content, and dynamic content, displayed within an ``SKSheetView``:

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
                        SKTitle("Example Page")
                        SKDescription("This is a sample description for the page.")
                        if someCondition {
                            SKDescription("Conditional content displayed based on a runtime condition.")
                        }
                        SKForEach(1..<3, id: \.self) { index in
                            SKDescription("Dynamic item \(index)")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a page containing a header image, a title, a description, a conditional description, and dynamically generated descriptions using ``SKForEach``. The ``SKSheetManager/show(id:view:)`` method presents the sheet, and the ``SKPageBuilder`` processes the provided components into an array of `[any SKComponent]` for rendering.
