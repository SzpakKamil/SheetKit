# ``SheetKit/SKNoteButtonStyle``

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

A custom `ButtonStyle` used for creating note action buttons in the `SheetKit` framework.

## Overview

The ``SKNoteButtonStyle`` is a specialized `ButtonStyle` designed to define the appearance and behavior of note action buttons within the `SheetKit` framework. It is tailored for informational actions, such as linking to privacy notes or "know more" content, providing a consistent and visually distinct appearance across supported Apple platforms, mirroring the design of ``SKNavigationButtonStyle``. This style emphasizes accessibility and a native feel, making it ideal for secondary informational actions that guide users to additional details. It is highly recommended to pair ``SKNoteButtonStyle`` with the ``SKButton`` component for seamless integration and proper styling, especially when used within an ``SKToolbarItem`` with the ``SKToolbarItemPlacement/note`` placement, which automatically applies this style. Alternatively, developers can apply this style directly to an ``SKButton`` using the `.skButtonStyle(.note)` modifier. On macOS, the appearance and placement (top of the sheet for `compact` and `prominent` styles, or bottom of the view for `default`) are influenced by the ``SKSheetStyle`` value, either passed explicitly via the initializer or derived from the environment (e.g., via the `.skSheetStyle` modifier) when used with ``SKToolbarItem``. On watchOS, the button is uniquely positioned in the middle of the bottom bar and requires a specific 'i' icon for rendering, with text skipped.

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
                        SKToolbarItem(placement: .note) { action in
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

In this example, an ``SKButton`` styled with ``SKNoteButtonStyle`` is used as a note action in the toolbar of an ``SKSheetView``. The button displays a "Learn More" label, with an info circle icon used only on watchOS or newer OS versions (26 and above) where it appears at the leading part of the text, and its appearance is determined by the ``SKSheetStyle`` set to `.default` via the `.skSheetStyle` modifier, ensuring platform-appropriate styling.

## Design Images

This section illustrates the visual design of the ``SKNoteButtonStyle`` when used with ``SKButton`` across various Apple platforms, showcasing version-specific adaptations for both light and dark modes. The style adapts to the platform’s native design language, ensuring a cohesive user experience for note actions. Provided images are never used, and the button relies solely on text, except on watchOS where a specific 'i' icon is used. On watchOS, the button is uniquely designed and positioned, but this style is primarily intended for other platforms.

@TabNavigator {
    @Tab("iOS") {
        The ``SKNoteButtonStyle`` on iOS provides a subtle and clear appearance for note actions, optimized for touch interactions. It integrates seamlessly with iOS’s design system, using accent color text to highlight informational actions, with an info circle icon at the leading part on newer versions, while maintaining accessibility in both light and dark modes.
        @TabNavigator {
            @Tab("iOS 26 and Newer") {
                On iOS 26 and newer, the button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text. This design offers a modern, minimalist look, with the accent color ensuring visibility in both light and dark modes. Only text is used, with the icon added automatically for this version.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iOS 18 and Older") {
                On iOS 18 and older, the button is a text button with an accent color foreground style, using only text, aligning with iOS’s earlier aesthetic. The design ensures readability and accessibility across light and dark modes, with a focus on simplicity for note actions.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("iPadOS") {
        On iPadOS, the ``SKNoteButtonStyle`` is designed to complement the larger screen real estate, ensuring note actions are distinct and easily accessible in sheet-based interfaces. The style adapts to the device’s color scheme, providing a polished look for both light and dark environments, with an info circle icon at the leading part on newer versions.
        @TabNavigator {
            @Tab("iPadOS 26 and Newer") {
                For iPadOS 26 and newer, the button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text. The design offers a sleek, minimalist appearance optimized for touch interactions on larger displays, with high contrast in both light and dark modes. Only text is used, with the icon added automatically.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iPadOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iPadOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("iPadOS 18 and Older") {
                On iPadOS 18 and older, the button is a text button with an accent color foreground style, using only text, aligning with iPadOS’s traditional design language. The accent color ensures clarity and accessibility in both light and dark modes, with a focus on simplicity for note actions.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iPadOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-iPadOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("macOS") {
        The ``SKNoteButtonStyle`` on macOS is tailored to the platform’s desktop interface. The styles vary don't vary that on the ``SKSheetStyle`` configuration (``SKSheetStyle/default``, ``SKSheetStyle/compact``, or ``SKSheetStyle/prominent``). Only text is used, with the info circle icon appearing at the leading part on newer versions.
        @TabNavigator {
            @Tab("macOS 26 and Newer") {
                On macOS 26 and newer, the button design leverages modern macOS aesthetics, providing a sophisticated and visually appealing experience that adapts to light and dark modes for note actions.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text, placed at the bottom of the view. This style ensures a clear and accessible note action, integrating seamlessly with macOS’s windowed interface.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Default-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Default-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text, optimized for a compact layout. This style is ideal for space-constrained interfaces while maintaining clarity for note actions.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Compact-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Compact-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text. This style draws attention to note actions in a compact form.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Prominent-macOS26", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Prominent-macOS26-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                }
            }
            @Tab("macOS 15 and Older") {
                On macOS 15 and older, the button design adheres to the classic macOS aesthetic, with a focus on clarity and simplicity, adapting to light and dark modes for a native note action experience.
                @TabNavigator {
                    @Tab("Default") {
                        The button is a text button with an accent color foreground style, using only text, placed at the bottom of the view. This style aligns with traditional macOS button designs for note actions, ensuring a familiar and accessible experience.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Default-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Default-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Compact") {
                        The button is a text button with an accent color foreground style, using only text, optimized for a compact layout. This style balances clarity and space efficiency for note actions.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Compact-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Compact-macOS15-Dark", alt: "Dark Mode") {
                                    Dark Mode
                                }
                            }
                        }
                    }
                    @Tab("Prominent") {
                        The button is a text button with an accent color foreground style, using only text, with a size matching the content. This style emphasizes note actions in a streamlined form.
                        @Row(numberOfColumns: 2) {
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Prominent-macOS15", alt: "Light Mode") {
                                    Light Mode
                                }
                            }
                            @Column(size: 1) {
                                @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-Prominent-macOS15-Dark", alt: "Dark Mode") {
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
        On visionOS, the ``SKNoteButtonStyle`` is designed for immersive interfaces, featuring a consistent text button with an accent color foreground style across all versions. The design prioritizes clarity in mixed reality environments, ensuring note actions are easily distinguishable, with an info circle icon at the leading part on newer versions.
        @TabNavigator {
            @Tab("visionOS 26 and Newer") {
                The button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text, ensuring high contrast in both light and dark modes, optimized for visionOS’s spatial interface. Only text is used, with the icon added automatically.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-visionOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-visionOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("visionOS 2 and Older") {
                The button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text, maintaining a cohesive look across visionOS versions, optimized for spatial computing. The design ensures clarity and accessibility for note actions.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-visionOS2", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-visionOS2-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("watchOS") {
        The ``SKNoteButtonStyle`` on watchOS is uniquely designed for small screens, positioned in the middle of the bottom bar, and requires a `systemImage` of an 'i' for correct display. The style focuses on clear, tappable note actions, ensuring accessibility on compact devices while prioritizing a minimalist appearance. Text is skipped, and only the specified icon is used.
        @TabNavigator {
            @Tab("watchOS 26 and Newer") {
                The button is a circular shape with a liquid glass background and an 'i' icon (`systemImage: "info.circle"`) in the middle of the bottom bar, requiring the specified `systemImage` for display. The design leverages watchOS’s modern aesthetic, providing a vibrant and tactile appearance in both light and dark modes.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-watchOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
            @Tab("watchOS 11 and Older") {
                The button uses a circular shape with a gray background and an 'i' icon (`systemImage: "info.circle"`), positioned in the middle of the bottom bar, aligning with watchOS’s earlier toolbar button style.
                @Row(numberOfColumns: 1) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-watchOS11", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                }
            }
        }
    }
    @Tab("tvOS") {
        On tvOS, the ``SKNoteButtonStyle`` is designed for remote-based interactions, ensuring note actions are visually distinct and easy to navigate. The style adapts to the large-screen interface, supporting both light and dark modes for a seamless user experience, with an info circle icon at the leading part on newer versions.
        @TabNavigator {
            @Tab("tvOS 26 and Newer") {
                The button is a text button with an accent color foreground style, featuring an info circle filled icon (`systemImage: "info.circle.fill"`) at the leading part of the text, providing a modern and engaging look that complements tvOS’s large displays, ensuring clarity in both light and dark modes. Only text is used, with the icon added automatically.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-tvOS26", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-tvOS26-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
            @Tab("tvOS 18 and Older") {
                The button is a text button with an accent color foreground style, using only text, aligning with tvOS’s earlier design language, ensuring a familiar and accessible experience in both light and dark modes.
                @Row(numberOfColumns: 2) {
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-tvOS18", alt: "Light Mode") {
                            Light Mode
                        }
                    }
                    @Column(size: 1) {
                        @Image(source: "Documentation-ButtonStyles-SKNoteButtonStyle-tvOS18-Dark", alt: "Dark Mode") {
                            Dark Mode
                        }
                    }
                }
            }
        }
    }
}

## See Also

- ``SKNoteButtonStyle/init(isEnabled:accentColor:colorScheme:textAlignment:)``
- ``SKPrimaryButtonStyle``
- ``SKSecondaryButtonStyle``
- ``SKNavigationButtonStyle``
