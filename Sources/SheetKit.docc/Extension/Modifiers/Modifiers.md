# Modifiers

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
    @PageImage(purpose: card, source: "SheetKitModifiers")
}

@Options {
    @AutomaticSeeAlso(disabled)
}

Learn about the modifiers available for customizing **SheetKit** components in SwiftUI.

## Overview

SheetKit provides a rich set of modifiers to control the appearance and behavior of sheets, pages, and individual components. These modifiers integrate seamlessly with SwiftUI’s environment system and dot-syntax, letting you configure colors, alignment, spacing, shapes, sheet styles, and more with minimal code. For buttons, the `.skButtonStyle(_:)` modifier allows developers to apply specific styles (e.g., `.primary`, `.secondary`, `.navigation`, or `.note`) directly to an `SKButton`, offering a convenient way to style buttons without relying on `SKToolbarItem` placement or manual `.buttonStyle` application. This ensures consistent styling across platforms, aligning with the native design language and enhancing usability.

Modifiers are available on:  
- ``SKComponent`` – fine-grained control over fields, titles, and highlights.  
- ``SKPage`` – page-level customization such as colors, alerts, and navigation buttons.  
- ``SKCustomView`` – additional customisation for custom view page  
- ``SKSheetView`` – sheet-level configuration including style, detents, and dismissal behavior.  
- Specialized components (``SKTitle``, ``SKHeaderImage``, ``SKDescription``, ``SKButton``) – additional font, style, weight, and layout controls.  

## Modifiers

### SKComponent Modifiers
- ``SKComponent/skAccentColor(_:)`` – Sets the accent color.  
- ``SKComponent/skAlignment(_:)`` – Configures horizontal alignment.  
- ``SKComponent/skRowBackground(_:)`` – Adds a background color to a row.  
- ``SKComponent/skRowShape(cornerRadius:)`` – Applies corner radius to row shapes.  
- ``SKComponent/skRowSpacing(_:)`` – Adjusts vertical spacing between rows.  
- ``SKComponent/skPrimaryTextColor(_:)`` – Sets the primary text color.  
- ``SKComponent/skSecondaryTextColor(_:)`` – Sets the secondary text color.  

#### Event handlers
- ``SKComponent/onAppear(perform:)``
- ``SKComponent/onChange(of:initial:_:)-(_,_,()->Void)``
- ``SKComponent/onReceive(_:perform:)``
- ``SKComponent/task(priority:_:)``  

### SKPage Modifiers
- ``SKPage/skAccentColor(_:)``  
- ``SKPage/skAlignment(_:)``  
- ``SKPage/skRowBackground(_:)``  
- ``SKPage/skRowShape(cornerRadius:)``  
- ``SKPage/skRowSpacing(_:)``  
- ``SKPage/skPrimaryTextColor(_:)``  
- ``SKPage/skSecondaryTextColor(_:)``  
- ``SKPage/skIgnoreSafeArea(_:)``  
- ``SKPage/skHideCloseButton(_:)`` – Hides or shows the close button.  
- ``SKPage/skHideContinueButton(_:)`` – Hides or shows the continue button.  
- ``SKPage/skAlert(isPresented:title:description:type:content:)`` – Presents an alert bound to a condition.  
- ``SKPage/skStyle(_:)`` – Configures the background style of the page.  

### SKSheetView Modifiers
- ``SKSheetView/skAccentColor(_:)``  
- ``SKSheetView/skAlignment(_:)``  
- ``SKSheetView/skRowBackground(_:)``  
- ``SKSheetView/skRowShape(cornerRadius:)``  
- ``SKSheetView/skRowSpacing(_:)``  
- ``SKSheetView/skPrimaryTextColor(_:)``  
- ``SKSheetView/skSecondaryTextColor(_:)``  
- ``SKSheetView/skHideCloseButton(_:)``  
- ``SKSheetView/skHideContinueButton(_:)``  
- ``SKSheetView/skInteractiveDismissDisabled(_:)`` – Disables swipe-to-dismiss.  
- ``SKSheetView/skSheetStyle(_:)-(SKSheetStyle)`` – Configures sheet style
- ``SKSheetView/skSheetStyle(_:)-(Set<PresentationDetent>)`` – Configures sheet dents and binding assigned to them

### Specialized Modifiers

#### SKTitle
- ``SKTitle/skFontWeight(_:)`` – Sets the font weight.  
- ``SKTitle/skFont(_:)`` – Applies a custom SwiftUI font.  

#### SKHeaderImage
- ``SKHeaderImage/skVariant(_:)`` – Chooses a variant (e.g., none, circle, square).  
- ``SKHeaderImage/skVerticalPadding(_:)`` – Adjusts top/bottom padding.  
- ``SKHeaderImage/skRenderingMode(_:)`` – Sets the rendering mode (monochrome or multicolor).  
- ``SKHeaderImage/skSize(_:)`` – Configures the size (small, medium, large).  
- ``SKHeaderImage/skWeight(_:)`` – Adjusts weight when using symbol-based images.  

#### SKDescription
- ``SKDescription/skFontWeight(_:)`` – Sets the font weight.  
- ``SKDescription/skFont(_:)`` – Applies a custom SwiftUI font.  

### SKButton
- ``SKButton/skButtonStyle(_:)`` – Applies a specific button style (`.primary`, `.secondary`, `.navigation`, or `.note`) to an ``SKButton``, ensuring consistent appearance across platforms.

## Example

Here’s an example applying modifiers at different levels, including the `.skButtonStyle(_:)` modifier:

```swift
import SwiftUI
import SheetKit

struct ExampleSheet: View {
    var body: some View {
        SKSheetView {
            SKPage {
                SKHeaderImage(systemName: "star.fill")
                    .skVariant(.circle)
                    .skSize(.large)
                    .skRenderingMode(.multicolor)

                SKTitle("Welcome")
                    .skFont(.title)
                    .skFontWeight(.bold)

                SKDescription("Thanks for trying out SheetKit!")
                    .skFont(.callout)
                    .skFontWeight(.regular)
                    .skPrimaryTextColor(.secondary)

                SKButton("Example Button") {
                    // Perform action
                }
                .skButtonStyle(.primary)
            }
            .skAccentColor(.green)
            .skHideContinueButton()
        }
        #if os(macOS)
        .skSheetStyle(.compact)
        #else
        .skSheetStyle([.medium, .large])
        #endif
        .skInteractiveDismissDisabled()
    }
}
```

## Next Steps

* Learn how to set up SheetKit in <doc:SetUp>.
* Follow the <doc:SheetKitTutorial> to build your first sheet.
* Explore a full implementation in <doc:AboutSheet>.
