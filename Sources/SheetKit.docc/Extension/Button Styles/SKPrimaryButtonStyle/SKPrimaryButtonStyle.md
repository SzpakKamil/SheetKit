# ``SheetKit/SKPrimaryButtonStyle``

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
    @DocumentationExtension(mergeBehavior: override)
}

@Options {
    @AutomaticTitleHeading(enabled)
    @AutomaticSeeAlso(disabled)
    @AutomaticArticleSubheading(disabled)
}

A custom `ButtonStyle` used for creating primary buttons in the `SheetKit` framework.

## Overview

The ``SKPrimaryButtonStyle`` is a versatile `ButtonStyle` designed to define the appearance and behavior of primary action buttons within the `SheetKit` framework. It is tailored for key interactions, such as confirming a choice, submitting a form, or advancing to the next step in a workflow, providing a consistent and visually prominent style across all Apple platforms. This style is highly recommended for use with the ``SKButton`` component to ensure seamless integration, especially when used within an ``SKToolbarItem`` with the ``SKToolbarItemPlacement/primary`` placement, which automatically applies this style. Alternatively, developers can apply this style directly to an ``SKButton`` using the `.skButtonStyle(.primary)` modifier, offering a convenient way to style buttons without relying on toolbar placement or manual `.buttonStyle` application. The appearance adapts to platform-specific aesthetics and is influenced by the ``SKSheetStyle`` value, either passed explicitly via the initializer or derived from the environment (e.g., via the ``SKSheetView/skSheetStyle(_:)-(SKSheetStyle)`` modifier) when used with ``SKToolbarItem``. This ensures accessibility, a native feel, and a focus on usability.

### Button Tests Example Code

```swift
import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager

    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage { } toolbar: {
                        SKToolbarItem(placement: .primary) { action in
                            SKButton("Button", systemImage: "pencil") {
                                action() 
                            }
                        }
                    }
                    .skHideCloseButton()
                    .skHideContinueButton()
                }
                .skSheetStyle(.default)
            }
        }
    }
}
```

In this example, an ``SKButton`` styled with ``SKPrimaryButtonStyle`` is used in two ways: first, as a primary action in the toolbar of an ``SKSheetView`` using ``SKToolbarItem`` with `.primary` placement, and second, directly within the page content using the `.skButtonStyle(.primary)` modifier. The toolbar button displays a "Button" label with a pencil icon, while the page button displays a "Confirm" label. The appearance is determined by the ``SKSheetStyle`` set to `.default` via the ``SKSheetView/skSheetStyle(_:)-(SKSheetStyle)`` modifier, ensuring platform-appropriate styling on macOS.

## Design Images

This section illustrates the visual design of the ``SKPrimaryButtonStyle`` when used with ``SKButton`` across various Apple platforms, showcasing version-specific adaptations for both light and dark modes. The style adapts to the platform’s native design language, ensuring a cohesive user experience. Note that provided images are skipped when using ``SKButton`` to ensure consistent rendering.

