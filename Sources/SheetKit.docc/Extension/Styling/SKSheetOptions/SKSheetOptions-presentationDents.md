# ``SheetKit/SKSheetOptions/presentationDents(dents:selection:)``

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

An option to customize the presentation detents (edge effects or sizes) of a sheet, available only on iPhone and iPad. On other platforms, this option is ignored.

## Overview

The ``SKSheetOptions/presentationDents(dents:selection:)`` option allows developers to define the detent sizes or edge effects for sheets conforming to the ``SKSheetable`` protocol, tailoring the visual presentation on iPhone and iPad. The `dents` parameter accepts a set of `PresentationDetent` values, including `.large`, `.medium`, and custom heights (e.g., `.height(250)` for a 250 points size), to specify the available detent states. The optional `selection` parameter, a `Binding<PresentationDetent>?`, allows dynamic control over the active detent state. This option enhances the sheet's adaptability, enabling varied visual footprints based on the chosen detent.

The default detent is `.large`, which presents as a big card on iPad and almost full-screen on iOS. The `.medium` detent is a card sized to the middle of `.large` on both iPhone and iPad. Custom heights, such as `.height(250)`, allow precise control over the sheet's size in points, offering additional flexibility. The `selection` binding, if provided, enables runtime changes to the detent state, supporting interactive adjustments. This feature is exclusive to iPhone and iPad; on macOS, tvOS, watchOS, and visionOS, it has no effect due to differing presentation models.

This option integrates with other `SheetKit` features like ``SKSheetOptions/alignment(_:)`` and ``SKSheetOptions/style(_:)``, allowing for a cohesive design. On older OS versions (pre-26), the card presentation features a lower corner radius compared to the sharper, more defined corners in version 26 and newer.

### Platform-Specific Behavior

- **iPhone and iPad**: Applies custom detents (`.large` for a big card/almost full-screen, `.medium` for a mid-sized card, or `.height(value)` for a specific pixel height). Older versions (pre-26) use a lower corner radius, while version 26 and newer feature a higher corner radius.
- **macOS**: Ignored, as macOS uses window-based sheets.
- **tvOS**: Ignored, as tvOS sheets are full-screen by default.
- **watchOS**: Ignored, due to the compact nature of watchOS interfaces.
- **visionOS**: Ignored, as visionOS uses window-based sheets.

## Example

The following examples demonstrate the use of ``SKSheetOptions/presentationDents(dents:selection:)`` with sheets containing only `SKHeaderImage`, `SKTitle`, and `SKDescription`. One example uses `.medium` detents, another uses `.large` detents, and a third uses a custom `.height(250)` detent, showcasing the difference in presentation on iPhone and iPad.

```swift
import SwiftUI
import SheetKit

struct PresentationDentsMedium: SKSheet {
    var id: String = "square.fill.on.square.fill"
    var options: Set<SKSheetOptions> = [.presentationDents(dents: [.medium])]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "rectangle.fill.on.rectangle.fill")
            SKTitle("Medium Dents Presentation")
            SKDescription("This sheet uses medium dents for a mid-sized card, available only on iPhone and iPad.")
        }
    }
}

struct PresentationDentsLarge: SKSheet {
    var id: String = "PresentationDentsMedium"
    var options: Set<SKSheetOptions> = [.presentationDents(dents: [.large])]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "rectangle.portrait.on.rectangle.portrait.fill")
            SKTitle("Large Dents Presentation")
            SKDescription("This sheet uses large dents for a big card on iPad and almost full-screen on iOS, available only on iPhone and iPad.")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Medium Dents Sheet") {
                sheetManager.show(sheet: PresentationDentsMedium.self)
            }
            Button("Show Large Dents Sheet") {
                sheetManager.show(sheet: PresentationDentsLarge.self)
            }
        }
        .padding()
    }
}

@main
struct PresentationDentsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(.init())
        }
    }
}
```

In these examples, `PresentationDentsMedium` uses `.presentationDents(dents: [.medium])` for a mid-sized card, `PresentationDentsLarge` uses `.presentationDents(dents: [.large])` for a big card on iPad and almost full-screen on iOS. Both are designed for iPhone and iPad, with the `ContentView` providing interactive testing of the different detent styles.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, `presentationDents` adjusts the sheet's size and edge effects.
        @TabNavigator {
            @Tab("iOS 26 and newer") {
                Sheets with higher corner radius and custom detents.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iOS26", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iOS26", alt: "Large Dents (Almost Full-Screen)") {
                            Large / Default Dent
                        }
                    }
                }
            }
            @Tab("iOS 18 and older") {
                Sheets with lower corner radius and custom detents.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iOS18", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iOS18", alt: "Large Dents (Almost Full-Screen)") {
                            Large / Default Dent
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, `presentationDents` customizes the sheet's presentation.
        @TabNavigator {
            @Tab("iPadOS 26 and newer") {
                Sheets with higher corner radius and custom detents.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iPadOS26", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iPadOS26", alt: "Large Dents (Big Card)") {
                            Large / Default Dent
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and older") {
                Sheets with lower corner radius and custom detents.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iPadOS18", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iPadOS18", alt: "Large Dents (Big Card)") {
                            Large / Default Dent
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
- ``SKSheetView/skSheetStyle(_:selection:)``
