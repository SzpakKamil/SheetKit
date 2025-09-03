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

An option to control the alignment of a sheet's components.

## Overview

The ``SKSheetOptions/alignment(_:)`` option in the `SheetKit` framework allows precise control over the alignment applied to all components within a sheet conforming to the ``SKSheetable`` protocol, such as ``SKSheet`` or custom implementations. This option influences the spatial arrangement of key elements, including ``SKHeaderImage``, ``SKTitle``, ``SKDescription``, and ``SKHighlight``, enabling developers to tailor the visual layout to suit diverse design requirements. The option accepts an alignment value—`.leading`, `.center`, `.trailing`, or `nil` (for default behavior)—where `.leading` aligns content to the left, `.center` positions it centrally, `.trailing` shifts it to the right, and `nil` reverts to the system's default alignment strategy for each component. The default behavior allows individual components to adopt their intrinsic alignments, such as centered images or leading text, unless overridden by a specific alignment setting.

This alignment mechanism is particularly impactful for enhancing user experience by ensuring content is presented in a manner that aligns with the intended design aesthetic or cultural preferences, such as right-to-left layouts for certain languages. The ``SKTitle`` and ``SKDescription`` components are affected by changes in text alignment, adjusting the horizontal positioning of their content to match the specified option. Similarly, ``SKHeaderImage`` modifies its horizontal alignment, repositioning the image within the sheet's layout. Additionally, the ``SKHighlight`` component follows a unique behavior: for `.leading` and `.center` alignments, the image appears before the text and description in a leading configuration, while for `.trailing`, the text precedes the image, offering a consistent yet flexible approach to highlight presentation across different alignments. This versatility makes the `alignment(_:)` option a powerful tool for creating visually cohesive and contextually appropriate sheet designs.

## Example

The following examples demonstrate sheets with different alignment options, showcasing how the ``SKSheetOptions/alignment(_:)`` option influences the layout and presentation of sheet components across various configurations. Each example includes a single-page sheet to illustrate the alignment behavior, with additional context provided to highlight the practical application of these settings in real-world scenarios. The examples cover the primary alignment settings—`.leading`, `.center`, `.trailing`, and the default (`nil`)—along with a `ContentView` to facilitate interactive testing within a SwiftUI application.

