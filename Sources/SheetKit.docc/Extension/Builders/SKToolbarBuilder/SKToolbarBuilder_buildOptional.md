# ``SheetKit/SKToolbarBuilder/buildOptional(_:)``

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

A result builder function that processes an optional array of ``SKToolbarItem`` for use in a toolbar.

## Overview

The ``SKToolbarBuilder/buildOptional(_:)`` function is a component of the ``SKToolbarBuilder`` result builder in the `SheetKit` package. It takes an optional array of ``SKToolbarItem`` components (`[SKToolbarItem]?`) and returns either the provided items or an empty array if the input is `nil`. This function is used to handle optional item declarations, ensuring that the toolbar structure can process cases where items may or may not be provided. The `@resultBuilder` attribute ensures that the items are automatically transformed into an array of ``SKToolbarItem``, making the specific input type irrelevant for seamless integration.

This function is used internally by the ``SKToolbarBuilder`` when processing items passed to a toolbar initializer, such as `@SKToolbarBuilder items: [SKToolbarItem]`, to handle optional item groups.

## Example

The following example demonstrates how ``SKToolbarBuilder`` (including ``SKToolbarBuilder/buildOptional(_:)``) is used to create a toolbar with an optional set of items:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skToolbarManager) var toolbarManager
    @State private var showExtraItem = false
    
    var body: some View {
        NavigationView {
            Text("Example Content")
                .toolbar {
                    SKToolbarBuilder {
                        SKToolbarItem(systemName: "plus") {
                            // Action for add button
                        }
                        if showExtraItem {
                            // Optional item processed by buildOptional(_:)
                            SKToolbarItem(systemName: "trash") {
                                // Action for delete button
                            }
                        }
                    }
                }
        }
    }
}
```

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar containing a primary ``SKToolbarItem`` and an optional item that is included only when `showExtraItem` is `true`. The ``SKToolbarBuilder/buildOptional(_:)`` function processes the optional item, returning it as an array of ``SKToolbarItem`` if present, or an empty array if `nil`. This array is then processed by ``SKToolbarBuilder/buildBlock(_:)-(SKToolbarItem...)`` or other relevant ``SKToolbarBuilder/buildBlock()`` functions to create the final array for rendering within the toolbar.
