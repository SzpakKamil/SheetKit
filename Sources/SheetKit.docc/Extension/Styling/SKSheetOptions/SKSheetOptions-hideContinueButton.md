# ``SheetKit/SKSheetOptions/hideContinueButton(_:)``

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

Controls the visibility of the default continue button in a sheet, styled with `SKPrimaryButtonStyle`.

## Overview

The `hideContinueButton(_:)` option in the ``SheetKit`` framework determines whether the default continue button, styled with ``SKPrimaryButtonStyle``, is displayed in a sheet conforming to the `SKSheetable` protocol, such as ``SKSheetView`` or custom ``SKSheet`` implementations. When set to `true` (the default), the continue button is hidden, requiring a manual toolbar primary button (e.g., via ``SKToolbarItem`` with ``SKToolbarItemPlacement/primary``) for forward navigation in multi-page sheets. When set to `false`, the continue button is visible, enabling users to navigate to the next page seamlessly.

This option is ideal for customizing navigation flows, allowing developers to either rely on the default continue button for simple progression or implement custom navigation controls for complex workflows. It integrates with other ``SheetKit`` features, such as ``SKSheetOptions/alignment(_:)`` and ``SKSheetOptions/style(_:)``, to create a cohesive user experience. The button’s appearance varies by platform and OS version, adapting to platform-specific design guidelines for consistency.

### Platform-Specific Behavior

- **iOS/iPadOS/tvOS**: Shows/hides a button with text at the bottom.
- **macOS**: Shows/hides the continue button at the bottom right (default/compact) or bottom (prominent).
- **watchOS**: Shows/hides a circular button with a system image at the bottom right.
- **visionOS**: Shows/hides a capsule button with text at the bottom.

## Example

The following examples demonstrate two sheets: one with the continue button visible and one with it hidden, each with a single page to illustrate the behavior. A `ContentView` enables interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct VisibleContinueButtonSheet: SKSheet {
    var id: String = "VisibleContinueButtonSheet"
    var options: Set<SKSheetOptions> = [.hideContinueButton(false), .style(.prominent)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "chevron.forward.circle")
            SKTitle("Continue Button Visible")
            SKDescription("This sheet displays a continue button for forward navigation.")
        }
    }
}

