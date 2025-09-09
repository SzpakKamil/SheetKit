# ``SheetKit/SKSheetOptions/primaryTextColor(color:)``

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

Sets the primary text color for sheet components, defaulting to `.primary` if no color is specified.

## Overview

The `primaryTextColor(color:)` option enables developers to customize the primary text color for sheets conforming to the ``SKSheetable`` protocol. It accepts an optional `color` parameter: if `nil`, the system’s `.primary` color is applied; otherwise, a custom color (e.g., `.red`) is used. This option styles the ``SKTitle``, ``SKDescription``, and ``SKHighlight`` components, ensuring visual consistency and supporting custom branding.

On newer OS versions (26+), ``SKDescription`` uses ``SKSheetOptions/secondaryTextColor(color:)`` for its text, while ``SKTitle`` and ``SKHighlight`` titles consistently adopt `primaryTextColor`. On older versions, ``SKDescription`` falls back to `primaryTextColor`. For ``SKHighlight``, the title always uses ``SKSheetOptions/primaryTextColor(color:)``, maintaining a unified appearance. On older OS versions, if a custom color is applied to ``SKDescription``, it may revert to ``SKSheetOptions/primaryTextColor(color:)``.

This option is supported across all platforms, with behavior varying by OS version and platform-specific rendering.

## Example

The following examples demonstrate `SKSheetOptions/primaryTextColor(color:)` applied to sheets with ``SKHeaderImage``, ``SKTitle``, ``SKDescription``, and ``SKHighlight`` components. One example uses the default `.primary` color, while the other applies a custom `.red` color, illustrating text color behavior across platforms.

```swift
import SwiftUI
import SheetKit

struct DefaultPrimaryTextColor: SKSheet {
    var id: String = "DefaultPrimaryTextColor"
    var options: Set<SKSheetOptions> = [.primaryTextColor()]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "textformat")
            SKTitle("Default Text Color")
            SKDescription("This sheet uses the default primary text color.")
            SKHighlight(title: "Example Highlight", description: "This demonstrates the primary text color on a highlight.", systemName: "scribble.variable")
        }
    }
}

struct CustomPrimaryTextColor: SKSheet {
    var id: String = "CustomPrimaryTextColor"
    var options: Set<SKSheetOptions> = [.primaryTextColor(color: .red)]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "textformat")
            SKTitle("Custom Text Color")
            SKDescription("This sheet uses a custom primary text color (red).")
            SKHighlight(title: "Example Highlight", description: "This demonstrates the primary text color on a highlight.", systemName: "scribble.variable")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Default Text Color Sheet") {
                sheetManager.show(sheet: DefaultPrimaryTextColor.self)
            }
            Button("Show Custom Text Color Sheet") {
                sheetManager.show(sheet: CustomPrimaryTextColor.self)
            }
        }
        .padding()
    }
}

@main
struct PrimaryTextColorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(.init())
        }
    }
}
```

