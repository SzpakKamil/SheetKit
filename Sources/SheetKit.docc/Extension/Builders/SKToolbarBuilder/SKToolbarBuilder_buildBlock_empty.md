# ``SheetKit/SKToolbarBuilder/buildBlock()``

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

A result builder function that returns an empty array when no toolbar items are provided.

## Overview

The ``SKToolbarBuilder/buildBlock()`` function is a component of the ``SKToolbarBuilder`` result builder in the `SheetKit` package. It returns an empty array of ``SKToolbarItem`` when no items are provided to the ``SKToolbarBuilder``. This function ensures that the toolbar can handle cases where no content is specified, maintaining a valid array structure for rendering in a declarative, SwiftUI-like syntax.

This function is used internally by the ``SKToolbarBuilder`` when processing items passed to a toolbar initializer, such as `@SKToolbarBuilder items: [SKToolbarItem]`, to handle scenarios where no items are included.

## Example

The following example demonstrates how ``SKToolbarBuilder`` (including ``SKToolbarBuilder/buildBlock()``) is used to create a toolbar with no items:

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
                        // No items provided, handled by buildBlock()
                    }
                }
        }
    }
}
```

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar with no items specified. The ``SKToolbarBuilder/buildBlock()`` function within ``SKToolbarBuilder`` returns an empty array of `SKToolbarItem`, ensuring the toolbar can still render without errors.
