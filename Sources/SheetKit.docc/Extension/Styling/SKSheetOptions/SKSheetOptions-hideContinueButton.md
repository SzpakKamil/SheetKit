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

An option to control the visibility of the default continue button in a sheet.

## Overview

The ``SKSheetOptions/hideContinueButton(_:)`` option in the `SheetKit` framework determines whether the default continue button, styled with ``SKPrimaryButtonStyle``, is visible in a sheet conforming to the ``SKSheetable`` protocol, such as ``SKSheetView`` or custom ``SKSheet`` implementations. When set to `true`, the continue button is hidden, requiring a manual toolbar primary button (e.g., via ``SKToolbarItem`` with ``SKToolbarItemPlacement/primary``) for forward navigation. When set to `false`, the continue button is visible, allowing users to navigate to the next page in a multi-page sheet. The default value is `true`, meaning the continue button is hidden unless explicitly enabled.

## Example

The following example demonstrates two sheets: one with the continue button visible and one with it hidden, each with a single page to illustrate the continue button behavior:

```swift
import SwiftUI
import SheetKit

struct VisibleContinueButtonSheet: SKSheet {
    var id: String = "VisibleCloseButtonSheet"
    var options: Set<SKSheetOptions> = [.hideContinueButton(false), .style(.prominent)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "chevron.forward.circle")
            SKTitle("Continue Button Visible")
            SKDescription("This sheet displays a continue button for forward navigation")
        }
    }
}

struct HiddenContinueButtonSheet: SKSheet {
    var id: String = "HiddenCloseButtonSheet"
    var options: Set<SKSheetOptions> = [.hideContinueButton(true), .style(.prominent)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "chevron.forward.circle")
            SKTitle("Continue Button Hidden")
            SKDescription("This sheet has the continue button hidden. Manual toolbar primary button is required.")
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

In this example, `VisibleContinueButtonSheet` uses `.hideContinueButton(false)` to display the continue button, styled with ``SKPrimaryButtonStyle``, for forward navigation. `HiddenContinueButtonSheet` uses `.hideContinueButton(true)`, hiding the continue button.

## Design Images

This section illustrates the visual design of sheets using the ``SKSheetOptions/hideContinueButton(_:)`` option, with the continue button styled using ``SKPrimaryButtonStyle`` across various Apple platforms. The images showcase version-specific adaptations for both visible and hidden continue button states.

@TabNavigator {
    @Tab("iOS") {
        On iOS, the continue button, styled with ``SKPrimaryButtonStyle``, appears in the toolbar when visible.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                The continue button is a capsule shape with a liquid glass effect, accent color background, and white text.
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
                The continue button is a rounded rectangle with an accent color background and white text,.
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
        On iPadOS, the continue button, styled with ``SKPrimaryButtonStyle``, appears in the toolbar when visible. The close button is unaffected.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                The continue button is a capsule shape with a liquid glass effect, accent color background, and white text, optimized for touch interactions on larger displays.
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
                The continue button is a rounded rectangle with an accent color background and white text, aligning with iPadOS’s traditional design language.
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
        On macOS, the continue button, styled with ``SKPrimaryButtonStyle``, is placed at the bottom right corner of the sheet. When `hideContinueButton(true)` is set, a manual toolbar primary button is required for forward navigation.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                The continue button is a capsule with white text and an accent color liquid glass background for all styles (`default`, `compact`, `prominent`), with placement at the bottom for `default` and top for `compact` and `prominent`.
                @TabNavigator {
                    @Tab("Default") {
                        The continue button is a capsule with white text, minimum width of 100, placed at the bottom.
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
                        The continue button is a capsule with white text, minimum width of 100, placed at the bottom.
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
                        The continue button is a capsule with white text, size matching content, placed at the bottom.
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
                The continue button is a rounded rectangle with white text, a gradient accent color background, shadow, and white-to-black gradient border for depth, placed at the bottom of the sheet.
                @TabNavigator {
                    @Tab("Default") {
                        The continue button is a rounded rectangle with white text, placed at the bottom.
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
                        The continue button is a rounded rectangle with white text, optimized for compact layout, placed at the bottom.
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
                        The continue button is a rounded rectangle with white text, with a size matching content for prominence, placed at the bottom.
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
        On watchOS, the continue button, styled with ``SKPrimaryButtonStyle``, appears as a circular button in the bottom-right corner when visible, requiring a `systemImage` (e.g., `chevron.forward`) for display. The back button and close button are unaffected.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                The continue button is a circular button with no background, a liquid glass effect, and a `systemImage`, skipping text for clarity on small screens.
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
                The continue button is a circular button with a gray background and a `systemImage`, skipping text.
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
        On tvOS, the continue button, styled with ``SKPrimaryButtonStyle``, appears in the toolbar when visible. When `hideContinueButton(true)` is set, a manual toolbar primary button is required for forward navigation.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                The continue button is a liquid glass rounded rectangle with an accent color background and white text.
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
                The continue button is a standard rounded border with an accent color background and white text.
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
        On visionOS, the continue button, styled with ``SKPrimaryButtonStyle``, appears as a capsule button at the bottom of the screen, using only text.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                The continue button is a capsule with an accent color background and white text, optimized for spatial interfaces.
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
                The continue button is a capsule with an accent color background and white text, maintaining consistency across visionOS versions.
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