```swift
import SwiftUI
import SheetKit

struct LeadingAllignmentSheet: SKSheet {
    var id: String = "LeadingAllignmentSheet"
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

struct CenterAllignmentSheet: SKSheet {
    var id: String = "CenterAllignmentSheet"
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

struct TrailingAllignmentSheet: SKSheet {
    var id: String = "TrailingAllignmentSheet"
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

struct DefaultAllignmentSheet: SKSheet {
    var id: String = "DefaultAllignmentSheet"
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
                sheetManager.show(sheet: LeadingAllignmentSheet.self)
            }
            Button("Show Center Alignment Sheet") {
                sheetManager.show(sheet: CenterAllignmentSheet.self)
            }
            Button("Show Trailing Alignment Sheet") {
                sheetManager.show(sheet: TrailingAllignmentSheet.self)
            }
            Button("Show Default Alignment Sheet") {
                sheetManager.show(sheet: DefaultAllignmentSheet.self)
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

In these examples, `LeadingAllignmentSheet` uses `.alignment(.leading)` to align all content to the left, with the ``SKHighlight`` displaying the image before the text to demonstrate the leading behavior. `CenterAllignmentSheet` applies `.alignment(.center)` for a centered layout, maintaining the image-before-text order in ``SKHighlight``. `TrailingAllignmentSheet` employs `.alignment(.trailing)` to shift content to the right, with ``SKHighlight`` showing text before the image to reflect trailing alignment. Finally, `DefaultAllignmentSheet` relies on `.alignment(nil)` to revert to default component alignments, with ``SKHighlight`` following the default image-leading pattern. The `ContentView` provides an interactive interface to test each sheet, making it easy to observe the alignment effects in a live environment.

## Design Images

This section illustrates the visual design of sheets using the ``SKSheetOptions/alignment(_:)`` option across various Apple platforms, with a 2x2 grid of images representing Default, Center, Leading, and Trailing alignments for each OS tab.

@TabNavigator {
    @Tab("iOS") {
        On iOS, alignment affects component positioning.
        
        Alignment on iOS adapts to screen size and orientation, ensuring readability and accessibility across different devices. The default alignment prioritizes a natural reading flow, while custom alignments enhance visual hierarchy.
        @TabNavigator {
            @Tab("iOS 26 and newer") {
                Recommended is leading alignment for text due to bigger screens, ensuring a precise content flow.
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
            @Tab("iOS 18 and older") {
                Recommended is center alignment with the old design, providing a balanced layout suitable for legacy interfaces.
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
        On iPadOS, alignment optimizes component layout.
        
        Alignment on iPadOS takes advantage of the larger screen real estate, allowing for more complex layouts. Custom alignments can improve usability in multitasking scenarios or when paired with a keyboard.
        @TabNavigator {
            @Tab("iPadOS 26 and newer") {
                All components are aligned to the leading edge for a more precise content flow, with trailing alignment not recommended due to readability challenges.
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
            @Tab("iPadOS 18 and older") {
                Recommended is center alignment due to the old Apple design, providing a balanced layout suitable for legacy interfaces.
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
        On macOS, alignment varies by style and version.
        
        Alignment on macOS supports different window styles, with custom alignments enhancing the desktop experience, especially in multi-monitor setups or when using full-screen applications.
        @TabNavigator {
            @Tab("macOS 26 and newer") {
                @TabNavigator {
                    @Tab("Default") {
                        Recommended is leading alignment to match other platforms, ensuring a precise content flow.
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
                        Recommended is leading alignment to match other platforms, ensuring a precise content flow.
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
                        Recommended is center alignment because it makes content more bold and is used for 'What's New' screens.
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
            @Tab("macOS 15 and older") {
                @TabNavigator {
                    @Tab("Default") {
                        Recommended is center alignment with the old design, providing a balanced layout suitable for legacy interfaces.
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
                        Recommended is center alignment with the old design, providing a balanced layout suitable for legacy interfaces.
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
                        Recommended is center alignment with the old design, providing a balanced layout suitable for legacy interfaces.
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
        On visionOS, alignment adapts to spatial interfaces.
        
        Alignment on visionOS is designed to work with 3D spatial environments, where custom alignments can enhance immersion by aligning content with the user's field of view or spatial context.
        @TabNavigator {
            @Tab("visionOS 26 and newer") {
                All alignments are leading as it is the first to adapt Apple's new strategy, ensuring a precise content flow.
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
            @Tab("visionOS 2 and older") {
                All alignments are leading as it is the first to adapt Apple's new strategy, ensuring a precise content flow.
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
        On watchOS, alignment is consistent across components.
        
        Alignment on watchOS ensures content remains legible on small screens, with custom alignments offering flexibility for different watch face orientations or complications.
        @TabNavigator {
            @Tab("watchOS 26 and newer") {
                Recommended is center alignment due to small screens, providing a balanced layout for optimal readability.
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
            @Tab("watchOS 11 and older") {
                Recommended is center alignment due to small screens, providing a balanced layout for optimal readability.
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
        On tvOS, alignment enhances content layout.
        
        Alignment on tvOS is optimized for large-screen viewing, where custom alignments can improve focus on key content areas, such as titles or interactive elements, during media playback.
        @TabNavigator {
            @Tab("tvOS 26 and newer") {
                Recommended is leading alignment to match new OS systems, with sheets as modals ensuring a precise content flow.
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
            @Tab("tvOS 18 and older") {
                Recommended is leading alignment because sheets are full-screen, guiding viewers easily to content.
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
