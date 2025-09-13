# ``SheetKit/SKSheetOptions/rowBackground(_:)``

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

Customizes the background color of rows containing interactive components.

## Overview

The `rowBackground(_:)` option in the ``SheetKit`` framework allows developers to set the background color for rows containing interactive components (``SKTextField``, ``SKPicker``, ``SKStepper``, ``SKDatePicker``) within sheets conforming to the ``SKSheetable`` protocol, such as ``SKSheet`` or custom implementations. It accepts an optional `Color` parameter: `nil` or `.rowBackground()` applies the system’s default background color, while a custom color (e.g., `.red.opacity(0.8)`) enhances visibility, branding, or visual hierarchy. This option is ideal for highlighting interactive elements, improving accessibility, or aligning with app aesthetics.

### Platform-Specific Behavior

- **iOS/iPadOS/tvOS/watchOS/visionOS/macOS**: Applies the specified or default background color to rows containing ``SKTextField``, ``SKPicker``, ``SKStepper``, and ``SKDatePicker``.
- **Default**: Uses the system’s default row background color (`.rowBackground()`).
- **Custom Colors**: Overrides the default with a specified color, with optional opacity for visual effects.

## Example

The following examples demonstrate sheets with default and custom row background colors, each including ``SKHeaderImage``, ``SKTitle``, ``SKDescription``, ``SKTextField``, ``SKPicker``, ``SKStepper``, and ``SKDatePicker`` to showcase the effect. A `ContentView` enables interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct DefaultRowBackgroundSheet: SKSheet {
    var id: String = "DefaultRowBackgroundSheet"
    var options: Set<SKSheetOptions> = [.rowBackground()]
    @State private var text: String = ""
    @State private var selection: String = "Option 1"
    @State private var value: Int = 0
    @State private var date: Date = Date()
    let options: [String] = ["Option 1", "Option 2", "Option 3"]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "list.clipboard.fill")
            SKTitle("Default Row Background")
            SKDescription("This sheet uses the system default background color for rows with interactive components.")
            SKTextField("Text Field", text: $text)
            SKPicker("Picker", selection: $selection, options: options)
            SKStepper("Stepper", value: $value, in: 0...10)
            SKDatePicker("Date Picker", selection: $date)
        }
    }
}

struct CustomRowBackgroundSheet: SKSheet {
    var id: String = "CustomRowBackgroundSheet"
    var options: Set<SKSheetOptions> = [.rowBackground(.red.opacity(0.8))]
    @State private var text: String = ""
    @State private var selection: String = "Option 1"
    @State private var value: Int = 0
    @State private var date: Date = Date()
    let options: [String] = ["Option 1", "Option 2", "Option 3"]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "list.clipboard.fill")
            SKTitle("Custom Row Background")
            SKDescription("This sheet uses a red background with 80% opacity for rows with interactive components.")
            SKTextField("Text Field", text: $text)
            SKPicker("Picker", selection: $selection, options: options)
            SKStepper("Stepper", value: $value, in: 0...10)
            SKDatePicker("Date Picker", selection: $date)
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Default Row Background Sheet") {
                sheetManager.show(sheet: DefaultRowBackgroundSheet.self)
            }
            Button("Show Custom Row Background Sheet") {
                sheetManager.show(sheet: CustomRowBackgroundSheet.self)
            }
        }
        .padding()
    }
}

