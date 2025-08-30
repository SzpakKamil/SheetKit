# ``SheetKit/SKSheetOptions/isHandoffEnabled(_:)``

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

An option to enable handoff functionality for a sheet, allowing it to trigger actions and be transferred to another device.

## Overview

The ``SKSheetOptions/isHandoffEnabled(_:)`` option enables handoff support for a sheet in the `SheetKit` framework, facilitating the transfer of the sheet's state and actions to another compatible Apple device (e.g., from iOS to macOS) when the user switches devices. This option is part of the ``SKSheetOptions`` set used within the ``SKSheetable`` protocol and is applied to sheets conforming to it. When set to `true`, it allows the sheet to participate in the Handoff ecosystem, ensuring a seamless user experience across all platforms. The default value is `false`, meaning handoff is disabled unless explicitly enabled.

## Example

The following example demonstrates how to enable handoff for a sheet using the ``SKSheetOptions/isHandoffEnabled(_:)`` option within a custom `SKSheet` implementation:

```swift
import SwiftUI
import SheetKit

struct ExampleSheet: SKSheet {
    var id: String = "Example Sheet"
    var options: Set<SKSheetOptions> = [.isHandoffEnabled(true)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "arrow.up.right.square")
            SKTitle("Handoff Example")
            SKDescription("This sheet can be transferred to another device.")
        }
    }
    
    func sentData() -> [AnyHashable : Any] {
        // To Do
        return [:]
    }
    
    func loadData(sentData: [AnyHashable : Any]) {
        // To Do
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager

    var body: some View {
        Button("Show Sheet") {
            sheetManager.show(sheet: ExampleSheet.self)
        }
    }
}
```

In this example, the `ExampleSheet` struct conforms to `SKSheet` and sets `.isHandoffEnabled(true)` in its `options` property, enabling the sheet to be transferred to another device. The `pages` property defines a single `SKPage` with a header image, title, and description. The ``SKSheetable/sentData()`` and ``SKSheetable/loadData(sentData:)`` methods are included to handle data transfer during handoff (to be implemented). The `ContentView` uses ``SKSheetManager/show(sheet:)-3u5l1`` to display the sheet, leveraging the `id` defined in `ExampleSheet`. When the user initiates a handoff (e.g., via the Continuity feature), the sheet's state is preserved and resumed on the target device.

## Additional Required Configuration

>Warning: Failure to add the `NSUserActivityTypes` entry with the correct ``handoffActivityType`` string in `Info.plist` and configurate `Scene` properly  will prevent handoff functionality from working properly.

The `ExampleSheet` must be specified in the ``SwiftUICore/View/skSheetManager(sheets:handoffActivityType:)`` modifier within the app's `Scene` configuration, and a `handoffActivityType` must be provided. For example:

```swift
@main
struct AboutSheetKitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(sheets: ExampleSheet.self, handoffActivityType: "SKSheetManagerHandoffActivity")
        }
    }
}
```



Add `Info.plist` file includes the following key to enable handoff:

```xml
<key>NSUserActivityTypes</key>
<array>
    <string>SKSheetManagerHandoffActivity</string>
</array>
```

## See Also

- ``SKSheetOptions``
- ``SKSheetable``
- ``SKSheet``
