# ``SheetKit/isFullScreenCover(_:)``

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

Changes the sheet presentation to a full-screen cover on iOS, iPadOS, and tvOS, ideal for immersive content like welcome screens, hiding the background.

## Overview

The `isFullScreenCover(_:)` option transforms a sheet’s default card-like presentation into a full-screen cover on iOS, iPadOS, and tvOS, making it ideal for scenarios requiring complete user focus, such as welcome screens, onboarding flows, or critical alerts. By setting this option to `true`, the sheet occupies the entire screen, eliminating the card overlay effect and obscuring the background content. When set to `false` (the default), the sheet retains its standard card-based presentation, allowing the background to remain partially visible.

This option is particularly useful for creating immersive experiences where the underlying content is irrelevant, ensuring the user’s attention remains on the sheet’s content. On macOS, watchOS, and visionOS, this option has no effect due to their window-based or compact presentation models. On iPadOS 26 and newer, enabling full-screen cover enforces leading alignment for all content, enhancing readability on larger screens.

### Platform-Specific Behavior

- **iOS/iPadOS**: Transforms sheet to full-screen cover, hiding background. iPadOS 26+ enforces leading alignment.
- **tvOS**: Applies full-screen cover; no effect on tvOS 18 as sheets are full-screen by default.
- **macOS/watchOS/visionOS**: Ignored due to platform-specific presentation models.

## Example

The following examples demonstrate `isFullScreenCover(_:)` with sheets containing `SKHeaderImage`, `SKTitle`, and `SKDescription`. One example enables full-screen cover, while the other uses the standard card presentation, illustrating the difference on iOS, iPadOS, and tvOS. A `ContentView` enables interactive testing.

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
            SKDescription("This sheet is displayed as a standard card-based sheet.")
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

In these examples, `FullScreenCoverEnabledSheet` uses `.isFullScreenCover(true)` to display as a full-screen cover on iOS, iPadOS, and tvOS, with an iPhone icon emphasizing the mode. `FullScreenCoverDisabledSheet` uses `.isFullScreenCover(false)` for a standard card-based sheet. The `ContentView` facilitates testing both presentations, highlighting the transition from card to full-screen.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `isFullScreenCover` option transforms sheets into full-screen covers, creating an immersive experience that hides the background and focuses user attention on the sheet’s content. This is ideal for scenarios like onboarding or alerts, where the underlying app context is irrelevant. When set to `true`, the sheet occupies the entire iPhone screen, removing the card overlay effect. On iOS 26 and newer, full-screen covers align content to enhance readability, ensuring a polished and distraction-free presentation.
        @TabNavigator {
            @Tab("iOS 26 and newer") {
                For iOS 26 and newer, enabling `isFullScreenCover(true)` presents the sheet as a full-screen cover with recommended leading alignment, optimizing content layout for clarity and consistency. This modern design ensures that elements like `SKTitle` and `SKDescription` are visually cohesive, making it ideal for immersive experiences such as welcome screens or detailed forms on iPhones.
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
                On iOS 18 and earlier, `isFullScreenCover(true)` transforms the sheet into a full-screen cover, maintaining a balanced design consistent with older iOS aesthetics. While lacking the leading alignment enforcement of newer versions, it still provides a distraction-free experience, ideal for critical alerts or onboarding flows where the background must be hidden.
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
        On iPadOS, `isFullScreenCover` enables sheets to transition from card-based to full-screen covers, leveraging the larger screen real estate for immersive presentations. This is particularly effective for onboarding sequences, tutorials, or modal dialogs that require complete user focus. When enabled, the sheet fills the iPad screen, hiding the background and ensuring content like `SKTitle` and `SKDescription` stands out, with iPadOS 26+ enforcing leading alignment for optimal readability.
        @TabNavigator {
            @Tab("iPadOS 26 and newer") {
                For iPadOS 26 and newer, `isFullScreenCover(true)` presents the sheet as a full-screen cover with all content aligned to the leading edge, enhancing readability on larger displays. This design choice ensures that text-heavy sheets, such as instructional or welcome screens, are presented clearly, making it easier for users to engage with content in a distraction-free environment.
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
                On iPadOS 18 and earlier, `isFullScreenCover(true)` transforms the sheet into a full-screen cover, preserving the older design aesthetic. While it lacks the leading alignment enforcement of newer versions, it still ensures a focused, immersive experience, ideal for scenarios where the background content must be completely hidden, such as in onboarding or alert scenarios.
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
        On tvOS, `isFullScreenCover` ensures sheets are presented as full-screen covers, aligning with the platform’s large-screen, remote-based navigation model. This option is particularly useful for creating focused, distraction-free interfaces for content like setup guides or alerts, ensuring users can engage with the sheet without background interference. On older tvOS versions, the effect may be minimal due to the default full-screen presentation.
        @TabNavigator {
            @Tab("tvOS 26 and newer") {
                For tvOS 26 and newer, `isFullScreenCover(true)` ensures a full-screen presentation, enhancing focus on content like instructional text or media-rich sheets. This aligns with tvOS’s design for living room experiences, where clear, full-screen interfaces are critical for usability with remote navigation, ensuring content is prominent and accessible.
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
                On tvOS 18 and earlier, `isFullScreenCover(true)` has minimal impact as sheets are already presented full-screen by default. However, enabling this option ensures consistency with newer versions, maintaining a distraction-free experience for users interacting via remote, ideal for alerts or setup screens on older tvOS systems.
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
- ``SwiftUICore/EnvironmentValues/skIsUsingFullScreenCover``
