# ``SheetKit/SKSheetOptions/rowShape(cornerRadius:)``

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

Customizes the corner radius of rows containing interactive components.

## Overview

The `rowShape(cornerRadius:)` option in the `SheetKit` framework allows developers to set the corner radius for rows containing interactive components within sheets conforming to the ``SKSheetable`` protocol, such as ``SKSheet`` or custom implementations. It accepts an optional `CGFloat` parameter: `nil` applies the system’s default corner radius, typically providing a rounded appearance, while a specific value (e.g., `0`) creates sharp, rectangular edges or custom curvature for enhanced visual distinction, branding, or accessibility.

This option is ideal for tailoring the aesthetic of interactive rows, ensuring alignment with an app’s design language or improving usability by adjusting the visual weight of components. It integrates seamlessly with other `SheetKit` features, such as `SKSheetOptions/rowBackground(_:)` and `SKSheetOptions/alignment(_:)`, to create cohesive and visually appealing sheet designs. The effect is supported across all platforms, with rendering variations based on platform-specific design guidelines and OS versions.

### Platform-Specific Behavior

- **iOS/iPadOS/tvOS/watchOS/visionOS/macOS**: Applies the specified or default corner radius to rows. The default (`nil`) uses system-defined rounded corners; custom values (e.g., `0`) create sharp or tailored edges.
- **Default**: Uses the system’s default corner radius, providing a platform-appropriate rounded appearance.
- **Custom Corner Radius**: Overrides the default with a specified `CGFloat` value, allowing precise control over row shape aesthetics.

## Example

The following examples demonstrate sheets with default and custom row shape corner radius, each including ``SKHeaderImage``, ``SKTitle``, ``SKDescription``, and ``SKTextField`` to showcase the effect. A `ContentView` enables interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct DefaultRowShape: SKSheet {
    var id: String = "DefaultRowShape"
    var options: Set<SKSheetOptions> = [.rowShape(cornerRadius: nil)]
    @State private var text: String = ""
    var pages: [any SKPageable] {
        SKPage {
            SKHeaderImage(systemName: "list.clipboard.fill")
            SKTitle("Default Row Shape")
            SKDescription("This sheet uses the system default corner radius for row shapes.")
            SKTextField("Example Text Field", text: $text)
        }
    }
}

struct CustomRowShape: SKSheet {
    var id: String = "CustomRowShape"
    var options: Set<SKSheetOptions> = [.rowShape(cornerRadius: 0)]
    @State private var text: String = ""
    var pages: [any SKPageable] {
        SKPage {
            SKHeaderImage(systemName: "list.clipboard.fill")
            SKTitle("Custom Row Shape")
            SKDescription("This sheet uses a custom corner radius of 0 for row shapes.")
            SKTextField("Example Text Field", text: $text)
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Default Row Shape Sheet") {
                sheetManager.show(sheet: DefaultRowShape.self)
            }
            Button("Show Custom Row Shape Sheet") {
                sheetManager.show(sheet: CustomRowShape.self)
            }
        }
        .padding()
    }
}

