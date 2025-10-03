# ``SheetKit/SKSheetOptions/interactiveDismissDisabled(_:)``

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

Disables interactive dismissal gestures or actions for sheets, ensuring controlled user interactions in the `SheetKit` framework.

## Overview

The `interactiveDismissDisabled(_:)` option enables developers to prevent users from dismissing a sheet through interactive gestures or standard keyboard shortcuts, enhancing control over user interactions for sheets conforming to the `SKSheetable` protocol. When set to `true`, this option disables platform-specific dismissal mechanisms, such as swipe-down gestures on iOS and iPadOS or the escape key on macOS, ensuring the sheet remains on-screen until an explicit action (e.g., a button tap) is taken. When set to `false` (the default), interactive dismissal is enabled, allowing natural dismissal behaviors.

This option is ideal for scenarios requiring user engagement, such as critical alerts, mandatory forms, or sequential tutorials, where accidental dismissal could disrupt the intended flow. On platforms like tvOS, watchOS, and visionOS, where interactive dismissal is not typically applicable, this option has no effect unless future updates introduce new dismissal behaviors.

### Platform-Specific Behavior

- **iOS/iPadOS**: Disables swipe-down gesture dismissal.
- **macOS**: Disables escape key dismissal.
- **tvOS/watchOS/visionOS**: No effect, as interactive dismissal is not applicable.

> Important: Use with ``SKSheetOptions/hideCloseButton(_:)`` for a consistent user experience when disabling interactive dismissal.

## Example

The following examples demonstrate `SKSheetOptions/interactiveDismissDisabled(_:)` with sheets containing `SKHeaderImage`, `SKTitle`, and `SKDescription`. One example allows interactive dismissal, while the other disables it, illustrating the behavioral difference. A `ContentView` enables interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct InteractiveDismissEnabledSheet: SKSheet {
    var id: String = "InteractiveDismissEnabledSheet"
    var options: Set<SKSheetOptions> = []
    
    var pages: [any SKPageable] {
        SKPage {
            SKHeaderImage(systemName: "lock.open.fill")
            SKTitle("Dismissible Sheet")
            SKDescription("This sheet can be dismissed with a swipe-down gesture or escape key. Feel free to explore!")
        }
    }
}

struct InteractiveDismissDisabledSheet: SKSheet {
    var id: String = "InteractiveDismissDisabledSheet"
    var options: Set<SKSheetOptions> = [.interactiveDismissDisabled(true)]
    
    var pages: [any SKPageable] {
        SKPage {
            SKHeaderImage(systemName: "lock.fill")
            SKTitle("Non-Dismissible Sheet")
            SKDescription("This sheet cannot be dismissed interactively. Use a button to close it (not implemented here).")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Dismissible Sheet") {
                sheetManager.show(sheet: InteractiveDismissEnabledSheet.self)
            }
            Button("Show Non-Dismissible Sheet") {
                sheetManager.show(sheet: InteractiveDismissDisabledSheet.self)
            }
        }
        .padding()
    }
}

@main
struct ExampleDismissApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(.init())
        }
    }
}
```

In these examples, `InteractiveDismissEnabledSheet` uses default settings, allowing swipe-down (iOS/iPadOS) or escape key (macOS) dismissal, with an open lock icon indicating its dismissible nature. `InteractiveDismissDisabledSheet` uses `.interactiveDismissDisabled(true)` to prevent interactive dismissal, featuring a lock icon to signify its persistence, with a note about requiring an explicit close mechanism (not implemented here). The `ContentView` facilitates testing both sheets, showcasing the non-dismissible behavior.

## See Also

- ``SKSheetOptions``
- ``SKSheetable``
- ``SKPage``
- ``SwiftUICore/EnvironmentValues/skSheetInteractiveDismissDisabled``
