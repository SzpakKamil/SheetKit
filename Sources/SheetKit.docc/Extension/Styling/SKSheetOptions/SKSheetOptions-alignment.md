# ``SheetKit/SKSheetOptions/alignment(_:)``

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

Controls the alignment of a sheet’s components, such as `SKHeaderImage`, `SKTitle`, `SKDescription`, and `SKHighlight`.

## Overview

The `SKSheetOptions/alignment(_:)` option in the `SheetKit` framework provides precise control over the horizontal alignment of all components within a sheet conforming to the `SKSheetable` protocol, such as `SKSheet` or custom implementations. It accepts an alignment value—`.leading`, `.center`, `.trailing`, or `nil`—where `.leading` aligns content to the left, `.center` positions it centrally, `.trailing` shifts it to the right, and `nil` (the default) allows components to adopt their intrinsic alignments (e.g., centered images, leading text). This option affects the layout of `SKHeaderImage`, `SKTitle`, `SKDescription`, and `SKHighlight`, enabling developers to tailor the visual presentation to specific design or cultural needs, such as right-to-left layouts for certain languages.

For `SKTitle` and `SKDescription`, the option adjusts text alignment, ensuring consistent positioning. For `SKHeaderImage`, it repositions the image horizontally within the sheet. For `SKHighlight`, the alignment influences the order of elements: `.leading` and `.center` place the image before the text and description, while `.trailing` places the text first, followed by the image. This flexibility makes `alignment(_:)` ideal for creating visually cohesive sheets, enhancing readability and user experience across diverse use cases, such as onboarding, forms, or localized interfaces. It integrates seamlessly with other `SheetKit` options, like `SKSheetOptions/style(_:)` and `SKSheetOptions/isFullScreenCover(_:)`, for comprehensive design control.

### Platform-Specific Behavior

- **iOS/iPadOS/tvOS/watchOS/visionOS**: Aligns components (text, images, highlights) to `.leading`, `.center`, `.trailing`, or default (`nil`).
- **macOS**: Aligns components based on style (`default`, `compact`, `prominent`), with placement varying by version.
- **All platforms**: `SKHighlight` image precedes text for `.leading`/`.center`, follows text for `.trailing`.

## Example

The following examples demonstrate sheets with different alignment options (`.leading`, `.center`, `.trailing`, and `nil`) to illustrate their impact on component layout. Each sheet contains a single page with `SKHeaderImage`, `SKTitle`, `SKDescription`, and `SKHighlight`. A `ContentView` enables interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct LeadingAlignmentSheet: SKSheet {
    var id: String = "LeadingAlignmentSheet"
    var options: Set<SKSheetOptions> = [.alignment(.leading), .style(.default)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "align.horizontal.left.fill")
            SKTitle("Leading Alignment Display")
            SKDescription("This sheet aligns all text and images to the left, providing a structured left-to-right flow ideal for documentation or forms.")
            SKHighlight(title: "Left-Side Focus", description: "Image appears before text to emphasize leading alignment", systemName: "align.horizontal.left.fill")
        }
    }
}

struct CenterAlignmentSheet: SKSheet {
    var id: String = "CenterAlignmentSheet"
    var options: Set<SKSheetOptions> = [.alignment(.center), .style(.default)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "align.horizontal.center.fill")
            SKTitle("Centered Alignment View")
            SKDescription("This sheet centers all content, creating a balanced and visually appealing layout suitable for presentations or welcome screens.")
            SKHighlight(title: "Central Emphasis", description: "Image precedes text in a centered arrangement", systemName: "align.horizontal.center.fill")
        }
    }
}

struct TrailingAlignmentSheet: SKSheet {
    var id: String = "TrailingAlignmentSheet"
    var options: Set<SKSheetOptions> = [.alignment(.trailing), .style(.default)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "align.horizontal.right.fill")
            SKTitle("Trailing Alignment Layout")
            SKDescription("This sheet aligns content to the right, offering a right-to-left flow perfect for localized interfaces or unique design preferences.")
            SKHighlight(title: "Right-Side Priority", description: "Text appears before image to highlight trailing alignment", systemName: "align.horizontal.right.fill")
        }
    }
}

struct DefaultAlignmentSheet: SKSheet {
    var id: String = "DefaultAlignmentSheet"
    var options: Set<SKSheetOptions> = [.alignment(nil), .style(.default)]
    
    var pages: [SKPage] {
        SKPage {
            SKHeaderImage(systemName: "align.horizontal.center.fill")
            SKTitle("Default Alignment Setup")
            SKDescription("This sheet uses the system's default alignments, allowing each component to adopt its natural positioning, such as centered images and leading text.")
            SKHighlight(title: "Default Highlight", description: "Image leads text as per default behavior", systemName: "align.horizontal.left.fill")
        }
    }
}

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Leading Alignment Sheet") {
                sheetManager.show(sheet: LeadingAlignmentSheet.self)
            }
            Button("Show Center Alignment Sheet") {
                sheetManager.show(sheet: CenterAlignmentSheet.self)
            }
            Button("Show Trailing Alignment Sheet") {
                sheetManager.show(sheet: TrailingAlignmentSheet.self)
            }
            Button("Show Default Alignment Sheet") {
                sheetManager.show(sheet: DefaultAlignmentSheet.self)
            }
        }
        .padding()
    }
}

