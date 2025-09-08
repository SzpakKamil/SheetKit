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

Customizes the presentation detents (edge effects or sizes) of a sheet, available only on iPhone and iPad. Ignored on other platforms.

## Overview

The `SKSheetOptions/presentationDents(dents:selection:)` option allows developers to define the detent sizes or edge effects for sheets conforming to the `SKSheetable` protocol, tailoring their presentation on iPhone and iPad. The `dents` parameter accepts a set of `PresentationDetent` values, such as `.large`, `.medium`, or custom heights like `.height(250)` for a 250-point size, specifying the available detent states. The optional `selection` parameter, a `Binding<PresentationDetent>?`, enables dynamic control over the active detent state, supporting interactive size adjustments.

The default detent is `.large`, presenting a big card on iPad and nearly full-screen on iPhone. The `.medium` detent creates a mid-sized card, approximately half the size of `.large`, on both platforms. Custom heights, such as `.height(250)`, offer precise control over sheet size in points. The `selection` binding, if provided, allows runtime changes to the detent state, enhancing user interaction. This option is exclusive to iPhone and iPad; it has no effect on macOS, tvOS, watchOS, or visionOS due to their distinct presentation models.

This option integrates with other `SheetKit` features, such as `SKSheetOptions/alignment(_:)` and `SKSheetOptions/style(_:)`, for a cohesive design. On older OS versions (pre-26), sheets have a lower corner radius, while version 26 and newer feature sharper, more defined corners for a modern aesthetic.

### Platform-Specific Behavior

- **iPhone/iPadOS**: Supports `.large` (big card/near full-screen), `.medium` (mid-sized card), or `.height(value)` (custom height). Pre-26 uses lower corner radius; 26+ uses higher corner radius.
- **macOS/tvOS/watchOS/visionOS**: Ignored due to platform-specific sheet presentations.

## Example

The following examples demonstrate `SKSheetOptions/presentationDents(dents:selection:)` with sheets containing `SKHeaderImage`, `SKTitle`, and `SKDescription`. One example uses `.medium` detents, another uses `.large` detents, and a third uses a custom `.height(250)` detent, showcasing presentation differences on iPhone and iPad.

```swift
import SwiftUI
import SheetKit

struct PresentationDentsMedium: SKSheet {
    var id: String = "PresentationDentsMedium"
    var options: Set<SKSheetOptions> = [.presentationDents(dents: [.medium])]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "rectangle.fill.on.rectangle.fill")
            SKTitle("Medium Dents Presentation")
            SKDescription("This sheet uses medium detents for a mid-sized card, available only on iPhone and iPad.")
        }
    }
}

struct PresentationDentsLarge: SKSheet {
    var id: String = "PresentationDentsLarge"
    var options: Set<SKSheetOptions> = [.presentationDents(dents: [.large])]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "rectangle.portrait.on.rectangle.portrait.fill")
            SKTitle("Large Dents Presentation")
            SKDescription("This sheet uses large detents for a big card on iPad and almost full-screen on iPhone, available only on iPhone and iPad.")
        }
    }
}

struct PresentationDentsCustom: SKSheet {
    var id: String = "PresentationDentsCustom"
    var options: Set<SKSheetOptions> = [.presentationDents(dents: [.height(250)])]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "rectangle.stack.fill")
            SKTitle("Custom Dents Presentation")
            SKDescription("This sheet uses a custom height detent of 250 points, available only on iPhone and iPad.")
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
            Button("Show Custom Dents Sheet") {
                sheetManager.show(sheet: PresentationDentsCustom.self)
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

In these examples, `PresentationDentsMedium` uses `.presentationDents(dents: [.medium])` for a mid-sized card, `PresentationDentsLarge` uses `.presentationDents(dents: [.large])` for a big card on iPad and nearly full-screen on iPhone, and `PresentationDentsCustom` uses `.presentationDents(dents: [.height(250)])` for a 250-point height. The `ContentView` enables interactive testing of these detent styles on iPhone and iPad.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `presentationDents` option provides developers with fine-grained control over the size and edge effects of sheets, allowing for tailored presentations that enhance user interaction on iPhone devices. By specifying detent sizes like `.large`, `.medium`, or custom heights such as `.height(250)`, developers can adjust the sheet’s visual footprint to suit the content’s needs, ensuring an optimal balance between visibility and screen real estate. The corner radius of the sheet varies by iOS version, affecting the aesthetic and perceived modernity of the presentation.
        @TabNavigator {
            @Tab("iOS 26 and newer") {
                On iOS 26 and newer, sheets feature a higher corner radius, giving them a sharper, more modern appearance that aligns with contemporary design trends. The `.large` detent presents a near full-screen sheet, ideal for immersive content, while `.medium` offers a compact, mid-sized card for quick interactions. Custom heights, like `.height(250)`, provide precise control for specialized use cases, ensuring flexibility in design.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iOS26", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iOS26", alt:: "Large Dents (Almost Full-Screen)") {
                            Large / Default Dents
                        }
                    }
                }
            }
            @Tab("iOS 18 and older") {
                On iOS 18 and earlier, sheets have a lower corner radius, resulting in a softer, more rounded appearance compared to newer versions. The `.large` detent still delivers a near full-screen experience, while `.medium` provides a mid-sized card suitable for concise content. Custom height detents, such as `.height(250)`, allow developers to fine-tune the sheet’s size for specific use cases, maintaining functionality despite the older aesthetic.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iOS18", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iOS18", alt: "Large Dents (Almost Full-Screen)") {
                            Large / Default Dents
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, `presentationDents` customizes the sheet’s presentation to leverage the larger screen real estate of iPads, enabling developers to create visually appealing and functional interfaces. The ability to specify detent sizes like `.large` for a big card, `.medium` for a mid-sized card, or custom heights like `.height(250)` allows for flexible layouts that adapt to diverse content types, from detailed forms to compact alerts. The corner radius varies by iPadOS version, influencing the sheet’s visual style and integration with the app’s design.
        @TabNavigator {
            @Tab("iPadOS 26 and newer") {
                For iPadOS 26 and newer, sheets feature a higher corner radius, providing a sleek, modern look that enhances the iPad’s expansive display. The `.large` detent creates a prominent card ideal for detailed content, while `.medium` offers a balanced, mid-sized card for quick interactions. Custom height detents, such as `.height(250)`, enable precise sizing, making it easier to tailor the sheet to specific use cases on larger screens.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iPadOS26", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iPadOS26", alt: "Large Dents (Big Card)") {
                            Large / Default Dents
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and older") {
                On iPadOS 18 and earlier, sheets have a lower corner radius, giving them a softer, rounded appearance compared to newer versions. The `.large` detent presents a prominent card suitable for extensive content, while `.medium` provides a mid-sized option for concise interactions. Custom height detents, like `.height(250)`, offer flexibility for tailored presentations, maintaining usability despite the older design aesthetic.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iPadOS18", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iPadOS18", alt: "Large Dents (Big Card)") {
                            Large / Default Dents
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
- ``SwiftUICore/EnvironmentValues/skSheetStyleDents``
- ``SwiftUICore/EnvironmentValues/skSheetStyleDentsSelection``