In these examples, `DefaultPrimaryTextColor` applies the default `.primary` color using `.primaryTextColor()`, while `CustomPrimaryTextColor` uses `.primaryTextColor(color: .red)` for a red text color. The `SKHighlight` title reflects `primaryTextColor`, and `SKDescription` adjusts based on the OS version. The `ContentView` enables interactive testing of both configurations.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `primaryTextColor` option enhances the visual presentation of sheet components, allowing developers to define the text color for ``SKTitle`` and ``SKHighlight`` titles, ensuring a consistent and branded user experience. This customization is critical for aligning the sheet’s appearance with the app’s design language, especially for text-heavy interfaces. The behavior of ``SKDescription`` varies by iOS version, adapting to either ``SKSheetOptions/secondaryTextColor(color:)`` or ``SKSheetOptions/primaryTextColor(color:)`` based on the system’s capabilities.
        @TabNavigator {
            @Tab("iOS 26 and newer") {
                For iOS 26 and newer, ``SKDescription`` adopts ``SKSheetOptions/secondaryTextColor(color:)``, providing a distinct contrast to the ``SKSheetOptions/primaryTextColor(color:)`` used by ``SKTitle`` and ``SKHighlight``. This separation enhances readability and visual hierarchy, making descriptions stand out while maintaining harmony with the primary text elements.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-iOS26", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-iOS26", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red)
                        }
                    }
                }
            }
            @Tab("iOS 18 and older") {
                On iOS 18 and earlier, ``SKDescription`` uses ``SKSheetOptions/primaryTextColor(color:)``, aligning its appearance with ``SKTitle`` and ``SKHighlight`` titles. This unified color scheme ensures consistency across components but may limit contrast options compared to newer versions, where `secondaryTextColor` is available.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-iOS18", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-iOS18", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red with Accent)
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, `primaryTextColor` customizes the text appearance of sheet components, enabling developers to create visually cohesive interfaces that align with the larger screen real estate of iPads. This option is particularly effective for maintaining brand consistency across ``SKTitle``, ``SKHighlight``, and ``SKDescription``, with the latter’s behavior adapting based on the iPadOS version to optimize readability and design.
        @TabNavigator {
            @Tab("iPadOS 26 and newer") {
                For iPadOS 26 and newer, ``SKDescription`` uses ``SKSheetOptions/secondaryTextColor(color:)``, creating a clear distinction from the ``SKSheetOptions/primaryTextColor(color:)`` applied to ``SKTitle`` and ``SKHighlight`` titles. This approach enhances visual hierarchy, making it easier for users to differentiate between primary and descriptive text on larger displays.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-iPadOS26", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-iPadOS26", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red)
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and older") {
                On iPadOS 18 and earlier, ``SKDescription`` adopts ``SKSheetOptions/primaryTextColor(color:)``, resulting in a uniform text color across ``SKTitle``, ``SKHighlight``, and ``SKDescription``. This ensures a consistent look but may reduce contrast flexibility compared to newer versions where ``SKSheetOptions/secondaryTextColor(color:)`` is supported.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-iPadOS18", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-iPadOS18", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red with Accent)
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        On macOS, ``SKSheetOptions/primaryTextColor(color:)`` provides developers with the ability to customize text styling for sheet components, ensuring that ``SKTitle`` and ``SKHighlight`` titles align with the app’s visual identity. This is particularly important for desktop interfaces where text clarity and consistency enhance user experience across larger screens and varied window sizes.
        @TabNavigator {
            @Tab("macOS 26 and newer") {
                For macOS 26 and newer, ``SKDescription`` leverages ``SKSheetOptions/secondaryTextColor(color:)``, allowing a distinct visual separation from the ``SKSheetOptions/primaryTextColor(color:)`` used by ``SKTitle`` and ``SKHighlight``. This differentiation improves readability and supports a polished, professional look for macOS applications.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-macOS26", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-macOS26", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red)
                        }
                    }
                }
            }
            @Tab("macOS 15 and older") {
                On macOS 15 and earlier, `SKDescription` uses `primaryTextColor`, aligning with ``SKTitle`` and ``SKHighlight`` titles for a consistent appearance. While this ensures uniformity, it may limit contrast options compared to newer versions supporting `secondaryTextColor`.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-macOS15", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-macOS15", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red with Accent)
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        On watchOS, ``SKSheetOptions/primaryTextColor(color:)`` customizes text appearance for sheet components, optimizing for the compact displays of wearable devices. This option ensures that ``SKTitle`` and ``SKHighlight`` titles remain clear and legible, while ``SKDescription`` adapts its behavior based on the watchOS version to maintain usability within the constrained screen space.
        @TabNavigator {
            @Tab("watchOS 26 and newer") {
                For watchOS 26 and newer, ``SKDescription`` uses ``SKSheetOptions/secondaryTextColor(color:)``, providing a subtle contrast to the ``SKSheetOptions/primaryTextColor(color:)`` applied to ``SKTitle`` and ``SKHighlight``. This enhances readability on small screens, ensuring users can quickly distinguish between primary and descriptive text.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-watchOS26", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-watchOS26", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red)
                        }
                    }
                }
            }
            @Tab("watchOS 11 and older") {
                On watchOS 11 and earlier, ``SKDescription`` uses ``SKSheetOptions/primaryTextColor(color:)``, aligning with ``SKTitle`` and ``SKHighlight`` for a uniform look. This approach prioritizes clarity on small screens but may offer less visual distinction compared to newer versions.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-watchOS11", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-watchOS11", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red with Accent)
                        }
                    }
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, ``SKSheetOptions/primaryTextColor(color:)`` customizes text appearance for immersive sheet components, ensuring clarity in mixed reality environments. This option allows developers to tailor ``SKTitle`` and ``SKHighlight`` titles to the app’s aesthetic, while ``SKDescription`` adapts based on the visionOS version to optimize legibility in 3D interfaces.
        @TabNavigator {
            @Tab("visionOS 26 and newer") {
                For visionOS 26 and newer, ``SKDescription`` uses ``SKSheetOptions/secondaryTextColor(color:)``, creating a clear distinction from the `primaryTextColor` used by ``SKTitle`` and ``SKHighlight``. This enhances visual hierarchy in immersive contexts, ensuring text remains readable across varying depths and lighting conditions.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-visionOS26", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-visionOS26", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red)
                        }
                    }
                }
            }
            @Tab("visionOS 2 and older") {
                On visionOS 2 and earlier, ``SKDescription`` uses ``SKSheetOptions/secondaryTextColor(color:)``, maintaining consistency with newer versions but with potential rendering differences in early mixed reality environments. The `primaryTextColor` still applies to ``SKTitle`` and ``SKHighlight`` for uniformity.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-visionOS2", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-visionOS2", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red with Accent)
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, `primaryTextColor` customizes text appearance for sheet components, optimizing for large-screen displays and remote-based navigation. This option ensures that ``SKTitle`` and ``SKHighlight`` titles are visually prominent, while ``SKDescription`` uses ``SKSheetOptions/secondaryTextColor(color:)`` across all versions to maintain readability from a distance.
        @TabNavigator {
            @Tab("tvOS 26 and newer") {
                For tvOS 26 and newer, ``SKDescription`` uses `secondaryTextColor`, providing a clear contrast to the `primaryTextColor` applied to ``SKTitle`` and ``SKHighlight``. This ensures that text is legible on large screens, enhancing the user experience in living room environments.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-tvOS26", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-tvOS26", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red)
                        }
                    }
                }
            }
            @Tab("tvOS 18 and older") {
                On tvOS 18 and earlier, ``SKDescription`` uses ``SKSheetOptions/secondaryTextColor(color:)``, consistent with newer versions, while `primaryTextColor` styles ``SKTitle`` and ``SKHighlight``. This ensures a clear and consistent presentation on television displays, optimized for remote navigation.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Default-tvOS18", alt: "Default Text Color") {
                            Default Text Color
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PrimaryTextColor-Custom-tvOS18", alt: "Custom Text Color (Red)") {
                            Custom Text Color (Red with Accent)
                        }
                    }
                }
            }
        }
    }
}

## See Also

- ``SKSheetOptions``
- ``SKSheetOptions/secondaryTextColor(color:)``
- ``SKSheetView/skPrimaryTextColor(_:)``
- ``SKSheetView/skSecondaryTextColor(_:)``
- ``SKTitle``
- ``SKDescription``
- ``SKHighlight``
- ``SwiftUICore/EnvironmentValues/skPrimaryColor``
- ``SwiftUICore/EnvironmentValues/skSecondaryColor``
