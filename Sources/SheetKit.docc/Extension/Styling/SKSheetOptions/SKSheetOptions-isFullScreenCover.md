# ``SheetKit/SKSheetOptions/isFullScreenCover(_:)``

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

Option which changes the display on iOS, iPadOS, and tvOS from a card-based sheet to a full-screen sheet, and is designed for hiding content like welcome sheets so no background is shown.

## Overview

The ``SKSheetOptions/isFullScreenCover(_:)`` option allows developers to transform a sheet from its default card-like presentation into a full-screen cover on iOS, iPadOS, and tvOS. This option is particularly useful for scenarios where a sheet needs to dominate the screen, such as welcome screens, onboarding flows, or critical alerts, effectively hiding the underlying content or background. The option accepts a Boolean value (`true` to enable full-screen cover, `false` to revert to the standard card presentation), providing flexibility in presentation style.

By setting ``isFullScreenCover(_:)`` to `true`, the sheet expands to occupy the entire screen, removing the card overlay effect and ensuring the user's focus remains on the sheet's content. This is ideal for immersive experiences or when the background context is irrelevant. On platforms like macOS, watchOS, and visionOS, this option has no effect, as their sheet presentations are window-based rather than card or full-screen covers. The default value is `false`, maintaining the traditional card-based sheet behavior.

This option integrates with other `SheetKit` features, such as ``SKSheetOptions/alignment(_:)`` and ``SKSheetOptions/style(_:)``, to create a seamless and customizable full-screen experience. On iPadOS 26, enabling full-screen cover also adjusts the design to use full leading alignment for all content, enhancing readability and consistency across the larger screen.

### Platform-Specific Behavior

- **iOS and iPadOS**: Changes the sheet from a card overlay to a full-screen cover, hiding the background. On iPadOS 26, full-screen cover enforces leading alignment for all content.
- **tvOS**: Transforms the sheet into a full-screen cover, though on tvOS 18, there is no difference as sheets are already full-screen by default.
- **macOS**: Has no effect, as macOS uses window-based sheets.
- **watchOS**: Has no effect, as watchOS sheets are designed for compact displays and do not support full-screen transitions.
- **visionOS**: Has no effect, as visionOS uses window-based sheets.

## Example

The following examples demonstrate the use of ``SKSheetOptions/isFullScreenCover(_:)`` with sheets containing only `SKHeaderImage`, `SKTitle`, and `SKDescription`. One example enables full-screen cover, while the other disables it, showing the difference in presentation. A `ContentView` is provided to test the sheets interactively within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct FullScreenCoverEnabledSheet: SKSheet {
    var id: String = "FullScreenCoverEnabledSheet"
    var options: Set<SKSheetOptions> = [.isFullScreenCover(true)]
    @AppStorage("Test") var value: Bool = false
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "apps.iphone")
            SKTitle("Full Screen Sheet")
            SKDescription("This sheet is displayed as a full-screen cover on iOS, iPadOS, and tvOS.")
        }
    }
}

struct FullScreenCoverDisabledSheet: SKSheet {
    var id: String = "FullScreenCoverDisabledSheet"
    var options: Set<SKSheetOptions> = [.isFullScreenCover(false)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "apps.iphone")
            SKTitle("Regular Sheet")
            SKDescription("This sheet is displayed as a standard sheet, not full screen.")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Full Screen Sheet") {
                sheetManager.show(sheet: FullScreenCoverEnabledSheet.self)
            }
            Button("Show Regular Sheet") {
                sheetManager.show(sheet: FullScreenCoverDisabledSheet.self)
            }
        }
        .padding()
    }
}

@main
struct FullScreenCoverApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(.init())
        }
    }
}
```

In these examples, `FullScreenCoverEnabledSheet` uses `.isFullScreenCover(true)` to display the sheet as a full-screen cover on iOS, iPadOS, and tvOS, with an iPhone icon indicating the full-screen mode. `FullScreenCoverDisabledSheet` uses `.isFullScreenCover(false)` to display the sheet as a standard card-based sheet, maintaining the same icon for consistency. The `ContentView` enables testing of both sheet types, highlighting the transition from card to full-screen presentation.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, `isFullScreenCover(true)` changes the sheet from a card to a full-screen cover.
        @TabNavigator {
            @Tab("iOS 26 and newer") {
                The sheet transitions from a card to a full-screen cover, with leading alignment recommended for larger screens.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-False-iOS26", alt: "Card Layout (False)") {
                            Card Layout (False)
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-True-iOS26", alt: "Full Screen Cover (True)") {
                            Full Screen Cover (True)
                        }
                    }
                }
            }
            @Tab("iOS 18 and older") {
                The sheet changes from a card to a full-screen cover, maintaining the old design's balance.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-False-iOS18", alt: "Card Layout (False)") {
                            Card Layout (False)
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-True-iOS18", alt: "Full Screen Cover (True)") {
                            Full Screen Cover (True)
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, `isFullScreenCover(true)` transforms the sheet into a full-screen cover.
        @TabNavigator {
            @Tab("iPadOS 26 and newer") {
                The sheet becomes a full-screen cover with all content aligned to the leading edge for improved readability.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-False-iPadOS26", alt: "Card Layout (False)") {
                            Card Layout (False)
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-True-iPadOS26", alt: "Full Screen Cover (True)") {
                            Full Screen Cover (True)
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and older") {
                The sheet transitions from a card to a full-screen cover, preserving the old design.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-False-iPadOS18", alt: "Card Layout (False)") {
                            Card Layout (False)
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-True-iPadOS18", alt: "Full Screen Cover (True)") {
                            Full Screen Cover (True)
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, `isFullScreenCover(true)` ensures a full-screen presentation.
        @TabNavigator {
            @Tab("tvOS 26 and newer") {
                The sheet changes from a card to a full-screen cover, enhancing focus on content.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-False-tvOS26", alt: "Card Layout (False)") {
                            Card Layout (False)
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-True-tvOS26", alt: "Full Screen Cover (True)") {
                            Full Screen Cover (True)
                        }
                    }
                }
            }
            @Tab("tvOS 18 and older") {
                No difference, as sheets are already full-screen by default.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-False-tvOS18", alt: "Full Screen (False)") {
                            Full Screen (False)
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-isFullScreenCover-True-tvOS18", alt: "Full Screen (True)") {
                            Full Screen (True)
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
- ``SKPage``
