# ``SheetKit/SKToolbarBuilder/buildBlock(_:)-(SKToolbarItem...)``

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

A result builder function that processes a variadic sequence of ``SKToolbarItem`` into an array.

## Overview

The ``SKToolbarBuilder/buildBlock(_:)-(SKToolbarItem...)`` function, specifically for variadic ``SKToolbarItem`` sequences, is a component of the ``SKToolbarBuilder`` result builder in the `SheetKit` package. It takes a variadic sequence of ``SKToolbarItem`` components and converts them into an array of ``SKToolbarItem``. This function works in conjunction with ``SKToolbarBuilder/buildExpression(_:)`` to process linear item declarations, ensuring seamless integration into the toolbar structure. The `@resultBuilder` attribute ensures that the type of items passed is automatically transformed, so the specific input type does not matter.

This function is used internally by the ``SKToolbarBuilder`` when processing items passed to a toolbar initializer, such as `@SKToolbarBuilder items: [SKToolbarItem]`, to handle straightforward, linear item declarations.

## Example

The following example demonstrates how ``SKToolbarBuilder`` (including ``SKToolbarBuilder/buildBlock(_:)-(SKToolbarItem...)`` for variadic items) is used to create a toolbar with a linear sequence of items:

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

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar containing two ``SKToolbarItem`` components, each with a system icon and associated action. The ``SKToolbarBuilder/buildExpression(_:)`` function processes the variadic sequence of ``SKToolbarItem`` into an array, which is then passed to ``SKToolbarBuilder/buildBlock(_:)-(SKToolbarItem...)`` to create the final array of `SKToolbarItem` for rendering within the toolbar.