@main
struct ExampleAlignmentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .skSheetManager(.init())
        }
    }
}
```

In these examples, `LeadingAlignmentSheet` aligns content to the left with `.alignment(.leading)`, placing the `SKHighlight` image before text. `CenterAlignmentSheet` centers content with `.alignment(.center)`, maintaining the image-before-text order for `SKHighlight`. `TrailingAlignmentSheet` aligns content to the right with `.alignment(.trailing)`, with `SKHighlight` text preceding the image. `DefaultAlignmentSheet` uses `.alignment(nil)` for default component alignments. The `ContentView` enables interactive testing of each alignment.

## Design Images

@TabNavigator {
    @Tab("iOS") {
        On iOS, the `alignment(_:)` option controls the horizontal positioning of sheet components, optimizing layouts for touch-driven interfaces. It ensures readability across various iPhone screen sizes, supporting diverse use cases like onboarding or forms. Custom alignments enhance visual hierarchy, particularly for localized or presentation-focused designs, while the default alignment balances natural component positioning for general use.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                For iOS 26 and newer, leading alignment is recommended for text-heavy sheets due to larger screens, ensuring a clear left-to-right flow. Center alignment suits visual presentations, while trailing alignment supports right-to-left languages. Default alignment adapts to component-specific positioning for flexibility.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-iOS26", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-iOS26", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-iOS26", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-iOS26", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                For iOS 18 and earlier, center alignment is recommended for balanced layouts in legacy designs. Leading alignment supports structured forms, while trailing alignment aids right-to-left interfaces. Default alignment provides a natural flow, aligning with older iOS aesthetics.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-iOS18", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-iOS18", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-iOS18", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-iOS18", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the `alignment(_:)` option optimizes component layout for larger screens, enhancing usability in multitasking scenarios like Split View or Slide Over. Custom alignments improve readability for complex layouts, while default alignment ensures a natural flow, making it ideal for forms, tutorials, or presentations on iPads.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, leading alignment is recommended for text-heavy sheets to ensure a clear content flow, especially in multitasking environments. Center alignment suits visual-centric designs, while trailing alignment supports localized interfaces but is less common due to readability concerns.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-iPadOS26", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-iPadOS26", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-iPadOS26", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-iPadOS26", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                For iPadOS 18 and earlier, center alignment is recommended for balanced layouts in legacy designs, aligning with older iPad aesthetics. Leading alignment supports structured content, while trailing alignment aids right-to-left layouts. Default alignment ensures component-specific positioning.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-iPadOS18", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-iPadOS18", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-iPadOS18", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-iPadOS18", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        On macOS, the `alignment(_:)` option varies by sheet style (`default`, `compact`, `prominent`), enhancing layouts for desktop workflows. Custom alignments support multi-monitor setups or full-screen applications, ensuring content clarity and accessibility in window-based interfaces.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                For macOS 26 and newer, alignment adapts to sheet style, with leading alignment recommended for consistent content flow across platforms. Center alignment is ideal for prominent designs, while trailing alignment supports localized layouts. Default alignment balances component-specific positioning.
                @TabNavigator {
                    @Tab("Default") {
                        Leading alignment is recommended for structured layouts, ensuring a clear left-to-right flow for forms or documentation. Center and trailing alignments offer flexibility for unique designs.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-Default-macOS26", alt: "Default Alignment") {
                                    Default Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-Default-macOS26", alt: "Center Alignment") {
                                    Center Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-Default-macOS26", alt: "Leading Alignment") {
                                    Leading Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-Default-macOS26", alt: "Trailing Alignment") {
                                    Trailing Alignment
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        Leading alignment is recommended for streamlined layouts, optimizing space in compact sheets. Center and trailing alignments provide flexibility for specific use cases.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-Compact-macOS26", alt: "Default Alignment") {
                                    Default Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-Compact-macOS26", alt: "Center Alignment") {
                                    Center Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-Compact-macOS26", alt: "Leading Alignment") {
                                    Leading Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-Compact-macOS26", alt: "Trailing Alignment") {
                                    Trailing Alignment
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        Center alignment is recommended for bold, attention-grabbing layouts, ideal for "What's New" screens or key announcements. Leading and trailing alignments support structured or localized designs.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-Prominent-macOS26", alt: "Default Alignment") {
                                    Default Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-Prominent-macOS26", alt: "Center Alignment") {
                                    Center Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-Prominent-macOS26", alt: "Leading Alignment") {
                                    Leading Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-Prominent-macOS26", alt: "Trailing Alignment") {
                                    Trailing Alignment
                                }
                            }
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                For macOS 15 and earlier, center alignment is recommended for balanced layouts in legacy window-based designs. Leading alignment supports structured content, while trailing alignment aids right-to-left interfaces. Default alignment ensures component-specific positioning.
                @TabNavigator {
                    @Tab("Default") {
                        Center alignment is recommended for balanced, legacy layouts. Leading and trailing alignments offer flexibility for structured or localized content.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-Default-macOS15", alt: "Default Alignment") {
                                    Default Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-Default-macOS15", alt: "Center Alignment") {
                                    Center Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-Default-macOS15", alt: "Leading Alignment") {
                                    Leading Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-Default-macOS15", alt: "Trailing Alignment") {
                                    Trailing Alignment
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        Center alignment is recommended for streamlined legacy layouts. Leading and trailing alignments support specific design needs.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-Compact-macOS15", alt: "Default Alignment") {
                                    Default Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-Compact-macOS15", alt: "Center Alignment") {
                                    Center Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-Compact-macOS15", alt: "Leading Alignment") {
                                    Leading Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-Compact-macOS15", alt: "Trailing Alignment") {
                                    Trailing Alignment
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        Center alignment is recommended for bold legacy layouts, ideal for key announcements. Leading and trailing alignments support structured or localized designs.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-Prominent-macOS15", alt: "Default Alignment") {
                                    Default Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-Prominent-macOS15", alt: "Center Alignment") {
                                    Center Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-Prominent-macOS15", alt: "Leading Alignment") {
                                    Leading Alignment
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-Prominent-macOS15", alt: "Trailing Alignment") {
                                    Trailing Alignment
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, the `alignment(_:)` option adapts to spatial interfaces, aligning content with the user’s field of view in 3D environments. Leading alignment is preferred for consistent content flow, while center and trailing alignments enhance immersion for specific use cases, such as interactive or localized designs.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                For visionOS 26 and newer, leading alignment is standard, aligning with Apple’s spatial design strategy for clear content presentation. Center alignment suits immersive presentations, while trailing alignment supports right-to-left layouts in 3D spaces.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-visionOS26", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-visionOS26", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-visionOS26", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-visionOS26", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                For visionOS 2 and earlier, leading alignment is standard, ensuring clear content flow in early mixed reality designs. Center and trailing alignments support specific spatial or localized use cases, with default alignment balancing component positioning.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-visionOS2", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-visionOS2", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-visionOS2", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-visionOS2", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        On watchOS, the `alignment(_:)` option ensures legibility on small screens, with consistent component alignment across compact interfaces. Center alignment is preferred for balanced readability, while leading and trailing alignments support specific design or localization needs, enhancing usability for watch face orientations.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                For watchOS 26 and newer, center alignment is recommended for optimal readability on small screens. Leading alignment supports structured layouts, while trailing alignment aids right-to-left interfaces. Default alignment ensures natural component positioning.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-watchOS26", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-watchOS26", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-watchOS26", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-watchOS26", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                For watchOS 11 and earlier, center alignment is recommended for balanced layouts on small screens. Leading and trailing alignments support specific design or localization needs, with default alignment ensuring natural component positioning.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-watchOS11", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-watchOS11", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-watchOS11", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-watchOS11", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the `alignment(_:)` option enhances content layout for large-screen viewing, optimizing focus on titles, descriptions, or interactive elements during media playback. Leading alignment is preferred for modal sheets, ensuring a clear flow, while center and trailing alignments support specific design or localization needs.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                For tvOS 26 and newer, leading alignment is recommended for modal sheets, aligning with modern OS designs for clear content flow. Center alignment suits visual presentations, while trailing alignment supports right-to-left interfaces, with default alignment balancing component positioning.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-tvOS26", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-tvOS26", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-tvOS26", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-tvOS26", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                For tvOS 18 and earlier, leading alignment is recommended for full-screen sheets, guiding viewers through content. Center alignment suits balanced layouts, while trailing alignment supports right-to-left interfaces. Default alignment ensures natural component positioning.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Default-tvOS18", alt: "Default Alignment") {
                            Default Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Center-tvOS18", alt: "Center Alignment") {
                            Center Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Leading-tvOS18", alt: "Leading Alignment") {
                            Leading Alignment
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-Styling-SKSheetOptions-Alignment-Trailing-tvOS18", alt: "Trailing Alignment") {
                            Trailing Alignment
                        }
                    }
                }
            }
        }
    }
}

## See Also

- ``SKSheetOptions``
- ``SKSheetable``
- ``SKSheet``
- ``SKPage``
- ``SKPage/skAlignment(_:)``
- ``SKHeaderImage``
- ``SKTitle``
- ``SKDescription``
- ``SKHighlight``
- ``SwiftUICore/EnvironmentValues/skAlignment``
