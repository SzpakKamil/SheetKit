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

An option to control the accent color of a sheet's components.

## Overview

The ``SKSheetOptions/accentColor(_:)`` option in the `SheetKit` framework allows customization of the accent color applied to all components within a sheet conforming to the ``SKSheetable`` protocol, such as ``SKSheet`` or custom implementations. The accent color influences the visual styling of buttons, headers, and other elements, enhancing the sheet's thematic consistency. The option accepts a `Color` value, where `.accentColor` uses the system's default accent color, while custom `Color` values (e.g., `.red`) override the default. The default behavior uses the system accent color unless a custom color is specified.

## Example

The following example demonstrates two sheets: one with the default accent color and one with a custom accent color, each with a single page to illustrate the accent color behavior:

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

In this example, `DefaultAccentColorSheet` uses `.accentColor(.accentColor)` to apply the system default accent color, while `CustomAccentColorSheet` uses `.accentColor(.red)` to apply a custom red accent color.

## Design Images

This section illustrates the visual design of sheets using the ``SKSheetOptions/accentColor(_:)`` option, showcasing the default and custom accent color states across various Apple platforms.

@TabNavigator {
    @Tab("iOS") {
        On iOS, the accent color is applied to header images, highlights and interactive elements like buttons.
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
        On iPadOS, the accent color is applied to header image, highlights and interactive elements like buttons.
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
        On macOS, the accent color is applied to header image, highlights and interactive elements like buttons.
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
        On watchOS, the accent color is applied to header image, highlights and interactive elements like buttons.
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
        On tvOS, the accent color is applied to header image, highlights and interactive elements like buttons.
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
        On visionOS, the accent color is applied to header image, highlights and interactive elements like buttons.
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
- ``SwiftUICore/EnvironmentValues/skAccentColor``