struct HiddenContinueButtonSheet: SKSheet {
    var id: String = "HiddenContinueButtonSheet"
    var options: Set<SKSheetOptions> = [.hideContinueButton(true), .style(.prominent)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "chevron.forward.circle")
            SKTitle("Continue Button Hidden")
            SKDescription("This sheet has the continue button hidden. Use a manual toolbar button for navigation.")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Sheet with Visible Continue Button") {
                sheetManager.show(sheet: VisibleContinueButtonSheet.self)
            }
            Button("Show Sheet with Hidden Continue Button") {
                sheetManager.show(sheet: HiddenContinueButtonSheet.self)
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
                .skSheetManager(sheets: VisibleContinueButtonSheet.self, HiddenContinueButtonSheet.self)
        }
    }
}
```

In these examples, `VisibleContinueButtonSheet` uses `.hideContinueButton(false)` to display the continue button, styled with ``SKPrimaryButtonStyle``, for forward navigation. `HiddenContinueButtonSheet` uses `.hideContinueButton(true)`, requiring a manual toolbar button for navigation (not implemented here). The `ContentView` facilitates testing both configurations.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `hideContinueButton` option controls the visibility of the continue button, styled with `SKPrimaryButtonStyle`, in the sheet’s toolbar. When visible, it provides a seamless way to navigate multi-page sheets, ideal for onboarding or sequential forms. When hidden, developers can implement custom navigation controls, offering flexibility for complex workflows on iPhone’s touch-driven interface.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                For iOS 26 and newer, the continue button appears as a capsule with a liquid glass effect, accent color background, and white text, enhancing visual appeal in the toolbar. Hiding the button with `.hideContinueButton(true)` allows developers to design custom navigation for specific use cases, maintaining a modern iOS aesthetic.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-iOS26", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-iOS26", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                On iOS 18 and earlier, the continue button is a rounded rectangle with an accent color background and white text, aligning with older iOS design language. Setting `.hideContinueButton(true)` removes it, enabling custom navigation solutions for workflows requiring specific user interactions.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-iOS18", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-iOS18", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the `hideContinueButton` option manages the continue button’s visibility in the toolbar, styled with `SKPrimaryButtonStyle`. This is crucial for larger screens, where clear navigation aids user interaction in multitasking environments like Split View. Hiding the button allows for tailored navigation controls, enhancing flexibility for complex sheet designs.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the continue button is a capsule with a liquid glass effect, accent color background, and white text, optimized for touch interactions on larger displays. Setting `.hideContinueButton(true)` supports custom navigation, ideal for detailed forms or guided tutorials on iPads.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-iPadOS26", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-iPadOS26", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                On iPadOS 18 and earlier, the continue button is a rounded rectangle with an accent color background and white text, fitting the traditional iPadOS aesthetic. Hiding it with `.hideContinueButton(true)` enables developers to implement custom navigation for specific workflows, maintaining usability on older systems.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-iPadOS18", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-iPadOS18", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        On macOS, the `hideContinueButton` option controls the continue button’s visibility, placed at the bottom right (``SKSheetStyle/default``/``SKSheetStyle/compact``) or bottom (``SKSheetStyle/prominent``) of the sheet, styled with ``SKPrimaryButtonStyle``. This is key for desktop workflows, where clear navigation enhances user experience in window-based interfaces. Hiding the button supports custom navigation for complex tasks.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                For macOS 26 and newer, the continue button is a capsule with white text, an accent color liquid glass background, and placement varying by style (bottom for `default`, top for ``SKSheetStyle/compact``/``SKSheetStyle/prominent``). Setting `.hideContinueButton(true)` allows custom toolbar buttons, ideal for tailored navigation in settings or forms.
                @TabNavigator {
                    @Tab("Default") {
                        The continue button is a capsule with white text, minimum width of 100, placed at the bottom, enhancing navigation clarity. Hiding it supports custom controls for specific workflows.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-Default-macOS26", alt: "Continue Button Visible") {
                                    Continue Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-Default-macOS26", alt: "Continue Button Hidden") {
                                    Continue Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The continue button is a capsule with white text, minimum width of 100, placed at the top for compact layouts. Hiding it enables custom navigation for streamlined interfaces.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-Compact-macOS26", alt: "Continue Button Visible") {
                                    Continue Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-Compact-macOS26", alt: "Continue Button Hidden") {
                                    Continue Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The continue button is a capsule with white text, sized to match content, placed at the bottom for prominence. Hiding it supports custom navigation for high-impact sheets.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-Prominent-macOS26", alt: "Continue Button Visible") {
                                    Continue Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-Prominent-macOS26", alt: "Continue Button Hidden") {
                                    Continue Button Hidden
                                }
                            }
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                For macOS 15 and earlier, the continue button is a rounded rectangle with white text, a gradient accent color background, shadow, and white-to-black gradient border, placed at the bottom. Hiding it enables custom navigation for older macOS workflows.
                @TabNavigator {
                    @Tab("Default") {
                        The continue button is a rounded rectangle with white text, placed at the bottom, ensuring clear navigation. Hiding it supports custom controls for specific tasks.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-Default-macOS15", alt: "Continue Button Visible") {
                                    Continue Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-Default-macOS15", alt: "Continue Button Hidden") {
                                    Continue Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The continue button is a rounded rectangle with white text, optimized for compact layouts, placed at the bottom. Hiding it enables custom navigation solutions.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-Compact-macOS15", alt: "Continue Button Visible") {
                                    Continue Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-Compact-macOS15", alt: "Continue Button Hidden") {
                                    Continue Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The continue button is a rounded rectangle with white text, sized for prominence, placed at the bottom. Hiding it supports custom navigation for impactful sheets.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-Prominent-macOS15", alt: "Continue Button Visible") {
                                    Continue Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-Prominent-macOS15", alt: "Continue Button Hidden") {
                                    Continue Button Hidden
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        On watchOS, the `hideContinueButton` option controls the visibility of a circular continue button with a system image (e.g., `chevron.forward`), placed at the bottom right. This is critical for glanceable navigation on small screens, where space is limited, and hiding the button allows custom controls for tailored interactions.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                For watchOS 26 and newer, the continue button is a circular button with a liquid glass effect and a system image, omitting text for clarity on small screens. Setting `.hideContinueButton(true)` enables custom navigation, ideal for compact, action-driven interfaces.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-watchOS26", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-watchOS26", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                On watchOS 11 and earlier, the continue button is a circular button with a gray background and a system image, skipping text for simplicity. Hiding it with `.hideContinueButton(true)` supports custom navigation for older watchOS interfaces.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-watchOS11", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-watchOS11", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the `hideContinueButton` option manages the continue button’s visibility in the toolbar, styled with `SKPrimaryButtonStyle`. This is key for remote-driven navigation, ensuring clear progression in full-screen interfaces. Hiding the button allows custom navigation for complex or branded experiences.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                For tvOS 26 and newer, the continue button is a liquid glass rounded rectangle with an accent color background and white text, optimized for remote interactions. Setting `.hideContinueButton(true)` supports custom navigation for large-screen, living-room experiences.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-tvOS26", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-tvOS26", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                On tvOS 18 and earlier, the continue button is a standard rounded rectangle with an accent color background and white text. Hiding it with `.hideContinueButton(true)` enables custom navigation, aligning with older tvOS design for remote-driven interfaces.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-tvOS18", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-tvOS18", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, the `hideContinueButton` option controls the visibility of a capsule-shaped continue button with text, placed at the bottom of the sheet. This is crucial for spatial interfaces, where clear navigation enhances immersion. Hiding the button supports custom controls for tailored mixed reality experiences.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                For visionOS 26 and newer, the continue button is a capsule with an accent color background and white text, optimized for spatial interactions. Setting `.hideContinueButton(true)` enables custom navigation, ideal for immersive 3D sheets in mixed reality environments.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-visionOS26", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-visionOS26", alt: "Continue Button Hidden") {
                            Continue Button Hidden
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                On visionOS 2 and earlier, the continue button is a capsule with an accent color background and white text, consistent with newer versions but tailored to early mixed reality designs. Hiding it supports custom navigation for spatial interfaces.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Showing-visionOS2", alt: "Continue Button Visible") {
                            Continue Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideContinueButton-Hidden-visionOS2", alt: "Continue Button Hidden") {
                            Continue Button Hidden
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
- ``SKPage/skHideCloseButton(_:)``
- ``SKPrimaryButtonStyle``
- ``SKToolbarItem``
- ``SKToolbarItemPlacement/primary``
- ``SwiftUICore/EnvironmentValues/skIsContinueButtonHidden``
