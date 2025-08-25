# ``SheetKit/SKToolbarBuilder/buildBlock(_:)-([SKToolbarItem])``

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

A result builder function that processes a single array of ``SKToolbarItem`` for use in a toolbar.

## Overview

The ``SKToolbarBuilder/buildBlock(_:)-([SKToolbarItem])`` function, specifically for a single array of ``SKToolbarItem``, is a component of the ``SKToolbarBuilder`` result builder in the `SheetKit` package. It takes a single array of `SKToolbarItem` components and returns it unchanged as an array of `SKToolbarItem`. This function works in pair with ``SKToolbarBuilder/buildExpression(_:)`` to process linear item passages. The `@resultBuilder` attribute ensures that the type of items passed is automatically transformed, so the specific input type does not matter, allowing seamless integration into the toolbar structure.

This function is used internally by the ``SKToolbarBuilder`` when processing items passed to a toolbar initializer, such as `@SKToolbarBuilder items: [SKToolbarItem]`, to handle cases where items are provided as a single array.

## Example

The following example demonstrates how ``SKToolbarBuilder`` (including ``SKToolbarBuilder/buildBlock(_:)-([SKToolbarItem])`` for a single array) is used to create a toolbar with a single item:

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
                    }
                }
        }
    }
}
```

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar containing a single `SKToolbarItem` with a system icon and associated action. The ``SKToolbarBuilder/buildExpression(_:)`` function processes the variadic sequence of ``SKToolbarItem``, and the ``SKToolbarBuilder/buildBlock(_:)-([SKToolbarItem])`` function transforms these into a final array of `SKToolbarItem` for rendering within the toolbar. The `@resultBuilder` ensures that the item types are automatically handled.