@main
struct RowShapeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(sheets: DefaultRowShape.self, CustomRowShape.self)
        }
    }
}
```

In these examples, `DefaultRowShape` uses `.rowShape(cornerRadius: nil)` to apply the system’s default corner radius to rows with ``SKTextField``, providing a rounded appearance. `CustomRowShape` uses `.rowShape(cornerRadius: 0)` for sharp, rectangular edges, enhancing visual distinction. The `ContentView` facilitates interactive testing across supported platforms.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `rowShape(cornerRadius:)` option customizes the corner radius of rows containing interactive components, enhancing the visual style of touch-driven interfaces on iPhone. The default corner radius aligns with iOS design guidelines for a rounded look, while a custom value like `0` creates sharp edges, ideal for modern or minimalist designs. This option ensures a clear visual hierarchy for forms or settings, adapting to various screen sizes and orientations.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                For iOS 26 and newer, the default corner radius integrates with modern system styling, providing a smooth, rounded appearance for rows. Custom corner radius, such as `0`, offer sharp, rectangular shapes, ideal for branded interfaces or high-contrast accessibility needs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-iOS26", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-iOS26", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                For iOS 18 and earlier, the default corner radius aligns with legacy system aesthetics, offering a softer, rounded look for rows. Custom corner radius, such as `0`, provide sharp edges for enhanced visibility, supporting older designs for forms or interactive settings.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-iOS18", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-iOS18", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the `rowShape(cornerRadius:)` option styles the corner radius of rows for interactive components, optimizing visibility in multitasking scenarios like Split View or Slide Over. The default corner radius provides a rounded appearance suitable for iPad’s larger screens, while custom values like `0` create sharp edges, enhancing branding or accessibility for complex layouts.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the default corner radius integrates with modern system styling, offering a polished, rounded look for rows. Custom corner radius, such as `0`, provide sharp, rectangular shapes, ideal for forms or settings on larger screens.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-iPadOS26", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-iPadOS26", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                For iPadOS 18 and earlier, the default corner radius aligns with legacy aesthetics, providing a softer, rounded appearance. Custom corner radius, such as `0`, enhance row visibility with sharp edges, supporting older multitasking layouts or form-based designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-iPadOS18", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-iPadOS18", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        On macOS, the `rowShape(cornerRadius:)` option customizes the corner radius of rows for interactive components, enhancing clarity in window-based interfaces. The default corner radius aligns with macOS design for a rounded look, while custom values like `0` create sharp edges, supporting branding or accessibility in desktop workflows.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                For macOS 26 and newer, the default corner radius integrates with modern system styling, providing a sleek, rounded appearance for rows. Custom corner radius, such as `0`, offer sharp, rectangular shapes, ideal for forms or settings in desktop applications.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-macOS26", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-macOS26", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                For macOS 15 and earlier, the default corner radius follows legacy window aesthetics, offering a softer, rounded look. Custom corner radius, such as `0`, enhance row visibility with sharp edges, supporting older desktop designs for forms or interactive settings.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-macOS15", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-macOS15", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, the `rowShape(cornerRadius:)` option styles the corner radius of rows in spatial interfaces, enhancing immersion for interactive components. The default corner radius provides a rounded look suitable for 3D environments, while custom values like `0` create sharp edges, ensuring clarity and supporting high-contrast needs.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                For visionOS 26 and newer, the default corner radius integrates with modern spatial styling, offering a polished, rounded appearance for rows. Custom corner radius, such as `0`, provide sharp, rectangular shapes, ideal for immersive forms or settings in mixed reality.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-visionOS26", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-visionOS26", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                For visionOS 2 and earlier, the default corner radius aligns with spatial aesthetics, providing a softer, rounded appearance. Custom corner radius, such as `0`, enhance row visibility with sharp edges, supporting immersive forms or settings in mixed reality designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-visionOS2", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-visionOS2", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        On watchOS, the `rowShape(cornerRadius:)` option styles the corner radius of rows for interactive components, ensuring legibility on small screens. The default corner radius provides a rounded look optimized for watch displays, while custom values like `0` create sharp edges, enhancing glanceable interfaces or accessibility.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                For watchOS 26 and newer, the default corner radius uses modern system styling for compact layouts, offering a rounded appearance for rows. Custom corner radius, such as `0`, provide sharp, rectangular shapes, ideal for forms or settings on small screens.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-watchOS26", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-watchOS26", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                For watchOS 11 and earlier, the default corner radius aligns with legacy aesthetics, providing a softer, rounded appearance. Custom corner radius, such as `0`, enhance row visibility with sharp edges, supporting older compact designs for forms or interactive settings.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-watchOS11", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-watchOS11", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the `rowShape(cornerRadius:)` option styles the corner radius of rows for interactive components, optimizing visibility in large-screen, remote-driven interfaces. The default corner radius provides a rounded look suitable for tvOS displays, while custom values like `0` create sharp edges, enhancing focus during media playback or settings.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                For tvOS 26 and newer, the default corner radius integrates with modern system styling, offering a polished, rounded appearance for rows. Custom corner radius, such as `0`, provide sharp, rectangular shapes, ideal for settings or interactive content in living-room environments.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-tvOS26", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-tvOS26", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                For tvOS 18 and earlier, the default corner radius aligns with legacy full-screen aesthetics, providing a softer, rounded appearance. Custom corner radius, such as `0`, enhance row visibility with sharp edges, supporting older designs for settings or interactive content.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Default-tvOS18", alt: "Default Row Shape") {
                            Default Row Shape
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowShape-Custom-tvOS18", alt: "Custom Row Shape (Corner Radius 0)") {
                            Custom Row Shape (Corner Radius 0)
                        }
                    }
                }
            }
        }
    }
}

## See Also

- ``SKSheetOptions``
- ``SKSheetable``
- ``SKSheet``
- ``SKPage``
- ``SKPage/skRowShape(cornerRadius:)``
- ``SKTextField``
- ``SKPicker``
- ``SKStepper``
- ``SKToggle``
- ``SKDatePicker``
- ``SwiftUICore/EnvironmentValues/skRowShape``
