# ``SheetKit/SKRenderingMode/hierarchical``

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
    @PageColor(green)
}

@Options {
    @AutomaticSeeAlso(disabled)
}

A case of the ``SKRenderingMode`` enumeration that defines the hierarchical rendering style for images in the `SheetKit` framework, used with `SKHeaderImage`.

## Overview

The ``SKRenderingMode/hierarchical`` case specifies how images, particularly those used in the ``SKHeaderImage`` component, are rendered with added depth through layered effects or subtle shadows. This rendering mode is applied using the ``SKHeaderImage/skRenderingMode(_:)`` modifier, allowing developers to customize the appearance of header images to suit different design needs across Apple platforms (iOS, iPadOS, macOS, watchOS, tvOS, visionOS). It ensures that images align with the platform’s native design language, adapt to light and dark modes, and maintain accessibility and visual clarity. The hierarchical style enhances the image’s details with foreground and background tints that adjust to the system’s appearance and the sheet’s accent color, providing a consistent and versatile look for system images (e.g., SF Symbols) across all supported platforms.

## Example

The following example demonstrates how to use ``SKRenderingMode/hierarchical`` with an ``SKHeaderImage`` in a `SheetKit` sheet:

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
                        SKHeaderImage(systemName: "xmark.bin.fill")
                            .skRenderingMode(.hierarchical)
                    }
                    .skHideCloseButton()
                    .skHideContinueButton()
                }
            }
        }
    }
}
```

In this example, an ``SKHeaderImage`` with the system image `xmark.bin.fill` is styled using the `.skRenderingMode(.hierarchical)` modifier within an ``SKSheetView``. The `hierarchical` rendering mode adds depth through layered effects or shadows, adapting to the system’s appearance (light or dark mode) and the sheet’s accent color, ensuring a visually appealing and contextually appropriate presentation. The ``SKSheetView/skHideCloseButton(_:)`` and ``SKSheetView/skHideCloseButton(_:)`` modifiers are used to simplify the sheet’s interface, focusing on the header image.

## Design Images

This section illustrates the visual design of the ``SKRenderingMode/hierarchical`` case when used with ``SKHeaderImage`` across all Apple platforms, showcasing its appearance in light and dark modes. The style is consistent across all platforms, ensuring a uniform user experience.

@Row(numberOfColumns: 2) {
    @Column(size: 1) {
        @Image(source: "Documentation-Styling-SKRenderingMode-Hierarchical", alt: "Hierarchical - Light") {
            Light
        }
    }
    @Column(size: 1) {
        @Image(source: "Documentation-Styling-SKRenderingMode-Hierarchical-Dark", alt: "Hierarchical - Dark") {
            Dark
        }
    }
}


## See Also

- ``SKRenderingMode``
- ``SKRenderingMode/monochrome``
- ``SKHeaderImage``
- ``SKHeaderImage/skRenderingMode(_:)``
