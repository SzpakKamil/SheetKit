# ``SheetKit/SKSheetOptions``

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

A set of configuration options for customizing the behavior and appearance of sheets in the `SheetKit` framework, used within the `SKSheetable` protocol.

## Overview

The ``SKSheetOptions`` type defines a collection of options that control various aspects of sheet presentation and styling in the `SheetKit` framework. These options are applied as a `Set<SKSheetOptions>` within the `SKSheetable` protocol, allowing developers to configure sheets (e.g., `SKSheetView`) with settings such as handoff support, button visibility, dismissal behavior, and visual properties like colors and alignment. The options are designed to work seamlessly across Apple platforms (iOS, iPadOS, macOS, watchOS, tvOS, visionOS), adapting to the system’s appearance and maintaining consistency with the native design language.

## Options

| Option                  | Type                          | Default Value         | Description                                      |
|--------------------------|-------------------------------|-----------------------|--------------------------------------------------|
| `isHandoffEnabled`       | `Bool`                        | `false`               | Enables or disables handoff support for the sheet. |
| `hideCloseButton`        | `Bool`                        | `true`                | Hides or shows the close button.                 |
| `interactiveDismissDisabled` | `Bool`                  | `true`                | Disables or enables interactive swipe-to-dismiss. |
| `style`                  | `SKSheetStyle`                | `.default`            | Sets the sheet’s presentation style.             |
| `presentationDents`      | `(dents: Set<PresentationDetent>, selection: Binding<PresentationDetent>?)` | `nil` for selection | Configures detents and their selection binding.  |
| `accentColor`            | `Color`                       | `.accentColor`        | Sets the accent color for the sheet.             |
| `alignment`              | `HorizontalAlignment?`        | `nil`                 | Configures horizontal alignment.                 |
| `rowBackground`          | `Color?`                      | `nil`                 | Applies a background color to rows.              |
| `rowShape`               | `(cornerRadius: CGFloat?)`    | `nil`                 | Sets the corner radius for row shapes.           |
| `rowSpacing`             | `(spacing: CGFloat?)`         | `nil`                 | Adjusts vertical spacing between rows.           |
| `primaryTextColor`       | `Color?`                      | `nil`                 | Sets the primary text color.                     |
| `secondaryTextColor`     | `Color?`                      | `nil`                 | Sets the secondary text color.                   |
| `hideContinueButton`     | `Bool`                        | `true`                | Hides or shows the continue button.              |
| `isFullScreenCover`      | `Bool`                        | `true`                | On iOS, iPadOS, and tvOS, changes the sheet presentation from a card-style to a full-screen cover. Ignored on macOS, watchOS, and visionOS. |

## Example

The following example demonstrates how to use ``SKSheetOptions`` to configure an ``SKSheetView`` with a full-screen presentation on iOS, iPadOS, or tvOS:

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        Button("Show Full-Screen Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView(options: [.isFullScreenCover(true), .hideCloseButton(false)]) {
                    SKPage {
                        SKHeaderImage(systemName: "camera")
                        SKTitle("Full-Screen Sheet")
                        Text("This sheet is presented in full-screen mode.")
                    }
                }
            }
        }
    }
}
```

In this example, the ``SKSheetView`` is configured with the `.isFullScreenCover(true)` option, which changes the presentation to a full-screen cover on iOS, iPadOS, or tvOS, and the `.hideCloseButton(false)` option to ensure the close button remains visible. The ``SKSheetManager/show(id:view:)`` method presents the sheet with the specified configuration.

## See Also

- ``SKSheetable``
- ``SKSheetView``
- ``SKPage``
