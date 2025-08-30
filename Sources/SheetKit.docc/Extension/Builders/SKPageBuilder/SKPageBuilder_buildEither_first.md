# ``SheetKit/SKPageBuilder/buildEither(first:)``

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

A result builder function that processes an array of ``SKComponent`` or SwiftUI views for the true branch of a conditional statement.

## Overview

The ``SKPageBuilder/buildEither(first:)`` function is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes an array of components conforming to the ``SKComponent`` protocol (`[any SKComponent]`) or default SwiftUI views (e.g., `Text`, `Image`) and processes them for inclusion in the `true` branch of a conditional statement. This function returns the provided components or views as an array of `[any SKComponent]`, ensuring they are included in the ``SKPage`` structure when the condition evaluates to `true`.

This function is used internally by the ``SKPageBuilder`` when processing components or SwiftUI views passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle the `true` branch of conditional logic in a declarative, SwiftUI-like syntax.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildEither(first:)``) is used to create a sheet with components or views conditionally included in the `true` branch:

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
                        Text("This is a sample description.")
                        if isFeatureEnabled {
                            // Handled by buildEither(first:)
                            Text("Feature is enabled.")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a header image, a title, a `Text` view, and a conditional `Text` view included only when `isFeatureEnabled` is `true`. The ``SKPageBuilder/buildEither(first:)`` function processes the components or views in the `true` branch, incorporating them into the final array of `[any SKComponent]` for rendering within the ``SKSheetView``. The ``SKSheetManager/show(id:view:)`` method presents the sheet.