@main
struct RowBackgroundColorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(sheets: DefaultRowBackgroundSheet.self, CustomRowBackgroundSheet.self)
        }
    }
}
```

In these examples, `DefaultRowBackgroundSheet` uses `.rowBackground()` to apply the system’s default background color to rows with ``SKTextField``, ``SKPicker``, ``SKStepper``, ``SKToggle`` and ``SKDatePicker``. `CustomRowBackgroundSheet` uses `.rowBackground(.red.opacity(0.8))` for a semi-transparent red background, enhancing visual distinction. The `ContentView` facilitates interactive testing.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `rowBackground(_:)` option customizes the background color of rows containing interactive components, enhancing visibility in touch-driven interfaces. It ensures clear visual hierarchy for forms or settings, adapting to iPhone screen sizes and orientations for optimal user experience.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                For iOS 26 and newer, the default background uses modern system styling for seamless integration, while custom colors (e.g., red with opacity) provide bold visual cues, ideal for branded forms or high-contrast accessibility needs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-iOS26", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-iOS26", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                For iOS 18 and earlier, the default background aligns with legacy system aesthetics, while custom colors enhance row visibility for older designs, supporting forms or interactive settings with clear visual distinction.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-iOS18", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-iOS18", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the `rowBackground(_:)` option styles row backgrounds for interactive components, optimizing visibility in multitasking scenarios like Split View or Slide Over. Custom colors enhance accessibility, ensuring clear visual cues for complex layouts or external input devices.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the default background integrates with modern system styling, while custom colors (e.g., red with opacity) highlight interactive rows, ideal for forms on larger screens.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-iPadOS26", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-iPadOS26", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                For iPadOS 18 and earlier, the default background aligns with legacy aesthetics, while custom colors provide visual distinction for interactive rows, supporting older multitasking layouts or form-based designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-iPadOS18", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-iPadOS18", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        On macOS, the `rowBackground(_:)` option customizes row backgrounds for interactive components, enhancing clarity in window-based interfaces. Custom colors support accessibility in desktop workflows, ensuring visual distinction in multi-monitor or full-screen setups.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                For macOS 26 and newer, the default background aligns with modern system styling, while custom colors (e.g., red with opacity) highlight interactive rows.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-macOS26", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-macOS26", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                For macOS 15 and earlier, the default background follows legacy window aesthetics, while custom colors enhance row visibility, supporting older desktop designs for forms or interactive settings.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-macOS15", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-macOS15", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, the `rowBackground(_:)` option styles row backgrounds in spatial interfaces, enhancing immersion for interactive components. Custom colors support high-contrast needs, ensuring clarity in 3D environments aligned with the user’s field of view.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                For visionOS 26 and newer, the default background integrates with spatial styling, while custom colors (e.g., red with opacity) highlight interactive rows, ideal for immersive forms or settings in mixed reality.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-visionOS26", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-visionOS26", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                For visionOS 2 and earlier, the default background aligns with early spatial aesthetics, while custom colors enhance row visibility, supporting immersive forms or settings in mixed reality designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-visionOS2", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-visionOS2", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        On watchOS, the `rowBackground(_:)` option styles row backgrounds for interactive components, ensuring legibility on small screens. Custom colors enhance glanceable interfaces, accessibility for watch face orientations or complications.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                For watchOS 26 and newer, the default background uses modern system styling for compact layouts, while custom colors (e.g., red with opacity) highlight interactive rows, ideal for forms or settings on small screens.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-watchOS26", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-watchOS26", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                For watchOS 11 and earlier, the default background aligns with legacy aesthetics, while custom colors enhance row visibility, supporting older compact designs for forms or interactive settings.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-watchOS11", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-watchOS11", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the `rowBackground(_:)` option styles row backgrounds for interactive components, optimizing visibility in large-screen, remote-driven interfaces. Custom colors enhance branding or focus during media playback, ensuring clear visual cues in modal or full-screen sheets.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                For tvOS 26 and newer, the default background integrates with modern system styling, while custom colors (e.g., red with opacity) highlight interactive rows, ideal for settings or interactive content in living-room environments.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-tvOS26", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-tvOS26", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                For tvOS 18 and earlier, the default background aligns with legacy full-screen aesthetics, while custom colors enhance row visibility, supporting older designs for settings or interactive content.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Default-tvOS18", alt: "Default Row Background") {
                            Default Row Background
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-RowBackground-Custom-tvOS18", alt: "Custom Row Background (Red)") {
                            Custom Row Background (Red)
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
- ``SKPage/skRowBackground(_:)``
- ``SKTextField``
- ``SKPicker``
- ``SKStepper``
- ``SKToggle``
- ``SKDatePicker``
- ``SwiftUICore/EnvironmentValues/skRowBackgroundColor``
