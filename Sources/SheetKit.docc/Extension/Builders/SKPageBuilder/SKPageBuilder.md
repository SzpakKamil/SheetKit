# ``SheetKit/SKPageBuilder``

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

A result builder for constructing arrays of ``SKComponent`` or SwiftUI views in an ``SKPage`` for creating polished, native-looking sheets across all Apple platforms with the same code.

## Overview

The ``SKPageBuilder`` is a result builder that enables declarative construction of page content in the `SheetKit` package. It collects and processes components conforming to the ``SKComponent`` protocol or default SwiftUI views (e.g., `Text`, `Image`), returning an array of `[any SKComponent]` for use within an ``SKPage`` struct. This allows developers to compose complex page layouts with components and SwiftUI views in a SwiftUI-like syntax.

To use ``SKPageBuilder``, you define it within the initializer of an ``SKPage``, such as `@SKPageBuilder components: () -> [any SKComponent]`. The builder processes the components or views and returns an array for rendering within the page.

The builder supports various control flow constructs, such as conditionals, loops, and optional components or views, ensuring flexibility in building dynamic page content.

### Handling SwiftUI Views as Components

``SKPageBuilder`` seamlessly integrates SwiftUI views into the ``SKPage`` structure by converting them into ``SKComponent`` instances. This is achieved through the `buildExpression<V>(_ expression: V) -> [any SKComponent]` function, which accepts any type `V` conforming to the `View` protocol. The function uses an internal `asComponent` mechanism to wrap the SwiftUI view in an ``SKCustomView``, a private wrapper that conforms to the ``SKComponent`` protocol. This allows developers to include custom SwiftUI views (e.g., `Text`, `Image`, or custom view hierarchies) directly within the ``SKPageBuilder`` context, alongside ``SKComponent`` instances, without requiring manual conversion. The resulting ``SKCustomView`` preserves the original view's appearance and behavior while ensuring compatibility with the `SheetKit` framework's component-based rendering pipeline.

## Example

The following example demonstrates how to use ``SKPageBuilder`` within an ``SKPage`` to create a page with a header image, title, description, conditional content, and dynamic content, displayed within an ``SKSheetView``:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    @State private var someCondition = true
    
    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage {
                        SKHeaderImage(systemName: "camera")
                        SKTitle("Example Page")
                        Text("This is a sample SwiftUI text view.")
                        if someCondition {
                            Text("Conditional content displayed based on a runtime condition.")
                        }
                        SKForEach(1..<3, id: \.self) { index in
                            Text("Dynamic item \(index)")
                        }
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKPage`` uses the ``SKPageBuilder`` to compose a page containing a header image, a title, a SwiftUI `Text` view, a conditional `Text` view, and dynamically generated `Text` views using ``SKForEach``. The ``SKSheetManager/show(id:view:)`` method presents the sheet, and the ``SKPageBuilder`` processes the provided components and views into an array of `[any SKComponent]` for rendering.

### Supported Features

The ``SKPageBuilder`` supports the following features for constructing page content:

- **Linear Sequences**: Define multiple ``SKComponent`` instances or SwiftUI views in a straightforward, sequential manner, processed into a single array.
- **Empty Initialization**: Handle cases where no components or views are provided, returning an empty `[any SKComponent]` array.
- **If-Else Statements**: Conditionally include ``SKComponent`` instances or SwiftUI views using `if` and `else` branches, supporting dynamic content based on runtime conditions.
- **Optional Elements**: Process optional ``SKComponent`` instances or SwiftUI views, including them only when present, or returning an empty array if `nil`.
- **For Loops with SKForEach**: Generate multiple ``SKComponent`` instances or SwiftUI views dynamically using the ``SKForEach`` component to iterate over a data collection.

## See Also

- ``SKPage``
- ``SKComponent``
- ``SKCustomView``
