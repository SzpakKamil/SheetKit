# ``SheetKit/SKPageBuilder/buildBlock(_:)-1g593``

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

A result builder function that processes multiple arrays of ``SKComponent`` or SwiftUI views into a flattened array for use in ``SKPage``.

## Overview

The ``SKPageBuilder/buildBlock(_:)-1g593`` function, specifically for multiple arrays of ``SKComponent`` or SwiftUI views, is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes a variadic sequence of arrays of components conforming to the ``SKComponent`` protocol (`[any SKComponent]...`) or default SwiftUI views (e.g., `Text`, `Image`) and flattens them into a single array of `[any SKComponent]`. This function works in pair with ``SKPageBuilder/buildExpression(_:)-(SKComponent...)`` to process linear component or view passages. The `@resultBuilder` attribute ensures that the type of components or views passed is automatically transformed, allowing seamless integration into the ``SKPage`` structure.

This function is used internally by the ``SKPageBuilder`` when processing components or SwiftUI views passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle cases where content is provided as multiple arrays.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildBlock(_:)-1g593`` for multiple arrays) is used to create a sheet with multiple predefined arrays of components and views:

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
                        // Linear sequence of components and SwiftUI views processed by buildBlock(_:)
                        SKHeaderImage(systemName: "camera")
                        SKTitle("SKPage Example")
                        Text("This is a sample SwiftUI text view.")
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, and a SwiftUI `Text` view specified in a linear sequence. The ``SKPageBuilder/buildExpression(_:)-(SKComponent...)`` function processes the variadic sequence of ``SKComponent`` and SwiftUI views, and the ``SKPageBuilder/buildBlock(_:)-1g593`` function transforms these into a final array of `[any SKComponent]` for rendering within the ``SKSheetView``. The `@resultBuilder` ensures that the component and view types are automatically handled. The ``SKSheetManager/show(id:view:)`` method presents the sheet.