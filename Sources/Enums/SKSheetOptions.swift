//
//  SKSheetOptions.swift
//  SheetKit
//
//  Created by Kamil Szpak on 18/08/2025.
//

import SwiftUI

public enum SKSheetOptions: Identifiable, Hashable{
    case isHandoffEnabled(Bool = false)
    case hideCloseButton(Bool = true)
    case interactiveDismissDisabled(Bool = true)
    case style(SKSheetStyle = .default)
    case presentationDents(dents: Set<PresentationDetent>, selection: Binding<PresentationDetent>? = nil)
    case accentColor(Color = .accentColor)
    case dragIndicatorVisibility(Visibility = .hidden)
    case alignment(HorizontalAlignment? = nil)
    case rowBackground(Color? = nil)
    case rowShape(cornerRadius: CGFloat? = nil)
    case rowSpacing(spacing: CGFloat? = nil)
    case primaryTextColor(color: Color? = nil)
    case secondaryTextColor(color: Color? = nil)
    case hideContinueButton(Bool = true)
    case isFullScreenCover(Bool = true)
    
    @_documentation(visibility: internal)
    public var id: Int{
        switch self {
        case .isHandoffEnabled:
            0
        case .hideCloseButton:
            1
        case .interactiveDismissDisabled:
            2
        case .style:
            3
        case .presentationDents:
            4
        case .accentColor:
            5
        case .alignment:
            6
        case .rowBackground:
            7
        case .rowShape:
            8
        case .rowSpacing:
            9
        case .primaryTextColor:
            10
        case .secondaryTextColor:
            11
        case .hideContinueButton:
            12
        case .isFullScreenCover:
            13
        case .dragIndicatorVisibility:
            14
        }
    }
    
    var value1: Any? {
        switch self {
        case .isHandoffEnabled(let bool):
            bool
        case .hideCloseButton(let bool):
            bool
        case .interactiveDismissDisabled(let bool):
            bool
        case .style(let sKSheetStyle):
            sKSheetStyle
        case .presentationDents(let dents, let selection):
            dents
        case .accentColor(let color):
            color
        case .alignment(let horizontalAlignment):
            horizontalAlignment
        case .rowBackground(let color):
            color
        case .rowShape(let cornerRadius):
            cornerRadius
        case .rowSpacing(let spacing):
            spacing
        case .primaryTextColor(let color):
            color
        case .secondaryTextColor(let color):
            color
        case .hideContinueButton(let bool):
            bool
        case .isFullScreenCover(let bool):
            bool
        case .dragIndicatorVisibility(let visibility):
            visibility
        }
    }
    
    var value2: Any? {
        switch self {
        case .isHandoffEnabled(let bool):
            nil
        case .hideCloseButton(let bool):
            nil
        case .interactiveDismissDisabled(let bool):
            nil
        case .style(let sKSheetStyle):
            nil
        case .presentationDents(let dents, let selection):
            selection
        case .accentColor(let color):
            nil
        case .alignment(let horizontalAlignment):
            nil
        case .rowBackground(let color):
            nil
        case .rowShape(let cornerRadius):
            nil
        case .rowSpacing(let spacing):
            nil
        case .primaryTextColor(let color):
            nil
        case .secondaryTextColor(let color):
            nil
        case .hideContinueButton(let bool):
            nil
        case .isFullScreenCover(let bool):
            nil
        case .dragIndicatorVisibility(let visibility):
            nil
        }
    }
    
    
    @_documentation(visibility: internal)
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @_documentation(visibility: internal)
    public static func == (lhs: SKSheetOptions, rhs: SKSheetOptions) -> Bool {
        lhs.id == rhs.id
    }
}
