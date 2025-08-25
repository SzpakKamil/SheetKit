# ``SheetKit/SKPageBuilder/buildLimitedAvailability(_:)``

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

A result builder function that processes an array of ``SKComponent`` for a conditional compiler-control statement that performs an availability check.

## Overview

The ``SKPageBuilder/buildLimitedAvailability(_:)`` function is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes an array of components conforming to the `SKComponent` protocol (`[any SKComponent]`) and processes them for inclusion in a conditional compiler-control statement, such as `#available`, ensuring that the components are only included when the specified platform or version requirements are met. This function is crucial for handling platform-specific or version-specific sheet content in a declarative, SwiftUI-like syntax.

This function is used internally by the ``SKPageBuilder`` when processing components passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle cases where components are conditionally included based on availability checks.

## Example

The following example demonstrates how `SKPageBuilder` (including `buildLimitedAvailability(_:)`) is used to create a sheet with components conditionally included based on an availability check:

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
                        if #available(iOS 18.0, *) {
                            // Component included only on iOS 18.0 or later
                            SKDescription("This description is available on iOS 18.0+.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, a description, and a conditional description that is only included on iOS 18.0 or later. The ``SKPageBuilder/buildLimitedAvailability(_:)`` function within ``SKPageBuilder`` processes the components within the `#available` block, ensuring they are included in the final array of `[any SKComponent]` only when the availability condition is met. The ``SKSheetManager/show(id:view:)`` method presents the sheet.
