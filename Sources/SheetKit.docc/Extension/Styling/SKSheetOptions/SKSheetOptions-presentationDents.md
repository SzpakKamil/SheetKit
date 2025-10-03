# ``SheetKit/SKSheetOptions/presentationDents(_:)``

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

The `presentationDents(_:)` option allows developers to define the detent sizes or edge effects for sheets conforming to the ``SKSheetable`` protocol, tailoring their presentation on iPhone and iPad. The `dents` parameter accepts a set of `PresentationDetent` values, such as `.large`, `.medium`, or custom heights like `.height(250)` for a 250-point size, specifying the available detent states.

The default detent is `.large`, presenting a big card on iPad and nearly full-screen on iPhone. The `.medium` detent creates a mid-sized card, approximately half the size of `.large`, on both platforms. Custom heights, such as `.height(250)`, offer precise control over sheet size in points. This option is exclusive to iPhone and iPad; it has no effect on macOS, tvOS, watchOS, or visionOS due to their distinct presentation models.

### Platform-Specific Behavior

- **iPhone/iPadOS**: Supports `.large` (big card/near full-screen), `.medium` (mid-sized card), or `.height(value)` (custom height). Pre-26 uses lower corner radius; 26+ uses higher corner radius.
- **macOS/tvOS/watchOS/visionOS**: Ignored due to platform-specific sheet presentations.

> Note: Recomended to be used with ``presentationDragIndicator(_:)``

## Example

The following examples demonstrate `presentationDents(_:)` with sheets containing ``SKHeaderImage``, ``SKTitle``, and ``SKDescription``. One example uses `.medium` detents, and another uses `.large` detents, showcasing presentation differences on iPhone and iPad.

```swift
import SwiftUI
import SheetKit

struct PresentationDentsMedium: SKSheet {
    var id: String = "PresentationDentsMedium"
    var options: Set<SKSheetOptions> = [.presentationDents(dents: [.medium])]
    var pages: [any SKPageable] {
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
    var pages: [any SKPageable] {
        SKPage {
            SKHeaderImage(systemName: "rectangle.portrait.on.rectangle.portrait.fill")
            SKTitle("Large Dents Presentation")
            SKDescription("This sheet uses large detents for a big card on iPad and almost full-screen on iPhone, available only on iPhone and iPad.")
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

In these examples, `PresentationDentsMedium` uses `.presentationDents(dents: [.medium])` for a mid-sized card, and `PresentationDentsLarge` uses `.presentationDents(dents: [.large])` for a big card on iPad and nearly full-screen on iPhone. The `ContentView` enables interactive testing of these detent styles on iPhone and iPad.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `presentationDents(dents:)` option allows developers to customize sheet sizes on iPhone, enhancing user interaction by tailoring the presentation to content needs. The `.large` detent offers a near full-screen experience, ideal for immersive content like tutorials or forms, while `.medium` provides a compact, mid-sized card for quick interactions such as alerts or settings. The corner radius of sheets varies by iOS version, impacting the visual style and integration with the app’s design.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                For iOS 26 and newer, sheets feature a higher corner radius, delivering a sharp, modern aesthetic that aligns with Apple’s contemporary design guidelines. The `.large` detent maximizes screen usage for detailed content, while `.medium` balances visibility and compactness, suitable for quick user inputs or previews.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Medium-iOS26", alt: "Medium Dents (Mid-Sized Card)") {
                            Medium Dent
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDents-Large-iOS26", alt: "Large Dents (Almost Full-Screen)") {
                            Large / Default Dents
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                For iOS 18 and earlier, sheets have a lower corner radius, resulting in a softer, rounded appearance that aligns with older iOS aesthetics. The `.large` detent provides a near full-screen presentation for comprehensive content, while `.medium` offers a mid-sized card for concise interactions, maintaining usability across legacy designs.
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
        On iPadOS, the `presentationDents(dents:)` option enables tailored sheet presentations on iPad’s larger screens, optimizing layouts for diverse use cases like multitasking or detailed forms. The `.large` detent creates a prominent card for extensive content, while `.medium` offers a mid-sized card for quick interactions, enhancing usability in Split View or Slide Over. The corner radius varies by iPadOS version, affecting the sheet’s visual integration with the app.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, sheets feature a higher corner radius, providing a sleek, modern look that complements the iPad’s expansive display. The `.large` detent is ideal for detailed content like forms or tutorials, while `.medium` supports compact layouts for alerts or settings, ensuring flexibility in design.
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
            @Tab("iPadOS 18 and Older") {
                For iPadOS 18 and earlier, sheets have a lower corner radius, giving a softer, rounded appearance consistent with legacy iPad aesthetics. The `.large` detent delivers a prominent card for comprehensive content, while `.medium` provides a mid-sized option for concise interactions, maintaining functionality across older designs.
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
- ``SKSheet``
- ``SKPage``
- ``SwiftUICore/EnvironmentValues/skSheetStyleDents``
