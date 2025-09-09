# ``SheetKit/SKSheetOptions/presentationDragIndicator(_:)``

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

Controls the visibility of the drag indicator for sheets, enabling or disabling user interaction for adjusting sheet position on iPhone and iPad.

## Overview

The `presentationDragIndicator(_:)` option in the `SheetKit` framework customizes the visibility of the drag indicator for sheets conforming to the `SKSheetable` protocol, such as `SKSheet` or custom implementations. Available exclusively on iPhone and iPad, this option accepts a `PresentationDragIndicator` value: `.visible` displays a drag indicator to signal that users can interact with and adjust the sheet’s position, while `.hidden` removes the indicator for a cleaner appearance, disabling drag-based adjustments.

The drag indicator, when visible, appears as a small handle at the top of the sheet, providing a visual cue for users to drag and reposition the sheet, often in conjunction with detents set by `SKSheetOptions/presentationDents(dents:)`. This option is particularly useful for enhancing user interaction in modal interfaces or maintaining a minimalist design by hiding the indicator. On platforms other than iOS and iPadOS (e.g., macOS, tvOS, watchOS, visionOS), this option is ignored due to their distinct presentation models.

### Platform-Specific Behavior

- **iPhone/iPadOS**: Supports `.visible` (displays drag indicator for interactive positioning) or `.hidden` (removes drag indicator for a cleaner look). Styling aligns with system design, with minor variations by OS version.
- **macOS/tvOS/watchOS/visionOS**: Ignored due to platform-specific sheet presentation mechanics.

> Note: Recomended to be used with ``presentationDents(dents:)``

## Example

The following examples demonstrate `SKSheetOptions/presentationDragIndicator(_:)` with sheets containing ``SKHeaderImage``, ``SKTitle``, and ``SKDescription``. One example uses a visible drag indicator, and another uses a hidden drag indicator, showcasing the behavior on iPhone and iPad.

```swift
import SwiftUI
import SheetKit

struct VisibleDragIndicator: SKSheet {
    var id: String = "VisibleDragIndicator"
    var options: Set<SKSheetOptions> = [.presentationDragIndicator(.visible)]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "list.clipboard.fill")
            SKTitle("Visible Drag Indicator")
            SKDescription("This sheet displays a visible drag indicator, allowing users to interact with and adjust the sheet's position on iPhone and iPad.")
        }
    }
}

struct HiddenDragIndicator: SKSheet {
    var id: String = "HiddenDragIndicator"
    var options: Set<SKSheetOptions> = [.presentationDragIndicator(.hidden)]
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "list.clipboard.fill")
            SKTitle("Hidden Drag Indicator")
            SKDescription("This sheet hides the drag indicator, providing a cleaner appearance without interactive drag functionality on iPhone and iPad.")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Visible Drag Indicator Sheet") {
                sheetManager.show(sheet: VisibleDragIndicator.self)
            }
            Button("Show Hidden Drag Indicator Sheet") {
                sheetManager.show(sheet: HiddenDragIndicator.self)
            }
        }
        .padding()
    }
}

@main
struct DragIndicatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(sheets: VisibleDragIndicator.self, HiddenDragIndicator.self)
        }
    }
}
```

In these examples, `VisibleDragIndicator` uses `.presentationDragIndicator(.visible)` to display a drag indicator, enabling users to adjust the sheet’s position on iPhone and iPad. `HiddenDragIndicator` uses `.presentationDragIndicator(.hidden)` to hide the indicator, creating a cleaner look without drag functionality. The `ContentView` enables interactive testing of these configurations.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `presentationDragIndicator(_:)` option controls the visibility of the drag indicator on iPhone, enhancing user interaction by signaling when a sheet can be dragged to adjust its position. The `.visible` setting displays a handle that invites users to interact with the sheet, ideal for dynamic interfaces like settings or forms, while `.hidden` provides a streamlined appearance for static content like alerts or informational displays. The indicator’s styling aligns with iOS design guidelines, ensuring a cohesive look across different screen sizes and orientations.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDragIndicator-Visible-iOS26", alt: "Visible Drag Indicator") {
                    Visible Drag Indicator
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDragIndicator-Hidden-iOS26", alt: "Hidden Drag Indicator") {
                    Hidden Drag Indicator
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the `presentationDragIndicator(_:)` option customizes the drag indicator’s visibility on iPad, optimizing interaction for larger screens and multitasking scenarios like Split View or Slide Over. The `.visible` setting enables users to drag and reposition sheets, enhancing flexibility for complex layouts or interactive forms, while `.hidden` ensures a clean, distraction-free presentation for static content. The indicator integrates with iPadOS’s design language, maintaining visual consistency across various display sizes and input methods.
        @Row(numberOfColumns: 2) {
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDragIndicator-Visible-iOS26", alt: "Visible Drag Indicator") {
                    Visible Drag Indicator
                }
            }
            @Column(size: 1) {
                @Image(source: "Documentation-Styling-SKSheetOptions-PresentationDragIndicator-Hidden-iOS26", alt: "Hidden Drag Indicator") {
                    Hidden Drag Indicator
                }
            }
        }
    }
}

## See Also

- ``SKSheetOptions``
- ``SKSheetOptions/presentationDents(dents:)``
- ``SKSheetable``
- ``SKSheet``
- ``SKPage``
