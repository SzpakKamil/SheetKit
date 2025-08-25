# ``SheetKit/SKNavigationButtonStyle``

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

A custom `ButtonStyle` used for creating navigation action buttons in the `SheetKit` framework.

## Overview

The ``SKNavigationButtonStyle`` is a versatile `ButtonStyle` designed to define the appearance and behavior of navigation action buttons within the `SheetKit` framework. It is tailored for actions such as navigating to another screen when a secondary action is provided or implementing a custom close button, but it should not be used for forward navigation, which is reserved for buttons with ``SKToolbarItemPlacement/primary`` placement. This style ensures a consistent and visually distinct appearance across all Apple platforms, emphasizing accessibility and a native feel while maintaining usability. It is highly recommended to pair ``SKNavigationButtonStyle`` with the ``SKButton`` component for seamless integration and proper styling, especially when used within an ``SKToolbarItem`` with the ``SKToolbarItemPlacement/navigation`` placement, which automatically applies this style. On macOS, the appearance and placement (top of the sheet for `compact` and `prominent` styles, or bottom of the view for `default`) are influenced by the ``SKSheetStyle`` value, either passed explicitly via the initializer or derived from the environment (e.g., via the `.skSheetStyle` modifier) when used with ``SKToolbarItem``.

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
                    SKPage {
                        // Page content
                    } toolbar: {
                        SKToolbarItem(placement: .navigation) { action in
                            SKButton("Back", systemImage: "arrow.left.circle") {
                                action() // Custom close action
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

In this example, an ``SKButton`` styled with ``SKNavigationButtonStyle`` is used as a navigation action in the toolbar of an ``SKSheetView``. The button displays a "Back" label with an arrow icon for a custom close action, and its appearance is determined by the ``SKSheetStyle`` set to `.default` via the `.skSheetStyle` modifier, ensuring platform-appropriate styling.

## Design Images

This section illustrates the visual design of the ``SKNavigationButtonStyle`` when used with ``SKButton`` across various Apple platforms, showcasing version-specific adaptations for both light and dark modes. The style adapts to the platform’s native design language, ensuring a cohesive user experience for navigation actions. Note that provided images are skipped when using ``SKButton`` to ensure consistent rendering.

@TabNavigator {
    @Tab("iOS") {
        The ``SKNavigationButtonStyle`` on iOS provides a clear and intuitive appearance for navigation actions, optimized for touch interactions. It integrates seamlessly with iOS’s design system, using accent color icons or text to distinguish navigation actions while maintaining accessibility in both light and dark modes.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                On iOS 26 and newer, the button features a clear liquid glass button with an icon or text inside, using an accent color foreground style. If both an image and text are provided, only the image is used; if only text is provided, the text is used. This design offers a modern, tactile appearance, with the accent color ensuring visibility in both light and dark modes. It is recommended to specify both image and text for optimal rendering.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                On iOS 18 and older, the button is a text button with an accent color foreground style, using both text and image if provided, aligning with iOS’s earlier aesthetic. The design ensures readability and accessibility across light and dark modes, with a focus on simplicity for navigation actions. It is recommended to specify only text for consistent rendering.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the ``SKNavigationButtonStyle`` is designed to complement the larger screen real estate, ensuring navigation actions are distinct and easily accessible in sheet-based interfaces. The style adapts to the device’s color scheme, providing a polished look for both light and dark environments.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the button features a clear liquid glass button with an icon or text inside, using an accent color foreground style. If both an image and text are provided, only the image is used; if only text is provided, the text is used. The design offers a sleek, modern appearance optimized for touch interactions on larger displays, with high contrast in both light and dark modes. It is recommended to specify both image and text.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iPadOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iPadOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                On iPadOS 18 and older, the button is a text button with an accent color foreground style, using both text and image if provided, aligning with iPadOS’s traditional design language. The accent color ensures clarity and accessibility in both light and dark modes, with a focus on simplicity for navigation actions. It is recommended to specify only text.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iPadOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-iPadOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        The ``SKNavigationButtonStyle`` on macOS is tailored to the platform’s desktop interface, with placement and appearance determined by the ``SKSheetStyle`` value, either passed through the initializer or derived from the environment (e.g., via the `.skSheetStyle` modifier) when used with ``SKToolbarItem``. The styles vary based on the ``SKSheetStyle`` configuration (``SKSheetStyle/default``, ``SKSheetStyle/compact``, or ``SKSheetStyle/prominent``) and macOS version, ensuring a native and polished look. Buttons in `compact` and `prominent` styles appear at the top of the sheet, while `default` buttons are placed at the bottom of the view. When both an image and text are provided to ``SKButton``, only the image is used for `prominent` and `compact` styles, but only the text is used for the `default` style.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                On macOS 26 and newer, the button design leverages modern macOS aesthetics, providing a sophisticated and visually appealing experience that adapts to light and dark modes for navigation actions.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a capsule with primary color text inside a clear liquid glass capsule, with a minimum width of 100 for a wider appearance, placed at the bottom of the view. This style ensures a clear and accessible navigation action, integrating seamlessly with macOS’s windowed interface.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Default-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Default-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a circle with an icon inside, using an accent color foreground style and a liquid glass background, with a size matching the content for a smaller, compact appearance, placed at the top of the sheet. This style is ideal for space-constrained interfaces while maintaining clarity for navigation actions.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Compact-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Compact-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a circle with an icon inside, using an accent color foreground style and a liquid glass background, with a size matching the content for a smaller, prominent appearance, placed at the top of the sheet. This style draws attention to critical navigation actions in a compact form.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Prominent-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Prominent-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                On macOS 15 and older, the button design adheres to the classic macOS aesthetic, with a focus on depth and clarity, adapting to light and dark modes for a native navigation experience.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a plain text design with the primary color set as the foreground style, with a gradient background, a shadow, and a top-to-bottom white-to-black gradient border for a depth effect, placed at the bottom of the view. This style aligns with traditional macOS button designs for navigation actions.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Default-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Default-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a plain text design with the primary color set as the foreground style, with a gradient background, a shadow, and a white-to-black gradient border for depth, optimized for a compact layout, placed at the top of the sheet. This style balances clarity and space efficiency for navigation actions.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Compact-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Compact-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a plain text design with the primary color set as the foreground style, with a gradient background, a shadow, and a white-to-black gradient border for depth, with a size matching the content for a compact, prominent appearance, placed at the top of the sheet. This style emphasizes navigation actions in a streamlined form.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Prominent-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-Prominent-macOS15-Dark", alt: "Dark Mode") {
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
        On visionOS, the ``SKNavigationButtonStyle`` is designed for immersive interfaces, featuring a consistent circular button with a gray background and an accent color icon or text across all versions. The design prioritizes clarity in mixed reality environments, ensuring navigation actions are easily distinguishable. If both an image and text are provided, only the image is used.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                The button features a circular shape with a gray background and an accent color icon or text, ensuring high contrast in both light and dark modes, optimized for visionOS’s spatial interface. The design maintains a clean and focused appearance for navigation actions.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-visionOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-visionOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                The design remains consistent with a circular button featuring a gray background and an accent color icon or text, maintaining a cohesive look across visionOS versions, optimized for spatial computing. Only the image is used if both image and text are provided.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-visionOS2", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-visionOS2-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        The ``SKNavigationButtonStyle`` on watchOS is optimized for small screens, focusing on clear, tappable navigation actions. The design requires a `systemImage` for correct display, ensuring accessibility on compact devices while prioritizing a minimalist appearance.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                The button is a circular shape with no background and a liquid glass effect, requiring a `systemImage` for display. The design leverages watchOS’s modern aesthetic, providing a vibrant and tactile appearance in both light and dark modes. Text is skipped to maintain clarity.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-watchOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                The button uses a circular shape with a gray background and a circular `systemImage`, aligning with watchOS’s earlier toolbar button style. Text is skipped to ensure clarity on small screens.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-watchOS11", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the ``SKNavigationButtonStyle`` is designed for remote-based interactions, ensuring navigation actions are visually distinct and easy to navigate. The style adapts to the large-screen interface, supporting both light and dark modes for a seamless user experience.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                The button features accent color text with a clear liquid glass background, providing a modern and engaging look that complements tvOS’s large displays, ensuring clarity in both light and dark modes. Images are skipped to maintain consistency.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-tvOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-tvOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                The button uses accent color text with a semi-transparent gray liquid default border, aligning with tvOS’s earlier design language, ensuring a familiar and accessible experience in both light and dark modes. Images are skipped for consistency.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-tvOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNavigationButtonStyle-tvOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
}

## See Also

- ``SKNavigationButtonStyle/init(sheetStyle:isEnabled:accentColor:)``
- ``SKPrimaryButtonStyle``
- ``SKSecondaryButtonStyle``
- ``SKNoteButtonStyle``
