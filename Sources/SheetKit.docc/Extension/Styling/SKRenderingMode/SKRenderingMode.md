# ``SheetKit/SKRenderingMode``

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

An enumeration that defines the rendering styles for images in the `SheetKit` framework, used with ``SKHeaderImage``.

## Overview

The ``SKRenderingMode`` enumeration specifies how images, particularly those used in the ``SKHeaderImage`` component, are rendered within the `SheetKit` framework. It provides two cases: ``SKRenderingMode/hierarchical`` and ``SKRenderingMode/monochrome``, which control the color application and visual style of the image. The rendering mode is applied using the ``SKHeaderImage/skRenderingMode(_:)`` modifier, allowing developers to customize the appearance of header images to suit different design needs across Apple platforms (iOS, iPadOS, macOS, watchOS, tvOS, visionOS). This ensures that images align with the platform’s native design language, adapt to light and dark modes, and maintain accessibility and visual clarity. The `hierarchical` mode adds depth through layered effects or shadows, while the `monochrome` mode applies a single color across all layers, typically the accent color. Both rendering modes are consistent across all supported platforms, making them versatile for system images (e.g., SF Symbols) to ensure a unified aesthetic within the app and sheet context.

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

In this example, an ``SKHeaderImage`` with the system image `xmark.bin.fill` is styled using the ``SKHeaderImage/skRenderingMode(_:)`` modifier within an ``SKSheetView``. The `hierarchical` rendering mode adds depth through layered effects or shadows, adapting to the system’s appearance (light or dark mode) and the sheet’s accent color, ensuring a visually appealing and contextually appropriate presentation. The ``SKSheetView/skHideCloseButton(_:)`` and ``SKSheetView/skHideCloseButton(_:)`` modifiers are used to simplify the sheet’s interface, focusing on the header image.

## Design Images

This section illustrates the visual design of the ``SKRenderingMode`` cases when used with ``SKHeaderImage`` across all Apple platforms, showcasing the differences between ``SKRenderingMode/monochrome`` and ``SKRenderingMode/hierarchical`` in both light and dark modes. The styles are consistent across all platforms, ensuring a uniform user experience.

@TabNavigator{
    @Tab("Light"){
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKRenderingMode-Monochrome", alt: "Monochrome") {
                    Monochrome - Uniform accent color on all layers
                }
                
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKRenderingMode-Hierarchical", alt: "Hierarchical") {
                    Hierarchical - Varying opacity per layer
                }
                
            }
        }
    }
    @Tab("Dark"){
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKRenderingMode-Monochrome-Dark", alt: "Monochrome") {
                    Monochrome - Uniform accent color on all layers
                }
                
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKRenderingMode-Hierarchical-Dark", alt: "Hierarchical") {
                    Hierarchical - Varying opacity per layer
                }
                
            }
        }
    }
}


## See Also

- ``SKHeaderImage``
- ``SKHeaderImage/skRenderingMode(_:)``
