# Set Up

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
    @PageImage(purpose: card, source: "SheetKitSetUp")
}


@Options {
    @AutomaticTitleHeading(enabled)
    @AutomaticSeeAlso(disabled)
    @AutomaticArticleSubheading(disabled)
}

Learn how to integrate the `SheetKit` package into your SwiftUI project.

## Overview

The `SheetKit` package provides a **customizable, multiplatform sheet framework** for SwiftUI. It works with the **same codebase** across iOS, iPadOS, macOS, visionOS, watchOS, and tvOS. This guide explains how to add the package using Swift Package Manager (SPM).

## Adding SheetKit to Your Project

Add the `SheetKit` package to your project via Swift Package Manager:

1. In Xcode, go to **File > Add Package Dependency**.
2. Enter the package URL: `https://github.com/SzpakKamil/SheetKit.git`.
3. Select a version (e.g., `1.0.0`) or use the `main` branch, then click **Add Package**.
4. Ensure your project uses **Swift 5.9+** for compatibility.
5. Import the module in your SwiftUI view:

   ```swift
   import SheetKit
   ```

For setup instructions, supported versions, and contribution guidelines, see the README at [https://github.com/SzpakKamil/SheetKit](https://github.com/SzpakKamil/SheetKit).

### Example Integration

Here’s a minimal example of showing a sheet with **SheetKit**:

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

This creates a button that, when tapped, presents the `AboutSheet`, defined as an `SKSheet` elsewhere in your project.

## Troubleshooting

* **Package not found**: Verify the URL (`https://github.com/SzpakKamil/SheetKit.git`) and your internet connection.
* **Dependency issues**: Confirm the version or branch exists in the repository. Try the `main` branch if unsure.
* **Module not recognized**: Ensure the package is added to your project’s target and `import SheetKit` is included.
* **Compatibility errors**: Check that your project’s deployment target meets iOS 17.0+, iPadOS 17.0+, macOS 14.0+, visionOS 1.0+, watchOS 10.0+, or tvOS 17.0+.
## Next Steps

* Explore sheet customization in <doc:Modifiers>.
* Learn framework basics with <doc:SheetKitTutorial>.
* Build a sample app using <doc:AboutSheet>.
