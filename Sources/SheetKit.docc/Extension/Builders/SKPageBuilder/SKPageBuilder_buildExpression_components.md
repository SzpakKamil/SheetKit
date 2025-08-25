# ``SheetKit/SKPageBuilder/buildExpression(_:)``

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

A result builder function that processes a variadic sequence of ``SKComponent`` into an array for use in ``SKPage``.

## Overview

The ``SKPageBuilder/buildExpression(_:)-(SKComponent...)`` function, specifically for variadic ``SKComponent`` sequences, is a component of the ``SKPageBuilder`` result builder in the ``SheetKit`` package. It takes a variadic sequence of components conforming to the ``SKComponent`` protocol (`any SKComponent...`) and converts them into an array of `[any SKComponent]`. This function is used when components are provided directly without loops (such as ``SKForEach``) or conditionals, and it works in conjunction with ``SKPageBuilder/buildBlock(_:)-(SKComponent...)`` functions to transform these components into the final array used by ``SKPage``.

This function is used internally by the ``SKPageBuilder`` when processing components passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle straightforward component declarations.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SheetKit/SKPageBuilder/buildExpression(_:)-(SKComponent...)`` for components) is used to create a sheet with a linear sequence of components:

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
                        // Linear sequence of components processed by buildExpression(_:)-components
                        SKHeaderImage(systemName: "camera")
                        SKTitle("SKPage Example")
                        SKDescription("This is a sample description for the page.")
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, and a description specified in a straightforward, linear sequence. The ``SKPageBuilder/buildExpression(_:)-(SKComponent...)`` function processes the variadic sequence of ``SKComponent`` into an array of `[any SKComponent]`, which is then passed to ``SKPageBuilder/buildBlock(_:)-(SKComponent...)`` functions to create the final array for rendering within the ``SKSheetView``. The ``SKSheetManager/show(id:view:)`` method presents the sheet.
