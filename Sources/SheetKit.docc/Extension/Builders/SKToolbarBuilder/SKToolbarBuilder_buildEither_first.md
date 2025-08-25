# ``SheetKit/SKToolbarBuilder/buildEither(first:)``

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

A result builder function that processes an array of ``SKToolbarItem`` for the true branch of a conditional statement.

## Overview

The ``SKToolbarBuilder/buildEither(first:)`` function is a component of the ``SKToolbarBuilder`` result builder in the `SheetKit` package. It takes an array of `SKToolbarItem` components and processes them for inclusion in the `true` branch of a conditional statement. This function returns the provided items as an array of `SKToolbarItem`, ensuring they are included in the toolbar structure when the condition evaluates to `true`.

This function is used internally by the ``SKToolbarBuilder`` when processing items passed to a toolbar initializer, such as `@SKToolbarBuilder items: [SKToolbarItem]`, to handle the `true` branch of conditional logic in a declarative, SwiftUI-like syntax.

## Example

The following example demonstrates how ``SKToolbarBuilder`` (including ``SKToolbarBuilder/buildEither(first:)``) is used to create a toolbar with items conditionally included in the `true` branch:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skToolbarManager) var toolbarManager
    @State private var isFeatureEnabled = true
    
    var body: some View {
        NavigationView {
            Text("Example Content")
                .toolbar {
                    SKToolbarBuilder {
                        SKToolbarItem(systemName: "plus") {
                            // Action for add button
                        }
                        if isFeatureEnabled {
                            // Handled by buildEither(first:)
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

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar containing a primary ``SKToolbarItem`` and a conditional item included only when `isFeatureEnabled` is `true`. The ``SKToolbarBuilder/buildEither(first:)`` function processes the items in the `true` branch, incorporating them into the final array of ``SKToolbarItem`` for rendering within the toolbar.
