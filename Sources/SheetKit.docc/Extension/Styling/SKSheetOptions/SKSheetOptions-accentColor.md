# ``SheetKit/SKSheetOptions/accentColor(_:)``

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

Controls the accent color of a sheet’s components, such as buttons, headers, and highlights.

## Overview

The `SKSheetOptions/accentColor(_:)` option in the `SheetKit` framework customizes the accent color applied to components within a sheet conforming to the `SKSheetable` protocol, such as `SKSheet` or custom implementations. It accepts a `Color` value, where `.accentColor` applies the system’s default accent color, and custom values (e.g., `.red`, `.blue`) override it for thematic consistency. The default behavior uses the system accent color unless a custom color is specified.

This option influences the visual styling of interactive elements like buttons (styled with `SKPrimaryButtonStyle` or `SKNavigationButtonStyle`), `SKHeaderImage`, `SKHighlight`, and other components, ensuring a cohesive look across the sheet. It is particularly useful for branding, accessibility (e.g., high-contrast colors), or aligning with platform aesthetics. The option integrates with other `SheetKit` features, such as `SKSheetOptions/alignment(_:)` and `SKSheetOptions/style(_:)`, to create visually unified designs.

### Platform-Specific Behavior

- **iOS/iPadOS/tvOS/watchOS/visionOS/macOS**: Applies the specified accent color to buttons, `SKHeaderImage`, `SKHighlight`, and other styled components.
- **Default**: Uses the system accent color (`.accentColor`) unless overridden.
- **Custom Colors**: Overrides system accent color for all styled components.

## Example

The following examples demonstrate two sheets: one with the default system accent color and one with a custom red accent color, each with a single page to illustrate the behavior. A `ContentView` enables interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct DefaultAccentColorSheet: SKSheet {
    var id: String = "DefaultAccentColorSheet"
    var options: Set<SKSheetOptions> = [.accentColor(.accentColor)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "paintbrush.pointed.fill")
            SKTitle("Default Accent Color")
            SKDescription("This sheet uses the system default accent color for all of its components.")
            SKHighlight(title: "Default Highlight", description: "Highlight styled with system accent color", systemName: "paintbrush.pointed.fill")
        }
    }
}

struct CustomAccentColorSheet: SKSheet {
    var id: String = "CustomAccentColorSheet"
    var options: Set<SKSheetOptions> = [.accentColor(.red)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "paintbrush.pointed.fill")
            SKTitle("Custom Accent Color")
            SKDescription("This sheet applies a red accent color for all of its components.")
            SKHighlight(title: "Custom Highlight", description: "Highlight styled with custom red accent color", systemName: "paintbrush.pointed.fill")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Sheet with Default Accent Color") {
                sheetManager.show(sheet: DefaultAccentColorSheet.self)
            }
            Button("Show Sheet with Custom Accent Color") {
                sheetManager.show(sheet: CustomAccentColorSheet.self)
            }
        }
        .padding()
    }
}

@main
struct SheetKitExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(sheets: DefaultAccentColorSheet.self, CustomAccentColorSheet.self)
        }
    }
}
```

In these examples, `DefaultAccentColorSheet` uses `.accentColor(.accentColor)` to apply the system’s default accent color to components like buttons, `SKHeaderImage`, and `SKHighlight`. `CustomAccentColorSheet` uses `.accentColor(.red)` to apply a custom red accent color, creating a distinct visual theme. The `ContentView` facilitates testing both configurations.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `accentColor(_:)` option applies to interactive elements (e.g., buttons styled with `SKPrimaryButtonStyle` or `SKNavigationButtonStyle`), `SKHeaderImage`, and `SKHighlight`, ensuring a consistent visual theme across touch-driven interfaces. It enhances branding and accessibility, particularly for high-contrast needs, and adapts to various iPhone screen sizes for optimal presentation.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Default-iOS26", alt: "Default Accent Color") {
                    Default Accent Color
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Custom-iOS26", alt: "Custom Accent Color") {
                    Custom Accent Color
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the `accentColor(_:)` option styles buttons, headers, and highlights, optimizing visual consistency for larger screens and multitasking scenarios like Split View. Custom accent colors enhance branding or accessibility, ensuring clear visual cues in complex layouts or when paired with external input devices.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Default-iPadOS26", alt: "Default Accent Color") {
                    Default Accent Color
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Custom-iPadOS26", alt: "Custom Accent Color") {
                    Custom Accent Color
                }
            }
        }
    }
    @Tab("macOS") {
        On macOS, the `accentColor(_:)` option applies to buttons, `SKHeaderImage`, and `SKHighlight`, ensuring a cohesive look across window-based interfaces. It supports branding in desktop workflows, with custom colors enhancing visual distinction in multi-monitor or full-screen setups, aligning with macOS design aesthetics.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Default-macOS26", alt: "Default Accent Color") {
                    Default Accent Color
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Custom-macOS26", alt: "Custom Accent Color") {
                    Custom Accent Color
                }
            }
        }
    }
    @Tab("watchOS") {
        On watchOS, the `accentColor(_:)` option styles buttons, headers, and highlights, ensuring legibility on small screens. Custom accent colors enhance glanceable interfaces, supporting branding or high-contrast needs for watch face orientations or complications, maintaining clarity in compact layouts.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Default-watchOS26", alt: "Default Accent Color") {
                    Default Accent Color
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Custom-watchOS26", alt: "Custom Accent Color") {
                    Custom Accent Color
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the `accentColor(_:)` option styles interactive elements, headers, and highlights, optimizing visual focus for large-screen, remote-driven interfaces. Custom colors enhance branding or visibility during media playback, ensuring clear visual cues in full-screen or modal sheet designs.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Default-tvOS26", alt: "Default Accent Color") {
                    Default Accent Color
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Custom-tvOS26", alt: "Custom Accent Color") {
                    Custom Accent Color
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, the `accentColor(_:)` option styles buttons, headers, and highlights in spatial interfaces, enhancing immersion in 3D environments. Custom accent colors support branding or accessibility, ensuring visual clarity in mixed reality contexts, aligning with the user’s field of view.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Default-visionOS26", alt: "Default Accent Color") {
                    Default Accent Color
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-AccentColor-Custom-visionOS26", alt: "Custom Accent Color") {
                    Custom Accent Color
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
- ``SKPage/skAccentColor(_:)``
- ``SKPrimaryButtonStyle``
- ``SKNavigationButtonStyle``
- ``SKHeaderImage``
- ``SKHighlight``
- ``SwiftUICore/EnvironmentValues/skAccentColor``
