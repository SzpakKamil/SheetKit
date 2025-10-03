# ``SheetKit/SKSheetOptions/hideCloseButton(_:)``

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

Controls the visibility of the default close button in a sheet, styled with `SKNavigationButtonStyle`.

## Overview

The `hideCloseButton(_:)` option in the `SheetKit` framework determines whether the default close button, styled with ``SKNavigationButtonStyle``, is visible in a sheet conforming to the `SKSheetable` protocol, such as ``SKSheetView`` or custom ``SKSheet`` implementations. When set to `true`, the close button is hidden, requiring programmatic dismissal via ``SKSheetManager``. When set to `false` (the default), the close button is visible, allowing users to dismiss the sheet manually.

The close button is distinct from the back button, which navigates between pages in multi-page sheets and is always present across all platforms (iOS, iPadOS, macOS, watchOS, tvOS, visionOS). On macOS and tvOS, when `hideCloseButton(true)` is set, the back button is absent on the first page but appears in the close button’s position on subsequent pages, styled with `SKNavigationButtonStyle`. On iOS, iPadOS, watchOS, and visionOS, the close and back buttons are separate, with the back button appearing on all pages except the first for multi-page sheets, unaffected by this option.

### Platform-Specific Behavior

- **iOS/iPadOS/watchOS/visionOS**: Shows/hides the close button, separate from the back button.
- **macOS/tvOS**: Shows/hides the close button; when hidden, the back button replaces it on subsequent pages.
- **All platforms**: Back button is always present for multi-page sheets, except on the first page.

> Important: Use with ``SKSheetOptions/interactiveDismissDisabled(_:)`` to ensure a consistent dismissal experience.

## Example

The following examples demonstrate two sheets: one with the close button visible and one with it hidden, each with a single page to illustrate the behavior. A `ContentView` enables interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct VisibleCloseButtonSheet: SKSheet {
    var id: String = "VisibleCloseButtonSheet"
    var options: Set<SKSheetOptions> = [.hideCloseButton(false), .style(.default)]
    
    var pages: [any SKPageable] {
        SKPage {
            SKHeaderImage(systemName: "xmark.circle")
            SKTitle("Close Button Visible")
            SKDescription("This sheet displays a close button for easy dismissal.")
        }
    }
}

struct HiddenCloseButtonSheet: SKSheet {
    var id: String = "HiddenCloseButtonSheet"
    var options: Set<SKSheetOptions> = [.hideCloseButton(true), .style(.default)]
    
    var pages: [any SKPageable] {
        SKPage {
            SKHeaderImage(systemName: "xmark.circle")
            SKTitle("Close Button Hidden")
            SKDescription("This sheet has the close button hidden, requiring programmatic dismissal.")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Sheet with Visible Close Button") {
                sheetManager.show(sheet: VisibleCloseButtonSheet.self)
            }
            Button("Show Sheet with Hidden Close Button") {
                sheetManager.show(sheet: HiddenCloseButtonSheet.self)
            }
        }
        .padding()
    }
}

