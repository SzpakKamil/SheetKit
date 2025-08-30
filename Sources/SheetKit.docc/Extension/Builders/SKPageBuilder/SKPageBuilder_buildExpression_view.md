# ``SheetKit/SKPageBuilder/buildExpression(_:)-(V)``

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

A result builder function that converts a SwiftUI `View` into an array of ``SKComponent`` by wrapping it in an `SKCustomView`.

## Overview

The ``SKPageBuilder/buildExpression(_:)-(V)`` function, specifically for a generic SwiftUI `View`, is a component of the ``SKPageBuilder`` result builder in the `SheetKit` package. It takes a single value of type `V` that conforms to the `View` protocol and converts it into an array of `[any SKComponent]` by leveraging the private `asComponent` property. The `asComponent` property internally wraps the provided `View` inside an `SKCustomView`, enabling seamless integration of custom SwiftUI views into the ``SKPage`` structure. This function is used when a single SwiftUI view is provided directly within the ``SKPageBuilder`` context, working alongside other `buildExpression` and `buildBlock` functions to construct the final array of components.

This function is used internally by the ``SKPageBuilder`` when processing SwiftUI views passed to an ``SKPage`` initializer, such as `@SKPageBuilder components: [any SKComponent]`, to handle the conversion of custom views into a compatible component format.

## Declaration

```swift
public static func buildExpression<V>(_ expression: V) -> [any SKComponent] where V: View
```

## Parameters

- `expression`: A value of type `V` that conforms to the `View` protocol, representing a SwiftUI view to be converted into an `SKComponent`.

## Return Value

An array of `[any SKComponent]` containing a single `SKCustomView` instance that wraps the provided `View`.

## Discussion

The function relies on the private `asComponent` property, which is a package-internal mechanism that encapsulates the `View` within an `SKCustomView`. This wrapper ensures that the SwiftUI view can be processed and rendered within the ``SKPage`` context, maintaining compatibility with the `SheetKit` framework's component-based architecture. Developers should note that the resulting `SKCustomView` preserves the original view's behavior and appearance while adhering to the `SKComponent` protocol.

## Example

The following example demonstrates how ``SKPageBuilder`` (including ``SKPageBuilder/buildExpression(_:)-(V)``) is used to create a sheet with a custom SwiftUI view:

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
                        // Custom SwiftUI view processed by buildExpression(_:)
                        Text("This is a custom SwiftUI view.")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a sheet containing a custom SwiftUI `Text` view with styled properties. The ``SKPageBuilder/buildExpression(_:)-(V)`` function converts the `Text` view into an `SKCustomView` using the `asComponent` property, which is then included in the final array of `[any SKComponent]` for rendering within the ``SKSheetView``. The ``SKSheetManager/show(id:view:)`` method presents the sheet.

## See Also

- ``SKPageBuilder/buildBlock(_:)-(SKComponent...)``
- ``SKCustomView``
