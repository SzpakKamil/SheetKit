//
//  SKSheetModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI


public extension SKSheetView{
    func skAccentColor(_ color: Color = .accentColor) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skAccentColor, color)
        }
    }
    func skAlignment(_ alignment: HorizontalAlignment?) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skAlignment, alignment)
        }
    }
    func skRowBackground(_ color: Color? = nil) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skRowBackgroundColor, color)
        }
    }
    func skRowShape(cornerRadius: CGFloat? = nil) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skRowShape, cornerRadius)
        }
    }
    func skRowSpacing(_ spacing: CGFloat? = nil) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skRowSpacing, spacing)
        }
    }
    func skPrimaryTextColor(_ color: Color? = nil) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skPrimaryColor, color)
        }
    }
    func skSecondaryTextColor(_ color: Color? = nil) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skSecondaryColor, color)
        }
    }
    func skHideCloseButton(_ configuration: Bool = true) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skIsCloseButtonHidden, configuration)
        }
    }
    func skHideContinueButton(_ configuration: Bool = true) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skIsContinueButtonHidden, configuration)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func skInteractiveDismissDisabled(_ disabled: Bool = true) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skSheetInteractiveDismissDisabled, disabled)
        }
    }
    
    #if !os(macOS)
    func skSheetStyle(_ dents: Set<PresentationDetent>) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skSheetStyleDents, dents)
        }
    }
    func skDragIndicatorVisibility(_ visibility: Visibility = .hidden) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skSheetDragIndicatorVisibility, visibility)
        }
    }
    func skSheetStyle(_ dents: Set<PresentationDetent>, selection: Binding<PresentationDetent>) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skSheetStyleDentsSelection, selection).environment(\.skSheetStyleDents, dents)
        }
    }
    #else
    func skSheetStyle(_ sheetStyle: SKSheetStyle = .default) -> SKSheetView{
        return SKSheetView(pages: self.pages) {
            self.environment(\.skSheetStyle, sheetStyle)
        }
    }
    #endif
}