@main
struct SheetKitExampleApp:-java
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(sheets: VisibleCloseButtonSheet.self, HiddenCloseButtonSheet.self)
        }
    }
}
```

In these examples, `VisibleCloseButtonSheet` uses `.hideCloseButton(false)` to display the close button, styled with ``SKNavigationButtonStyle``. `HiddenCloseButtonSheet` uses `.hideCloseButton(true)`, requiring programmatic dismissal. The `ContentView` facilitates testing both configurations.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `hideCloseButton` option controls the visibility of the close button, styled with `SKNavigationButtonStyle`, in the top-right corner. When visible, it provides an intuitive dismissal mechanism for touch-driven interfaces, ideal for non-critical sheets. Hiding it ensures controlled dismissal for mandatory workflows, such as forms or alerts, enhancing user focus on iPhone devices.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                For iOS 26 and newer, the close button is a clear liquid glass button with an `xmark` icon in the accent color, featuring a subtle animation. Setting `.hideCloseButton(true)` removes it, requiring programmatic dismissal, ideal for critical tasks in modern iOS designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-iOS26", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-iOS26", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                On iOS 18 and earlier, the close button is a text button labeled "Close" with an accent color foreground, using both text and image if provided. Hiding it with `.hideCloseButton(true)` supports controlled workflows in older iOS environments.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-iOS18", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-iOS18", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the `hideCloseButton` option manages the close button’s visibility in the top-right corner, styled with ``SKNavigationButtonStyle``. This is crucial for larger screens, where clear dismissal options enhance usability in multitasking environments. Hiding the button ensures user engagement for critical content, such as tutorials or settings panels.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the close button is a clear liquid glass button with an `xmark` icon in the accent color, optimized for touch interactions. Setting `.hideCloseButton(true)` supports mandatory workflows, ensuring focus in modern iPadOS designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-iPadOS26", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-iPadOS26", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                On iPadOS 18 and earlier, the close button is a text button labeled "Close" with an accent color foreground, using both text and image if provided. Hiding it supports controlled interactions in older multitasking environments.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-iPadOS18", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-iPadOS18", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        On macOS, the `hideCloseButton` option controls the close button’s visibility, styled with ``SKNavigationButtonStyle``, affecting the back button on multi-page sheets when hidden. The back button is absent on the first page but replaces the close button on subsequent pages, with placement varying by `SKSheetStyle` (bottom for `default`, top for `compact`/`prominent`). This ensures controlled dismissal in window-based interfaces.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                For macOS 26 and newer, the close button is a clear liquid glass capsule with primary color text (`default`, bottom) or a circular button with an accent color `xmark` icon (``SKSheetStyle/compact``/``SKSheetStyle/prominent``, top). Setting `.hideCloseButton(true)` removes it, with the back button appearing on subsequent pages for multi-page sheets.
                @TabNavigator {
                    @Tab("Default") {
                        The close/back button is a capsule with primary color text, minimum width of 100, placed at the bottom. Hiding it supports programmatic dismissal for critical tasks.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-Default-macOS26", alt: "Close Button Visible") {
                                    Close Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-Default-macOS26", alt: "Close Button Hidden") {
                                    Close Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The close/back button is a circular button with an accent color `xmark` icon, size matching content, placed at the top. Hiding it enables controlled navigation.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-Compact-macOS26", alt: "Close Button Visible") {
                                    Close Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-Compact-macOS26", alt: "Close Button Hidden") {
                                    Close Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The close/back button is a circular button with an accent color `xmark` icon, size matching content, placed at the top. Hiding it supports controlled workflows.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-Prominent-macOS26", alt: "Close Button Visible") {
                                    Close Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-Prominent-macOS26", alt: "Close Button Hidden") {
                                    Close Button Hidden
                                }
                            }
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                For macOS 15 and earlier, the close/back button is a plain text design with primary color foreground, gradient background, shadow, and white-to-black gradient border, placed at the bottom (`default`) or top (`compact`/`prominent`). Hiding it ensures programmatic dismissal.
                @TabNavigator {
                    @Tab("Default") {
                        The close/back button is a plain text design, placed at the bottom. Hiding it supports controlled dismissal for critical tasks.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-Default-macOS15", alt: "Close Button Visible") {
                                    Close Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-Default-macOS15", alt: "Close Button Hidden") {
                                    Close Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The close/back button is a plain text design, optimized for compact layouts, placed at the top. Hiding it enables controlled navigation.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-Compact-macOS15", alt: "Close Button Visible") {
                                    Close Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-Compact-macOS15", alt: "Close Button Hidden") {
                                    Close Button Hidden
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The close/back button is a plain text design, sized for prominence, placed at the top. Hiding it supports controlled workflows.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-Prominent-macOS15", alt: "Close Button Visible") {
                                    Close Button Visible
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-Prominent-macOS15", alt: "Close Button Hidden") {
                                    Close Button Hidden
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        On watchOS, the `hideCloseButton` option controls the visibility of a circular close button with an `xmark` icon in the top-left corner, styled with `SKNavigationButtonStyle`. This is critical for glanceable interfaces, where clear dismissal options enhance usability on small screens. Hiding the button ensures controlled dismissal for critical tasks.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                For watchOS 26 and newer, the close button is a circular button with no background, a liquid glass effect, and an `xmark` icon, omitting text for clarity. Setting `.hideCloseButton(true)` requires programmatic dismissal, ideal for mandatory interactions on wearables.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-watchOS26", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-watchOS26", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                On watchOS 11 and earlier, the close button is a circular button with a gray background and an `xmark` icon, skipping text. Hiding it supports controlled dismissal in older watchOS interfaces.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-watchOS11", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-watchOS11", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the `hideCloseButton` option controls the close button’s visibility in the top-right corner, styled with `SKNavigationButtonStyle`. When hidden, the back button replaces it on subsequent pages for multi-page sheets, ensuring navigation consistency in remote-driven interfaces. This is key for full-screen, living-room experiences.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                For tvOS 26 and newer, the close button uses accent color text with a clear liquid glass background. Setting `.hideCloseButton(true)` removes it, with the back button appearing on subsequent pages, maintaining navigation clarity.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-tvOS26", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-tvOS26", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                On tvOS 18 and earlier, the close button uses accent color text with a semi-transparent gray liquid default border. Hiding it ensures the back button appears on subsequent pages, aligning with older tvOS designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-tvOS18", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-tvOS18", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, the `hideCloseButton` option controls the visibility of a circular close button with an `xmark` icon in the top-right corner, styled with `SKNavigationButtonStyle`. This is crucial for spatial interfaces, where clear dismissal enhances immersion. Hiding the button ensures controlled dismissal for critical mixed reality tasks.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                For visionOS 26 and newer, the close button is a circular button with a gray background and an accent color `xmark` icon, using only the image if both are provided. Setting `.hideCloseButton(true)` requires programmatic dismissal, ideal for immersive 3D sheets.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-visionOS26", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-visionOS26", alt: "Close Button Hidden") {
                            Close Button Hidden
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                On visionOS 2 and earlier, the close button is a circular button with a gray background and an accent color `xmark` icon, consistent with newer versions. Hiding it supports controlled dismissal in early mixed reality designs.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-visionOS2", alt: "Close Button Visible") {
                            Close Button Visible
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Hidden-visionOS2", alt: "Close Button Hidden") {
                            Close Button Hidden
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
- ``SKNavigationButtonStyle``
- ``SKSheetManager``
- ``SwiftUICore/EnvironmentValues/skIsCloseButtonHidden``
