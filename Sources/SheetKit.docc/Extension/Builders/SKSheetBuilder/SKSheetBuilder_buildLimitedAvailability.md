# ``SheetKit/SKSheetBuilder/buildLimitedAvailability(_:)``

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

A result builder function that processes an array of ``SKPage`` for a conditional compiler-control statement that performs an availability check.

## Overview

The ``SKSheetBuilder/buildLimitedAvailability(_:)`` function is a component of the ``SKSheetBuilder`` result builder in the `SheetKit` package. It takes an array of `SKPage` components and processes them for inclusion in a conditional compiler-control statement, such as `#available`, ensuring that the pages are only included when the specified platform or version requirements are met. This function is crucial for handling platform-specific or version-specific sheet content in a declarative, SwiftUI-like syntax.

This function is used internally by the ``SKSheetBuilder`` when processing pages passed to an ``SKSheetView`` initializer, such as `@SKSheetBuilder pages: [SKPage]`, to handle cases where pages are conditionally included based on availability checks.

## Example

The following example demonstrates how ``SKSheetBuilder`` (including ``SKSheetBuilder/buildLimitedAvailability(_:)``) is used to create a sheet with pages conditionally included based on an availability check:

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
                        SKTitle("SKPage Example")
                        SKDescription("This is a sample description for the page.")
                    }
                    if #available(iOS 18.0, *) {
                        // Page included only on iOS 18.0 or later
                        SKPage {
                            SKHeaderImage(systemName: "photo")
                            SKTitle("iOS 18 Page")
                            SKDescription("This page is available on iOS 18.0+.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing a primary page and a conditional page that is only included on iOS 18.0 or later. The ``SKSheetBuilder/buildLimitedAvailability(_:)`` function within ``SKSheetBuilder`` processes the pages within the `#available` block, ensuring they are included in the final array of `SKPage` only when the availability condition is met. The ``SKSheetManager/show(id:view:)`` method presents the sheet.