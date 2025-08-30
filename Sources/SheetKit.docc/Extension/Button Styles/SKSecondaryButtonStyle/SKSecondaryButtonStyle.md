# ``SheetKit/SKSecondaryButtonStyle``

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

A custom `ButtonStyle` used for creating secondary action buttons in the `SheetKit` framework.

## Overview

The ``SKSecondaryButtonStyle`` is a versatile `ButtonStyle` designed to define the appearance and behavior of secondary action buttons within the `SheetKit` framework. It is tailored for actions that are important but not the primary focus, such as choosing to "Log In" instead of "Continue without account" when opening an app. This style ensures a consistent and visually distinct appearance across all Apple platforms, emphasizing accessibility and a native feel while maintaining usability. It is highly recommended to pair ``SKSecondaryButtonStyle`` with the ``SKButton`` component for seamless integration and proper styling, especially when used within an ``SKToolbarItem`` with the ``SKToolbarItemPlacement/secondary`` placement, which automatically applies this style. Alternatively, developers can apply this style directly to an ``SKButton`` using the `.skButtonStyle(.secondary)` modifier, offering a convenient way to style buttons without relying on toolbar placement or manual `.buttonStyle` application. On macOS, the appearance and placement (top of the sheet for `compact` and `prominent` styles, or bottom of the view for `default`) are influenced by the ``SKSheetStyle`` value, either passed explicitly via the initializer or derived from the environment (e.g., via the `.skSheetStyle` modifier) when used with ``SKToolbarItem``.

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
                        SKToolbarItem(placement: .navigation) { action in
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

In this example, an ``SKButton`` styled with ``SKSecondaryButtonStyle`` is used in two ways: first, as a secondary action in the toolbar of an ``SKSheetView`` using ``SKToolbarItem`` with `.secondary` placement, and second, directly within the page content using the `.skButtonStyle(.secondary)` modifier. The toolbar button displays a "Log In" label with a person icon, while the page button displays a "Log In" label. The appearance is determined by the ``SKSheetStyle`` set to `.default` via the `.skSheetStyle` modifier, ensuring platform-appropriate styling.

## Design Images

This section illustrates the visual design of the ``SKSecondaryButtonStyle`` when used with ``SKButton`` across various Apple platforms, showcasing version-specific adaptations for both light and dark modes. The style adapts to the platform’s native design language, ensuring a cohesive user experience. Note that provided images are skipped when using ``SKButton`` to ensure consistent rendering.

@TabNavigator {
    @Tab("iOS") {
        The ``SKSecondaryButtonStyle`` on iOS provides a subtle yet clear appearance for secondary actions, optimized for touch interactions. It integrates seamlessly with iOS’s design system, using accent color text to distinguish it from primary actions while maintaining accessibility in both light and dark modes.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                On iOS 26 and newer, the button features accent color text within a clear capsule with a liquid glass effect, creating a modern and understated look. The design prioritizes clarity, with the accent color ensuring visibility against the transparent background in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                On iOS 18 and older, the button uses a plain text design with the accent color set as the foreground style, aligning with iOS’s earlier aesthetic. This minimalist approach ensures readability and accessibility across light and dark modes, with both text and icons displayed if provided.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the ``SKSecondaryButtonStyle`` is designed to complement the larger screen real estate, ensuring secondary actions are distinct yet unobtrusive in sheet-based interfaces. The style adapts to the device’s color scheme, providing a polished look for both light and dark environments.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the button features accent color text within a clear capsule with a liquid glass effect, optimized for touch interactions on larger displays. The transparent capsule and accent color text provide a sleek, modern appearance in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iPadOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iPadOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                On iPadOS 18 and older, the button uses a plain text design with the accent color set as the foreground style, aligning with iPadOS’s traditional design language. The accent color ensures clarity and accessibility, with both text and icons displayed if provided, in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iPadOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-iPadOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        The ``SKSecondaryButtonStyle`` on macOS is tailored to the platform’s desktop interface, with placement and appearance determined by the ``SKSheetStyle`` value, either passed through the initializer or derived from the environment (e.g., via the `.skSheetStyle` modifier) when used with ``SKToolbarItem``. The styles vary based on the ``SKSheetStyle`` configuration (``SKSheetStyle/default``, ``SKSheetStyle/compact``, or ``SKSheetStyle/prominent``) and macOS version, ensuring a native and polished look. Buttons in `compact` and `prominent` styles appear at the top of the sheet, while `default` buttons are placed at the bottom of the view.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                On macOS 26 and newer, the button design leverages modern macOS aesthetics, providing a sophisticated and visually appealing experience that adapts to light and dark modes.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a capsule with accent color text inside a clear liquid glass capsule, optimized for a wider display with a minimum width of 100, placed at the bottom of the view. This style ensures a subtle yet clear secondary action, integrating seamlessly with macOS’s windowed interface.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Default-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Default-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a capsule with accent color text inside a clear liquid glass capsule, optimized for a compact layout with a minimum width of 100, placed at the top of the sheet. This style is ideal for space-constrained interfaces while maintaining a professional look.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Compact-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Compact-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a capsule with accent color text inside a clear liquid glass capsule, with a size matching the content for a smaller, prominent appearance, placed at the top of the sheet. This style draws attention to secondary actions in a compact form.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Prominent-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Prominent-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                On macOS 15 and older, the button design adheres to the classic macOS aesthetic, with a focus on clarity and simplicity, adapting to light and dark modes for a native experience.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a plain text design with the accent color set as the foreground style, placed at the bottom of the view. This style aligns with traditional macOS button designs, ensuring a familiar and accessible experience.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Default-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Default-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a plain text design with the accent color set as the foreground style, optimized for a compact layout, placed at the top of the sheet. This style balances clarity and space efficiency for secondary actions.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Compact-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Compact-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a plain text design with the accent color set as the foreground style, with a size matching the content for a compact, prominent appearance, placed at the top of the sheet. This style emphasizes secondary actions in a streamlined form.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Prominent-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-Prominent-macOS15-Dark", alt: "Dark Mode") {
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
        On visionOS, the ``SKSecondaryButtonStyle`` is designed for immersive interfaces, featuring a consistent button design with a gray background and accent color text across all versions. The design prioritizes clarity in mixed reality environments, ensuring secondary actions are easily distinguishable.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                The button features a button with a gray background and accent color text, ensuring high contrast in both light and dark modes, optimized for visionOS’s spatial interface. If both an image and text are provided, only the image is used.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-visionOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-visionOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                The design remains consistent with a button featuring a gray background and accent color text, maintaining a cohesive look across visionOS versions, optimized for spatial computing. If both an image and text are provided, only the image is used.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-visionOS2", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-visionOS2-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        The ``SKSecondaryButtonStyle`` on watchOS is optimized for small screens, focusing on clear, tappable secondary actions. The design requires a `systemImage` for correct display, ensuring accessibility on compact devices while prioritizing a minimalist appearance.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                The button is a circular shape with a liquid glass background and a white icon, requiring a `systemImage` for display. The design leverages watchOS’s modern aesthetic, providing a vibrant and tactile appearance in both light and dark modes. Text is skipped to maintain clarity.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-watchOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                The button uses a circular shape with a gray background and a white icon, requiring a `systemImage`, aligning with watchOS’s earlier toolbar button style. Text is skipped to ensure clarity on small screens.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-watchOS11", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the ``SKSecondaryButtonStyle`` is designed for remote-based interactions, ensuring secondary actions are visually distinct and easy to navigate. The style adapts to the large-screen interface, supporting both light and dark modes for a seamless user experience.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                The button features accent color text with a clear liquid glass background, providing a modern and engaging look that complements tvOS’s large displays, ensuring clarity in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-tvOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-tvOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                The button uses accent color text with a semi-transparent gray liquid default border, aligning with tvOS’s earlier design language, ensuring a familiar and accessible experience in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-tvOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKSecondaryButtonStyle-tvOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
}

## See Also

- ``SKSecondaryButtonStyle/init(sheetStyle:isEnabled:accentColor:)``
- ``SKPrimaryButtonStyle``
- ``SKNavigationButtonStyle``
- ``SKNoteButtonStyle``
