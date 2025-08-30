# ``SheetKit/SKPageBuilder/buildOptional(_:)``

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

A result builder function that processes an optional array of ``SKComponent`` or SwiftUI views for use in ``SKPage``.

## Overview

The ``SKPageBuilder/buildOptional(_:)`` function is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes an optional array of components conforming to the ``SKComponent`` protocol (`[any SKComponent]?`) or default SwiftUI views (e.g., `Text`, `Image`) and returns either the provided components or views or an empty array if the input is `nil`. This function is used to handle optional component or view declarations, ensuring that the ``SKPage`` structure can process cases where content may or may not be provided. The `@resultBuilder` attribute ensures that the components or views are automatically transformed into an array of `[any SKComponent]`, making the specific input type irrelevant for seamless integration.

This function is used internally by the ``SKPageBuilder`` when processing components or SwiftUI views passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle optional content groups.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildOptional(_:)``) is used to create a sheet with an optional set of components or views:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    @State private var showExtraContent = false
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage {
                        SKHeaderImage(systemName: "camera")
                        SKTitle("SKPage Example")
                        Text("This is a sample description.")
                        if showExtraContent {
                            // Optional components or views processed by buildOptional(_:)
                            Text("This is an optional description.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, a `Text` view, and an optional `Text` view that is included only when `showExtraContent` is `true`. The ``SKPageBuilder/buildOptional(_:)`` function processes the optional components or views, returning them as an array of `[any SKComponent]` if present, or an empty array if `nil`. This array is then processed by ``SKPageBuilder/buildBlock(_:)-(SKComponent...)`` or other relevant ``SKPageBuilder/buildBlock()`` functions to create the final array for rendering within the ``SKSheetView``. The `@resultBuilder` ensures that the component and view types are automatically handled. The ``SKSheetManager/show(id:view:)`` method presents the sheet.