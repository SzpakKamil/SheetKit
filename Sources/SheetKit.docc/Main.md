# ``SheetKit``

Native, Customizable Sheet Builder with Modular Components

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
    @PageColor(blue)
    @DocumentationExtension(mergeBehavior: override)
}

@Options {
    @AutomaticTitleHeading(enabled)
    @AutomaticSeeAlso(disabled)
    @AutomaticArticleSubheading(disabled)
}

## Overview

SheetKit is a SwiftUI-based package that empowers developers to create customizable, modular sheets across all Apple platforms—iOS, iPadOS, watchOS, macOS, tvOS, and visionOS. Built from the ground up, it provides a robust framework with a custom `SheetManager` for intuitive sheet hierarchy management using simple `add`, `show`, and `hide` functions. Key features include seamless Handoff for transferring sheets between devices, robust save/load data capabilities, VoiceOver accessibility with descriptive labels, and Dynamic Type support. This modular, reusable solution ensures a native-looking, future-proof interface for onboarding flows, interactive forms, and custom modals.

@Image(source: "SheetKit-Tutorial-Banner.png", alt: "SheetKit sheet on iPhone, Mac, iPad, Apple TV, Vision Pro, and Apple Watch.")

Whether you're designing onboarding experiences, interactive forms, or tailored modals, SheetKit offers a flexible API to craft polished, platform-native sheets. Its multiplatform compatibility and extensive customization options allow you to adapt every element to your app’s aesthetic. With built-in Handoff and backwards compatibility for older system versions, SheetKit combines versatility with reliability, making integration into SwiftUI projects seamless and efficient.

## Getting Started

@Links(visualStyle: detailedGrid) {
    - <doc:AboutSheetKit>
    - <doc:SetUp>
}

## Resources

@Links(visualStyle: detailedGrid) {
    - <doc:Modifiers>
}

## Sample Projects

@Links(visualStyle: detailedGrid) {
    - <doc:AboutApp>
}

## Topics

### Essentials
- <doc:AboutSheetKit>
- <doc:SetUp>
- <doc:SheetKitTutorial>
- <doc:Modifiers>

### Sample Projects
- <doc:AboutApp>

### Page Components
- ``SKHeaderImage``
- ``SKTitle``
- ``SKDescription``
- ``SKHighlight``
- ``SKTextField``
- ``SKPicker``
- ``SKDatePicker``
- ``SKStepper``
- ``SKCustomView``
- ``SKForEach``
- ``SKComponent``
- ``SKComponentType``
- ``SwiftUICore/View/asComponent``
- ``SwiftUICore/View/pickerTag(_:)``

### Protocols
- ``SKSheet``
- ``SKCustomViewSheet``

### Sheet Components
- ``SKPage``
- ``SKToolbar``
- ``SKSheetView``
- ``SKForEach``

### Toolbar Components
- ``SKButton``
- ``SKToolbarItem``
- ``SKToolbarItemPlacement``
- ``SKToolbarItemActionType``

### Managers
- ``SKSheetManager``
- ``SwiftUICore/View/skSheetManager(_:handoffActivityType:)``

### Builders
- ``SKPageBuilder``
- ``SKSheetBuilder``
- ``SKToolbarBuilder``

### Button Styles
- ``SKPrimaryButtonStyle``
- ``SKSecondaryButtonStyle``
- ``SKNoteButtonStyle``
- ``SKNavigationButtonStyle``

### Styling
- ``SKSheetStyle``
- ``SKRenderingMode``
- ``SKSheetStyle``
- ``SKSheetOptions``

### Environment Values
- ``SwiftUICore/EnvironmentValues/skAccentColor``
- ``SwiftUICore/EnvironmentValues/skAlignment``
- ``SwiftUICore/EnvironmentValues/skRowShape``
- ``SwiftUICore/EnvironmentValues/skRowSpacing``
- ``SwiftUICore/EnvironmentValues/skSheetStyle``
- ``SwiftUICore/EnvironmentValues/skAccentColor``
- ``SwiftUICore/EnvironmentValues/skPrimaryColor``
- ``SwiftUICore/EnvironmentValues/skSheetManager``
- ``SwiftUICore/EnvironmentValues/skSecondaryColor``
- ``SwiftUICore/EnvironmentValues/skToolbarPlacement``
- ``SwiftUICore/EnvironmentValues/skIsFinalPage``
- ``SwiftUICore/EnvironmentValues/skIsInSection``
- ``SwiftUICore/EnvironmentValues/skSheetStyleDents``
- ``SwiftUICore/EnvironmentValues/skCloseButtonAction``
- ``SwiftUICore/EnvironmentValues/skRowBackgroundColor``
- ``SwiftUICore/EnvironmentValues/skDismissButtonAction``
- ``SwiftUICore/EnvironmentValues/skPrimaryButtonAction``
- ``SwiftUICore/EnvironmentValues/skToolbarButtonAction``
- ``SwiftUICore/EnvironmentValues/skIsCloseButtonHidden``
- ``SwiftUICore/EnvironmentValues/skIsShowingBackButton``
- ``SwiftUICore/EnvironmentValues/skIsContinueButtonHidden``
- ``SwiftUICore/EnvironmentValues/skSheetStyleDentsSelection``
- ``SwiftUICore/EnvironmentValues/skSheetDragIndicatorVisibility``
- ``SwiftUICore/EnvironmentValues/skSheetInteractiveDismissDisabled``
