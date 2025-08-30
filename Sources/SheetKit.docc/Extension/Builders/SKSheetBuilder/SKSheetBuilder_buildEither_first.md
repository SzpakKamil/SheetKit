# ``SheetKit/SKSheetBuilder/buildEither(first:)``

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

A result builder function that processes an array of ``SKPage`` structs for the true branch of a conditional statement.

## Overview

The ``SKSheetBuilder/buildEither(first:)`` function is a component of the ``SKSheetBuilder`` result builder in the `SheetKit` package. It takes an array of ``SKPage`` structs and processes them for inclusion in the `true` branch of a conditional statement. This function returns the provided pages as an array of ``SKPage``, ensuring they are included in the ``SKSheetView`` structure when the condition evaluates to `true`.

This function is used internally by the ``SKSheetBuilder`` when processing pages passed to an ``SKSheetView`` initializer, such as `@SKSheetBuilder pages: [SKPage]`, to handle the `true` branch of conditional logic in a declarative, SwiftUI-like syntax.

## Example

The following example demonstrates how ``SKSheetBuilder`` (including ``SKSheetBuilder/buildEither(first:)``) is used to create a sheet with pages conditionally included in the `true` branch:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    @State private var isFeatureEnabled = true
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage {
                        SKHeaderImage(systemName: "camera")
                        SKTitle("SKPage Example")
                        Text("This is a sample description for the page.")
                    }
                    if isFeatureEnabled {
                        // Handled by buildEither(first:)
                        SKPage {
                            Text("Feature Page Content")
                                .font(.title)
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` uses the ``SKSheetBuilder`` to compose a sheet containing a primary ``SKPage`` and a conditional ``SKPage`` included only when `isFeatureEnabled` is `true`. The ``SKSheetBuilder/buildEither(first:)`` function processes the pages in the `true` branch, incorporating them into the final array of ``SKPage`` for rendering within the ``SKSheetView``. The ``SKSheetManager/show(id:view:)`` method presents the sheet.