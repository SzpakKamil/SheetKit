# ``SheetKit/SKToolbarBuilder/buildLimitedAvailability(_:)``

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

A result builder function that processes an array of ``SKToolbarItem`` for a conditional compiler-control statement that performs an availability check.

## Overview

The ``SKToolbarBuilder/buildLimitedAvailability(_:)`` function is a component of the ``SKToolbarBuilder`` result builder in the `SheetKit` package. It takes an array of ``SKToolbarItem`` components and processes them for inclusion in a conditional compiler-control statement, such as `#available`, ensuring that the items are only included when the specified platform or version requirements are met. This function is crucial for handling platform-specific or version-specific toolbar content in a declarative, SwiftUI-like syntax.

This function is used internally by the ``SKToolbarBuilder`` when processing items passed to a toolbar initializer, such as `@SKToolbarBuilder items: [SKToolbarItem]`, to handle cases where items are conditionally included based on availability checks.

## Example

The following example demonstrates how ``SKToolbarBuilder`` (including ``SKToolbarBuilder/buildLimitedAvailability(_:)``) is used to create a toolbar with items conditionally included based on an availability check:

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
                        if #available(iOS 18.0, *) {
                            // Item included only on iOS 18.0 or later
                            SKToolbarItem(systemName: "photo") {
                                // Action for photo button
                            }
                        }
                    }
                }
        }
    }
}
```

In this example, the toolbar uses the ``SKToolbarBuilder`` to compose a toolbar containing a primary `SKToolbarItem` and a conditional item that is only included on iOS 18.0 or later. The ``SKToolbarBuilder/buildLimitedAvailability(_:)`` function within ``SKToolbarBuilder`` processes the items within the `#available` block, ensuring they are included in the final array of ``SKToolbarItem`` only when the availability condition is met.
