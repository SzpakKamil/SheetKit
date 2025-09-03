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

An option to disable interactive dismissal gestures or actions for sheets in the `SheetKit` framework, enhancing control over user interactions with sheets conforming to the ``SKSheetable`` protocol.

## Overview

The ``SKSheetOptions/interactiveDismissDisabled(_:)`` option provides developers with the ability to prevent users from dismissing a sheet through interactive gestures or standard keyboard shortcuts. This is particularly useful in scenarios where the sheet contains critical information, forms requiring completion, or multi-step workflows that must be followed in sequence. When enabled, this option disables the default dismissal mechanisms: a swipe-down gesture on iOS and iPadOS, the escape key on macOS, and similar platform-specific interactions. On platforms where interactive dismissal is not applicable (e.g., tvOS, watchOS, visionOS), this option has no effect unless future updates introduce new dismissal behaviors.

This option accepts a Boolean value (`true` to disable interactive dismissal, `false` to allow it), offering fine-grained control over the sheet's behavior. By default, interactive dismissal is enabled, allowing users to dismiss sheets naturally. However, setting ``interactiveDismissDisabled(_:)`` to `true` ensures that the sheet remains on-screen until an explicit action (e.g., a button tap) is performed, which can be defined within the sheet's content or through custom logic.

The primary use case for this option is to enforce user engagement with the sheet's content. For example, in a settings panel requiring confirmation, a form needing validation, or a tutorial that must be fully viewed, disabling interactive dismissal prevents accidental closure and guides the user through the intended flow. This option integrates seamlessly with other `SheetKit` features, such as ``SKSheetOptions/alignment(_:)`` and ``SKSheetOptions/style(_:)``, allowing developers to create a cohesive and controlled user experience.

### Platform-Specific Behavior

- **iOS and iPadOS**: Disables the swipe-down gesture that typically dismisses a sheet. This is especially relevant for larger screens (e.g., iPadOS) where multi-tasking might lead to unintended dismissals.
- **macOS**: Disables the escape key as a dismissal trigger, ensuring the sheet persists until an explicit action is taken.
- **tvOS**: Has no effect, as tvOS sheets are typically dismissed via remote control actions (e.g., menu button), which are not considered interactive dismissals.
- **watchOS**: Has no effect, as watchOS sheets are dismissed through specific interface actions rather than gestures or keys.
- **visionOS**: Has no effect currently, though future updates might introduce spatial gestures that could be controlled by this option.

>Important: It is recommended to use this option with ``SKSheetOptions/hideCloseButton(_:)`` to maintain a consistent user experience when disabling interactive dismissal.

## Example

The following examples demonstrate the use of ``SKSheetOptions/interactiveDismissDisabled(_:)`` with sheets containing only `SKHeaderImage`, `SKTitle`, and `SKDescription`. One example enables interactive dismissal, while the other disables it, showing the difference in behavior. A `ContentView` is provided to test the sheets interactively within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct InteractiveDismissEnabledSheet: SKSheet {
    var id: String = "InteractiveDismissEnabledSheet"
    var options: Set<SKSheetOptions> = [.alignment(.leading), .style(.default)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "checkmark.circle.fill")
            SKTitle("Dismissible Sheet")
            SKDescription("This sheet can be dismissed with a swipe down gesture or escape key. Feel free to explore!")
        }
    }
}

struct InteractiveDismissDisabledSheet: SKSheet {
    var id: String = "InteractiveDismissDisabledSheet"
    var options: Set<SKSheetOptions> = [.interactiveDismissDisabled(true), .alignment(.leading), .style(.default)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "lock.circle.fill")
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

In these examples, `InteractiveDismissEnabledSheet` uses default settings (no `.interactiveDismissDisabled(true)`), allowing swipe-down (iOS/iPadOS) or escape key (macOS) dismissal, with a checkmark icon indicating its dismissible nature. `InteractiveDismissDisabledSheet` uses `.interactiveDismissDisabled(true)` to prevent interactive dismissal, featuring a lock icon to signify its non-dismissible state, with a note about requiring an explicit close mechanism (e.g., a button, though not implemented here as per your request to focus on the core components). The `ContentView` enables testing of both sheets, highlighting the persistent nature of the disabled sheet.
