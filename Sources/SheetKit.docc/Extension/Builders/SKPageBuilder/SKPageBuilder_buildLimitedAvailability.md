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

A result builder function that processes an array of ``SKComponent`` or SwiftUI views for a conditional compiler-control statement that performs an availability check.

## Overview

The ``SKPageBuilder/buildLimitedAvailability(_:)`` function is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes an array of components conforming to the ``SKComponent`` protocol (`[any SKComponent]`) or default SwiftUI views (e.g., `Text`, `Image`) and processes them for inclusion in a conditional compiler-control statement, such as `#available`, ensuring that the components or views are only included when the specified platform or version requirements are met. This function is crucial for handling platform-specific or version-specific sheet content in a declarative, SwiftUI-like syntax.

This function is used internally by the ``SKPageBuilder`` when processing components or SwiftUI views passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle cases where content is conditionally included based on availability checks.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildLimitedAvailability(_:)``) is used to create a sheet with components or views conditionally included based on an availability check:

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
                        Text("This is a sample description.")
                        if #available(iOS 18.0, *) {
                            // Component or view included only on iOS 18.0 or later
                            Text("This description is available on iOS 18.0+.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, a `Text` view, and a conditional `Text` view that is only included on iOS 18.0 or later. The ``SKPageBuilder/buildLimitedAvailability(_:)`` function within ``SKPageBuilder`` processes the components or views within the `#available` block, ensuring they are included in the final array of `[any SKComponent]` only when the availability condition is met. The ``SKSheetManager/show(id:view:)`` method presents the sheet.