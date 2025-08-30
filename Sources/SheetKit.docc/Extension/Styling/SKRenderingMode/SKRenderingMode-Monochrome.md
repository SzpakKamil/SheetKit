# ``SheetKit/SKRenderingMode/monochrome``

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

A case of the ``SKRenderingMode`` enumeration that defines the monochrome rendering style for images in the `SheetKit` framework, used with `SKHeaderImage`.

## Overview

The ``SKRenderingMode/monochrome`` case specifies how images, particularly those used in the ``SKHeaderImage`` component, are rendered with a single color applied uniformly across all layers. This rendering mode is applied using the ``SKHeaderImage/skRenderingMode(_:)`` modifier, allowing developers to customize the appearance of header images to suit different design needs across Apple platforms (iOS, iPadOS, macOS, watchOS, tvOS, visionOS). It ensures that images align with the platform’s native design language, adapt to light and dark modes with adjusted contrast, and maintain accessibility and visual clarity. The monochrome style uses the sheet’s accent color (e.g., via ``SKSheetView/skAccentColor(_:)``) for a consistent, flat appearance, making it versatile for system images (e.g., SF Symbols) across all supported platforms.

## Example

The following example demonstrates how to use ``SKRenderingMode/monochrome`` with an ``SKHeaderImage`` in a `SheetKit` sheet:

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
                            .skRenderingMode(.monochrome)
                    }
                    .skHideCloseButton()
                    .skHideContinueButton()
                }
            }
        }
    }
}
```

In this example, an ``SKHeaderImage`` with the system image `xmark.bin.fill` is styled using the `.skRenderingMode(.monochrome)` modifier within an ``SKSheetView``. The `monochrome` rendering mode applies a single accent color uniformly across all layers, adapting to the system’s appearance (light or dark mode) with adjusted contrast, ensuring a visually clear and contextually appropriate presentation. The ``SKSheetView/skHideCloseButton(_:)`` and ``SKSheetView/skHideCloseButton(_:)`` modifiers are used to simplify the sheet’s interface, focusing on the header image.

## Design Images

This section illustrates the visual design of the ``SKRenderingMode/monochrome`` case when used with ``SKHeaderImage`` across all Apple platforms, showcasing its appearance in light and dark modes. The style is consistent across all platforms, ensuring a uniform user experience.

@Row(numberOfColumns: 2) {
    @Column(size: 1) {
        @Image(source: "Documentation-Styling-SKRenderingMode-Monochrome", alt: "Monochrome - Light") {
            Light
        }
    }
    @Column(size: 1) {
        @Image(source: "Documentation-Styling-SKRenderingMode-Monochrome-Dark", alt: "Monochrome - Dark") {
            Dark
        }
    }
}

## See Also

- ``SKRenderingMode``
- ``SKRenderingMode/hierarchical``
- ``SKHeaderImage``
- ``SKHeaderImage/skRenderingMode(_:)``
