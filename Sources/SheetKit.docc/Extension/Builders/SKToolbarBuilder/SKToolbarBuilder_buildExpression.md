# ``SheetKit/SKToolbarBuilder/buildExpression(_:)``

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

A result builder function that processes a variadic sequence of ``SKToolbarItem`` into an array for use in a toolbar.

## Overview

The ``SKToolbarBuilder/buildExpression(_:)`` function, specifically for variadic ``SKToolbarItem`` sequences, is a component of the ``SKToolbarBuilder`` result builder in the `SheetKit` package. It takes a variadic sequence of ``SKToolbarItem`` components and converts them into an array of `SKToolbarItem`. This function is used when items are provided directly without conditionals or optional constructs, and it works in conjunction with ``SKToolbarBuilder/buildBlock(_:)-(SKToolbarItem...)`` functions to transform these items into the final array used by the toolbar.

This function is used internally by the ``SKToolbarBuilder`` when processing items passed to a toolbar initializer, such as `@SKToolbarBuilder items: [SKToolbarItem]`, to handle straightforward item declarations.

## Example

The following example demonstrates how ``SKToolbarBuilder`` (including ``SKToolbarBuilder/buildExpression(_:)`` for items) is used to create a toolbar with a linear sequence of items:

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

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar containing two ``SKToolbarItem`` components, each with a system icon and associated action. The ``SKToolbarBuilder/buildExpression(_:)`` function processes the variadic sequence of ``SKToolbarItem`` into an array of ``SKToolbarItem``, which is then passed to ``SKToolbarBuilder/buildBlock(_:)-(SKToolbarItem...)`` to create the final array for rendering within the toolbar.
