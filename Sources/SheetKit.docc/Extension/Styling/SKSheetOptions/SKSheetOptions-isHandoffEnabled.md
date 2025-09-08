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

Enables handoff functionality for a sheet, allowing its state and actions to be transferred to another Apple device.

## Overview

The `SKSheetOptions/isHandoffEnabled(_:)` option enables handoff support within the `SheetKit` framework, allowing a sheet’s state and actions to be seamlessly transferred across compatible Apple devices (e.g., from an iPhone to a Mac) via Apple’s Continuity feature. This option, part of the `SKSheetOptions` set, is applied to sheets conforming to the `SKSheetable` protocol. When set to `true`, it integrates the sheet into the Handoff ecosystem, ensuring a fluid user experience across platforms. By default, handoff is disabled (`false`), requiring explicit activation to enable this functionality.

This option is particularly valuable for apps aiming to provide a consistent experience across Apple’s ecosystem, allowing users to start an action on one device and continue it on another. It integrates with other `SheetKit` features, such as `SKSheetOptions/alignment(_:)` and `SKSheetOptions/style(_:)`, to maintain a cohesive design while supporting cross-device continuity.

### Platform-Specific Behavior

- **iOS/iPadOS/macOS/watchOS/visionOS**: Supports handoff when enabled, requiring `NSUserActivityTypes` in `Info.plist` and proper `Scene` configuration.
- **tvOS**: Supports handoff, but practical use is limited due to full-screen presentation and remote-based navigation.

## Example

The following example demonstrates how to enable handoff for a sheet using the `SKSheetOptions/isHandoffEnabled(_:)` option within a custom `SKSheet` implementation:

```swift
import SwiftUI
import SheetKit

struct ExampleSheet: SKSheet {
    var id: String = "ExampleSheet"
    var options: Set<SKSheetOptions> = [.isHandoffEnabled(true)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "arrow.up.right.square")
            SKTitle("Handoff Example")
            SKDescription("This sheet can be transferred to another device.")
        }
    }
    
    func sentData() -> [AnyHashable: Any] {
        // To Do: Implement data to send during handoff
        return [:]
    }
    
    func loadData(sentData: [AnyHashable: Any]) {
        // To Do: Implement data loading for handoff
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

In this example, the `ExampleSheet` struct conforms to `SKSheet` and enables handoff with `.isHandoffEnabled(true)` in its `options` property. The `pages` property defines a single `SKPage` with a header image, title, and description. The `sentData()` and `loadData(sentData:)` methods are placeholders for handling data transfer during handoff. The `ContentView` uses `SKSheetManager/show(sheet:)` to display the sheet, leveraging the `id` defined in `ExampleSheet`. When handoff is initiated (e.g., via Continuity), the sheet’s state is preserved and resumed on the target device.

## Additional Required Configuration

> Warning: Handoff functionality requires the `NSUserActivityTypes` entry with the correct `handoffActivityType` string in `Info.plist` and proper `Scene` configuration, or it will not work.

The `ExampleSheet` must be specified in the `SwiftUICore/View/skSheetManager(sheets:handoffActivityType:)` modifier within the app’s `Scene` configuration, with a `handoffActivityType` provided. For example:

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

The `Info.plist` file must include the following key to enable handoff:

```xml
<key>NSUserActivityTypes</key>
<array>
    <string>SKSheetManagerHandoffActivity</string>
</array>
```

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `isHandoffEnabled` option integrates sheets into Apple’s Handoff ecosystem, allowing users to seamlessly transfer a sheet’s state from an iPhone to another compatible device, such as an iPad or Mac. This functionality is particularly useful for apps with interactive or data-driven sheets, enabling users to continue tasks like form editing or content viewing without interruption. Proper configuration, including `Info.plist` entries and `Scene` setup, is critical to ensure a smooth handoff experience tailored to iOS’s touch-driven interface.
    }
    @Tab("iPadOS") {
        On iPadOS, `isHandoffEnabled` enables sheets to be transferred to other Apple devices, leveraging the larger screen real estate to maintain a consistent user experience. This is ideal for productivity apps where users might start a task on an iPad and continue on a Mac or iPhone. The option ensures that sheet content, such as forms or informational displays, remains accessible across devices, with proper configuration ensuring reliable state transfer in iPadOS’s multitasking environment.
    }
    @Tab("macOS") {
        On macOS, `isHandoffEnabled` allows sheets to participate in the Handoff ecosystem, enabling users to transfer sheet interactions from a Mac to an iPhone, iPad, or other compatible device. This is particularly effective for desktop workflows involving detailed sheet content, such as settings panels or data entry forms, ensuring continuity across Apple’s ecosystem. Proper setup of `NSUserActivityTypes` and `Scene` configuration is essential for seamless operation on macOS’s window-based interface.
    }
    @Tab("watchOS") {
        On watchOS, `isHandoffEnabled` supports transferring sheet states to other Apple devices, despite the compact nature of watchOS interfaces. This allows users to initiate quick interactions on an Apple Watch, such as viewing a notification or starting a form, and continue on a larger device like an iPhone or iPad. The option is optimized for watchOS’s glanceable displays, requiring careful configuration to ensure efficient data transfer within the constrained environment.
    }
    @Tab("visionOS") {
        On visionOS, `isHandoffEnabled` enables sheets to be transferred across Apple devices, supporting continuity in immersive mixed reality environments. This allows users to start interacting with a sheet in a 3D space and seamlessly continue on an iPhone, iPad, or Mac. The option ensures that sheet content remains consistent across platforms, with proper configuration critical for maintaining state in visionOS’s unique spatial interface.
    }
    @Tab("tvOS") {
        On tvOS, `isHandoffEnabled` supports handoff functionality, though its practical use is limited due to the full-screen, remote-based nature of tvOS interfaces. This option allows sheets to transfer their state to other devices, such as an iPhone or iPad, enabling users to continue tasks started on a television. Configuration of `NSUserActivityTypes` and `Scene` is necessary to ensure compatibility, despite the less frequent use case on tvOS.
    }
}

## See Also

- ``SKSheetOptions``
- ``SKSheetable``
- ``SKSheet``
- ``SwiftUICore/View/skSheetManager(sheets:handoffActivityType:)``
