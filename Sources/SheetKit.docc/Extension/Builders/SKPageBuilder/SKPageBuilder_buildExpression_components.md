# ``SheetKit/SKPageBuilder/buildExpression(_:)-(SKComponent...)``

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

A result builder function that processes a variadic sequence of ``SKComponent`` or SwiftUI views into an array for use in ``SKPage``.

## Overview

The ``SKPageBuilder/buildExpression(_:)-(SKComponent...)`` function, specifically for variadic ``SKComponent`` sequences or SwiftUI views, is a component of the ``SKPageBuilder`` result builder in the ``SheetKit`` package. It takes a variadic sequence of components conforming to the ``SKComponent`` protocol (`any SKComponent...`) or default SwiftUI views (e.g., `Text`, `Image`) and converts them into an array of `[any SKComponent]`. This function is used when components or views are provided directly without loops (such as ``SKForEach``) or conditionals, and it works in conjunction with ``SKPageBuilder/buildBlock(_:)-(SKComponent...)`` functions to transform these into the final array used by ``SKPage``.

This function is used internally by the ``SKPageBuilder`` when processing components or SwiftUI views passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle straightforward declarations.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SheetKit/SKPageBuilder/buildExpression(_:)-(SKComponent...)``) is used to create a sheet with a linear sequence of components and SwiftUI views:

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
                        // Linear sequence of components and SwiftUI views processed by buildExpression(_:)
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

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, and a SwiftUI `Text` view specified in a straightforward, linear sequence. The ``SKPageBuilder/buildExpression(_:)-(SKComponent...)`` function processes the variadic sequence of ``SKComponent`` and SwiftUI views into an array of `[any SKComponent]`, which is then passed to ``SKPageBuilder/buildBlock(_:)-(SKComponent...)`` functions to create the final array for rendering within the ``SKSheetView``. The ``SKSheetManager/show(id:view:)`` method presents the sheet.
