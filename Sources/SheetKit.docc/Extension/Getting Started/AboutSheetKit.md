# About SheetKit

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
    @DocumentationExtension(mergeBehavior: override)
    @PageImage(purpose: card, source: "SheetKitGreeting")
}

@Options {
    @AutomaticTitleHeading(enabled)
    @AutomaticSeeAlso(disabled)
    @AutomaticArticleSubheading(disabled)
}

Learn about the customizable SwiftUI **SheetKit** package for creating polished, native-looking sheets across **all Apple platforms** with the same code.

## Overview

Apple’s built-in sheets provide a solid foundation, but making them feel **polished, consistent, and production-ready** often requires significant manual effort. **SheetKit** streamlines this process with a **multiplatform, declarative API** that feels like a natural extension of SwiftUI.

With **one codebase**, SheetKit runs seamlessly on **iOS, iPadOS, macOS, visionOS, watchOS, and tvOS**. Whether you’re designing onboarding flows, interactive forms, or feature highlights, SheetKit ensures a unified, native-like experience across platforms.

Key features include **automatic style detection**, **handoff support** for device continuity, **environment-based customization**, and a full library of reusable sheet components.

### Multiplatform & Backwards Compatible

SheetKit ensures reliable cross-platform behavior with:

* **Universal Support** – Same sheet code runs on iOS, iPadOS, macOS, visionOS, watchOS, and tvOS.
* **Backwards Compatibility** – Adapts appearance automatically for OS versions up to three years back.
* **Automatic Style Detection** – Dynamically adjusts styling for forms, toolbars, and modal contexts.

### Accessibility & Continuity

SheetKit is designed for inclusivity and smooth transitions:

* **Accessibility Support** – Integrates with SwiftUI’s accessibility APIs, including VoiceOver and Dynamic Type.
* **Handoff Support** – Transfer open sheets and their content seamlessly between devices.

## Why Use SheetKit?

The **SheetKit** package extends SwiftUI’s capabilities with:

* **Unified API** – Write once, run everywhere across six platforms.
* **Custom Components** – Titles, descriptions, highlights, forms, pickers, toolbars, and more.
* **Environment Modifiers** – Configure behavior globally and declaratively.
* **Native Styling** – Automatically adapts to platform look and feel.
* **Reliable Foundation** – Unit tested for stability and consistency.
* **Lightweight Design** – Minimal dependencies, integrated via Swift Package Manager.

These features make SheetKit ideal for apps requiring **beautiful, interactive, and consistent sheet experiences**.

## Core Components

SheetKit includes a wide set of building blocks to compose sheets:

* **Layout & Containers**: ``SKPage``, ``SKPageBuilder``, ``SKScrollView``, ``SKSheetView``, ``SKSheetDisplayView``
* **Text & Media**: ``SKTitle``, ``SKDescription``, ``SKHeaderImage``, ``SKHighlight``
* **Form Elements**: ``SKTextField``, ``SKDatePicker``, ``SKStepper``, ``SKPicker``
* **Buttons & Styles**: ``SKButton``, ``SKPrimaryButtonStyle``, ``SKSecondaryButtonStyle``, ``SKNavigationButtonStyle``, ``SKNoteButtonStyle``
* **Toolbars**: ``SKToolbar``, ``SKToolbarItem``, ``SKToolbarBuilder``

For advanced configuration, see:

* **Classes**: ``SKSheetManager``, ``SKSheetDisplayWrapper``
* **Protocols**: ``SKSheet``, ``SKCustomViewSheet``, ``SKComponent``
* **Enumerations**: ``SKSheetOptions``, ``SKSheetStyle``, ``SKComponentType``, ``SKRenderingMode``, ``SKToolbarItemActionType``, ``SKToolbarItemPlacement``

## Example

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        Button("Show About Sheet") {
            sheetManager.show(id: "AboutSheet") {
                AboutSheet()
            }
        }
    }
}
```

## Target Use Cases

The **SheetKit** package is ideal for:

* **Onboarding** – Build guided, multi-page sheet flows.
* **Interactive Forms** – Collect user input with text fields, pickers, and steppers.
* **Feature Highlights** – Present product updates or guided tours with styled pages.
* **Cross-Platform Apps** – Same sheet code runs across all six Apple platforms.
* **Accessible Interfaces** – Full support for VoiceOver and Dynamic Type.

## Next Steps

* Learn integration basics in <doc:SetUp>.
* Explore sheet customization in <doc:Modifiers>.
* Follow step-by-step guidance in <doc:SheetKitTutorial>.
* Try a hands-on sample with <doc:AboutSheet>.
