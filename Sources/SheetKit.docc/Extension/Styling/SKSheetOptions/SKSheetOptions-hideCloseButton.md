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

An option to control the visibility of the default close button in a sheet.

## Overview

The ``SKSheetOptions/hideCloseButton(_:)`` option in the `SheetKit` framework determines whether the default close button, styled with ``SKNavigationButtonStyle``, is visible in a sheet conforming to the ``SKSheetable`` protocol implementations. When set to `true`, the close button is hidden, requiring programmatic dismissal (e.g., via ``SKSheetManager``). When set to `false`, the close button is visible, allowing users to dismiss the sheet manually. 

The close button is distinct from the back button, which is always present across all platforms (iOS, iPadOS, macOS, watchOS, tvOS, visionOS) to navigate between pages within a sheet. On macOS and tvOS, when `hideCloseButton(true)` is set, the back button is absent on the first page but appears in the navigations button’s position on subsequent pages, styled with ``SKNavigationButtonStyle``. On iOS, iPadOS, watchOS, and visionOS, the close button and back button are separate, with the back button appearing on all pages except the first for multi-page sheets, unaffected by the `hideCloseButton` setting.

>Important: It is recommended to use this option with ``SKSheetOptions/interactiveDismissDisabled(_:)`` to maintain a consistent user experience when disabling all dismisall options.

## Example

The following example demonstrates two sheets: one with the close button visible and one with it hidden, each with single pages to illustrate the option behavior:

```swift
import SwiftUI
import SheetKit

struct VisibleCloseButtonSheet: SKSheet {
    var id: String = "VisibleCloseButtonSheet"
    var options: Set<SKSheetOptions> = [.hideCloseButton(false), .style(.default)]
    
    var pages: [SKPage] {
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
    
    var pages: [SKPage] {
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
struct SheetKitExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(sheets: VisibleCloseButtonSheet.self, HiddenCloseButtonSheet.self)
        }
    }
}
```

In this example, `VisibleCloseButtonSheet` uses `.hideCloseButton(false)` to display the close button, styled with ``SKNavigationButtonStyle``. `HiddenCloseButtonSheet` uses `.hideCloseButton(true)`, hiding the close button; on macOS and tvOS, the back button, styled with ``SKNavigationButtonStyle``.

## Design Images

This section illustrates the visual design of sheets using the ``SKSheetOptions/hideCloseButton(_:)`` option, with the close button and back button (when replacing the close button on macOS and tvOS) styled using ``SKNavigationButtonStyle`` across various Apple platforms. The images showcase version-specific adaptations for both visible and hidden close button states.

@TabNavigator {
    @Tab("iOS") {
        On iOS, the close button, styled with ``SKNavigationButtonStyle``, appears in the top-right corner when visible.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                The close button is a clear liquid glass button with an `xmark` icon in the accent color foreground style, featuring a subtle animation. Only the `xmark` icon is used if both image and text are provided.
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
                The close button is a text button labeled "Close" with an accent color foreground style, using both text and image if provided.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-iOS18", alt: "Close Button Visible (Text)") {
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
        On iPadOS, the close button, styled with ``SKNavigationButtonStyle``, appears in the top-right corner when visible. 
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                The close button is a clear liquid glass button with an `xmark` icon in the accent color foreground style, optimized for larger screens. Only the `xmark` icon is used if both image and text are provided.
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
                The close button is a text button labeled "Close" with an accent color foreground style, using both text and image if provided. 
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-HideCloseButton-Showing-iPadOS18", alt: "Close Button Visible (Text)") {
                            Close Button Visible=
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
        On macOS, the close button, styled with ``SKNavigationButtonStyle``, affects the back button on multi-page sheets when `hideCloseButton(true)` is set, with the back button absent on the first page but appearing in the close button’s position on subsequent pages. Placement is influenced by ``SKSheetStyle``: bottom for `default`, top for `compact` and `prominent`.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                The close button uses a clear liquid glass capsule with primary color text for `default` style (bottom placement), or a circular button with an accent color `xmark` icon and liquid glass background for `compact` and `prominent` styles (top placement).
                @TabNavigator {
                    @Tab("Default") {
                        The close button or back button is a capsule with primary color text in a clear liquid glass capsule, minimum width of 100, placed at the bottom.
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
                        The close button or back button is a circular button with an accent color `xmark` icon in a liquid glass background, size matching content, placed at the top.
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
                        The close button or back button is a circular button with an accent color `xmark` icon in a liquid glass background, size matching content, placed at the top.
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
                The close button or back button uses a plain text design with primary color foreground, gradient background, shadow, and white-to-black gradient border for depth, placed at the bottom for `default` or top for `compact` and `prominent`.
                @TabNavigator {
                    @Tab("Default") {
                        The close button or back button is a plain text design with primary color foreground, placed at the bottom.
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
                        The close button or back button is a plain text design with primary color foreground, optimized for compact layout, placed at the top.
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
                        The close button or back button is a plain text design with primary color foreground, with a size matching content for prominence, placed at the top.
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
        On watchOS, the close button, styled with ``SKNavigationButtonStyle``, appears as a circular button with an `xmark` icon in the top-left corner when visible. 
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                The close button is a circular button with no background, a liquid glass effect, and an `xmark` icon, skipping text. 
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
                The close button is a circular button with a gray background and an `xmark` icon, skipping text. 
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
        On tvOS, the close button, styled with ``SKNavigationButtonStyle``, appears in the top-right corner when visible. When `hideCloseButton(true)` is set, the back button is absent on the first page but appears in the close button’s position on subsequent pages, also styled with ``SKNavigationButtonStyle``.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                The close button uses accent color text with a clear liquid glass background.
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
                The close button uses accent color text with a semi-transparent gray liquid default border.
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
        On visionOS, the close button, styled with ``SKNavigationButtonStyle``, appears as a circular button with an `xmark` icon in the top-right corner when visible.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                The close button is a circular button with a gray background and an accent color `xmark` icon, using only the image if both image and text are provided. 
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
                The close button is a circular button with a gray background and an accent color `xmark` icon, using only the image if both image and text are provided.
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