@TabNavigator {
    @Tab("iOS") {
        The ``SKPrimaryButtonStyle`` on iOS provides a bold, prominent look for primary actions, optimized for touch interactions. It integrates seamlessly with iOS’s design system, adapting to light and dark modes for visual clarity.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                On iOS 26 and newer, the button features a sleek capsule shape with a liquid glass effect and an accent color background, creating a modern and tactile appearance. The design emphasizes prominence, with white text or icons that contrast sharply against the accent color, enhancing visibility in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                On iOS 18 and older, the button adopts a rounded rectangle shape with an accent color background, maintaining a clean and familiar iOS aesthetic. The design uses white text or icons, ensuring readability and accessibility across light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the ``SKPrimaryButtonStyle`` is designed to complement the larger screen real estate, ensuring primary actions stand out in sheet-based interfaces. The style adapts to the device’s color scheme, providing a polished look for both light and dark environments.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the button features a capsule shape with a liquid glass effect and an accent color background, optimized for touch interactions on larger displays. The design uses white text or icons, ensuring high contrast and a premium feel in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iPadOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iPadOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                On iPadOS 18 and older, the button uses a rounded rectangle with an accent color background, aligning with iPadOS’s traditional design language. The white text or icons ensure clarity and accessibility, adapting seamlessly to light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iPadOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-iPadOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        The ``SKPrimaryButtonStyle`` on macOS is tailored to the platform’s desktop interface, with placement and appearance determined by the ``SKSheetStyle`` value, either passed through the initializer or derived from the environment (e.g., via the ``SKSheetView/skSheetStyle(_:)-(SKSheetStyle)`` modifier) when used with ``SKToolbarItem``. The styles vary based on the ``SKSheetStyle`` configuration (``SKSheetStyle/default``, ``SKSheetStyle/compact``, or ``SKSheetStyle/prominent``) and macOS version, ensuring a native and polished look. Buttons in `compact` and `prominent` styles appear at the top of the sheet, while `default` buttons are placed at the bottom of the view.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                On macOS 26 and newer, the button design leverages modern macOS aesthetics, providing a sophisticated and visually appealing experience that adapts to light and dark modes.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a capsule with white text and an accent color liquid glass background, optimized for a wider display with a minimum width of 100, placed at the bottom of the view. This style emphasizes prominence and integrates seamlessly with macOS’s windowed interface.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Default-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Default-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a capsule with white text and an accent color liquid glass background, optimized for a compact layout with a minimum width of 100, placed at the top of the sheet. This style is ideal for space-constrained interfaces while maintaining a professional look.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Compact-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Compact-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a capsule with white text and an accent color liquid glass background, with a size matching the content for a smaller, prominent appearance, placed at the top of the sheet. This style draws attention to critical actions in a compact form.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Prominent-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Prominent-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                On macOS 15 and older, the button design adheres to the classic macOS aesthetic, with a focus on depth and clarity, adapting to light and dark modes for a native experience.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a rounded rectangle with white text, a gradient accent color background, a shadow, and a top-to-bottom white-to-black gradient border for a depth effect, placed at the bottom of the view. This style aligns with traditional macOS button designs.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Default-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Default-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a rounded rectangle with white text, a gradient accent color background, a shadow, and a white-to-black gradient border for depth, optimized for a compact layout, placed at the top of the sheet. This style balances clarity and space efficiency.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Compact-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Compact-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a rounded rectangle with white text, a gradient accent color background, a shadow, and a white-to-black gradient border for depth, with a size matching the content for a compact, prominent appearance, placed at the top of the sheet.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Prominent-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-Prominent-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    @Tab("visionOS") {
        On visionOS, the ``SKPrimaryButtonStyle`` is designed for immersive interfaces, featuring a consistent capsule shape with an accent color background across all versions. The design prioritizes clarity in mixed reality environments, using only text for a clean and focused appearance.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                The button features a capsule shape with an accent color background, using white text for high contrast in both light and dark modes, ensuring readability in visionOS’s spatial interface.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-visionOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-visionOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                The design remains consistent with a capsule shape and an accent color background, using white text to maintain a cohesive look across visionOS versions, optimized for spatial computing.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-visionOS2", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-visionOS2-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        The ``SKPrimaryButtonStyle`` on watchOS is optimized for small screens, focusing on clear, tappable primary actions. The design requires a `systemImage` for correct display, ensuring accessibility on compact devices.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                The button is a circular shape with no background and a liquid glass effect, requiring a `systemImage` for display. The design leverages watchOS’s modern aesthetic, providing a vibrant and tactile appearance in both light and dark modes.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-watchOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                The button uses a circular shape with a gray background and a circular `systemImage`, aligning with watchOS’s earlier toolbar button style. Text is skipped to maintain clarity on small screens.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-watchOS11", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the ``SKPrimaryButtonStyle`` is designed for remote-based interactions, ensuring primary actions are visually distinct and easy to navigate. The style adapts to the large-screen interface, supporting both light and dark modes.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                The button features a liquid glass rounded rectangle with an accent color background, providing a modern and engaging look that stands out on large displays, with white text or icons for clarity.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-tvOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-tvOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                The button uses a standard rounded border with an accent color background, aligning with tvOS’s earlier design language, ensuring a familiar and accessible experience with white text or icons.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-tvOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKPrimaryButtonStyle-tvOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
}

## See Also

- ``SKPrimaryButtonStyle/init(isEnabled:accentColor:sheetStyle:colorScheme:)``
- ``SKSecondaryButtonStyle``
- ``SKNavigationButtonStyle``
- ``SKNoteButtonStyle``
