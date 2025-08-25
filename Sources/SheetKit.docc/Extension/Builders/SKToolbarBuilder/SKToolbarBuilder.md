# ``SheetKit/SKToolbarBuilder``

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

A result builder for constructing arrays of ``SKToolbarItem`` in a toolbar for creating polished, native-looking toolbars across all Apple platforms with the same code.

## Overview

The ``SKToolbarBuilder`` is a result builder that enables declarative construction of toolbar content in the `SheetKit` package. It collects and processes `SKToolbarItem` components, returning an array of `SKToolbarItem` for use within a toolbar structure. This allows developers to compose complex toolbar layouts with items such as buttons, menus, or spacers in a SwiftUI-like syntax.

To use ``SKToolbarBuilder``, you need to define it inside the initializer, like `@SKToolbarBuilder items: [SKToolbarItem]`. This allows the builder to process the toolbar items and return an array for usage.

The builder supports various control flow constructs, such as conditionals, optional items, and platform-specific items, ensuring flexibility in building dynamic toolbar content.

### Supported Features

The ``SKToolbarBuilder`` supports the following features for constructing toolbar content:

- **Linear Sequences**: Define multiple ``SKToolbarItem`` components in a straightforward, sequential manner, processed into a single array.
- **Empty Initialization**: Handle cases where no items are provided, returning an empty `[SKToolbarItem]` array.
- **If-Else Statements**: Conditionally include ``SKToolbarItem`` components using `if` and `else` branches, supporting dynamic content based on runtime conditions.
- **Optional Elements**: Process optional ``SKToolbarItem`` components, including them only when present, or returning an empty array if `nil`.
- **For Loops with SKForEach**: Generate multiple ``SKToolbarItem`` components dynamically using the ``SKForEach`` component to iterate over a data collection.

## Example

The following example demonstrates how to use ``SKToolbarBuilder`` to create a toolbar with multiple items:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skToolbarManager) var toolbarManager
    
    var body: some View {
        NavigationView {
            Text("Example Content")
                .toolbar {
                    SKToolbarBuilder {
                        SKToolbarItem(systemName: "plus") {
                            // Action for add button
                        }
                        SKToolbarItem(systemName: "trash") {
                            // Action for delete button
                        }
                    }
                }
        }
    }
}
```

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar containing two `SKToolbarItem` components, each with a system icon and associated action. The ``SKToolbarBuilder`` processes the provided items into an array of `SKToolbarItem` for rendering within the toolbar.
