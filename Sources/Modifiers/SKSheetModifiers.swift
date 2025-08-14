//
//  SKSheetModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI


public extension SKSheetable{
    func skAccentColor(_ color: Color = .accentColor) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skAccentColor, color)
        }
    }
    func skAlignment(_ alignment: HorizontalAlignment?) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skAlignment, alignment)
        }
    }
    func skRowBackground(_ color: Color? = nil) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skRowBackgroundColor, color)
        }
    }
    func skRowShape(cornerRadius: CGFloat? = nil) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skRowShape, cornerRadius)
        }
    }
    func skRowSpacing(_ spacing: CGFloat? = nil) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skRowSpacing, spacing)
        }
    }
    func skPrimaryTextColor(_ color: Color? = nil) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skPrimaryColor, color)
        }
    }
    func skSecondaryTextColor(_ color: Color? = nil) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skSecondaryColor, color)
        }
    }
    func skHideCloseButton(_ configuration: Bool = true) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skIsCloseButtonHidden, configuration)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func skInteractiveDismissDisabled(_ disabled: Bool = true) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skSheetInteractiveDismissDisabled, disabled)
        }
    }
    
    #if !os(macOS)
    func skSheetSize(_ dents: Set<PresentationDetent>) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skSheetSizeDents, dents)
        }
    }
    func skDragIndicatorVisibility(_ visibility: Visibility = .hidden) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skSheetDragIndicatorVisibility, visibility)
        }
    }
    func skSheetSize(_ dents: Set<PresentationDetent>, selection: Binding<PresentationDetent>) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skSheetSizeDentsSelection, selection).environment(\.skSheetSizeDents, dents)
        }
    }
    #else
    func skSheetSize(_ sheetSize: SKSheetSize = .large) -> SKCustomSheet{
        return SKCustomSheet(data: self.data) {
            self.environment(\.skSheetSize, sheetSize)
        }
    }
    #endif
}
