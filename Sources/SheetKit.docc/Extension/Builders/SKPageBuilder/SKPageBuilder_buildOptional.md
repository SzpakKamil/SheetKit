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

A result builder function that processes an optional array of ``SKComponent`` for use in ``SKPage``.

## Overview

The ``SKPageBuilder/buildOptional(_:)`` function is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes an optional array of components conforming to the ``SKComponent`` protocol (`[any SKComponent]?`) and returns either the provided components or an empty array if the input is `nil`. This function is used to handle optional component declarations, ensuring that the ``SKPage`` structure can process cases where components may or may not be provided. The `@resultBuilder` attribute ensures that the components are automatically transformed into an array of `[any SKComponent]`, making the specific input type irrelevant for seamless integration.

This function is used internally by the ``SKPageBuilder`` when processing components passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle optional component groups.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildOptional(_:)``) is used to create a sheet with an optional set of components:

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
                        SKDescription("This is a sample description for the page.")
                        if showExtraContent {
                            // Optional components processed by buildOptional(_:)
                            SKDescription("This is an optional description.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, a description, and an optional description that is included only when `showExtraContent` is `true`. The ``SKPageBuilder/buildOptional(_:)`` function processes the optional components, returning them as an array of `[any SKComponent]` if present, or an empty array if `nil`. This array is then processed by ``SKPageBuilder/buildBlock(_:)-(SKComponent...)`` or other relevant ``SKPageBuilder/buildBlock()`` functions to create the final array for rendering within the ``SKSheetView``. The `@resultBuilder` ensures that the component types are automatically handled. The ``SKSheetManager/show(id:view:)`` method presents the sheet.
