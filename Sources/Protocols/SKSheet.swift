//
//  SKSheetType.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public protocol SKSheet: View, SKSheetable{
    var options: Set<SKSheetOptions> { get }

    var id: String { get }
    @SKSheetBuilder var pages: [SKPage] { get }
}

public extension SKSheet{
    @ViewBuilder @MainActor @preconcurrency var body: some View{
        SKSheetProtocolView(sheet: self)
    }
}


struct SKSheetProtocolView<Sheet: SKSheet>: View{
    @Environment(\.skSheetManager) var skSheetManager
    let sheet: Sheet
    
    var color: Color{
        #if os(tvOS)
        if #unavailable(tvOS 18.0){
            return .blue
        }else{
            return .accentColor
        }
        #else
        return .accentColor
        #endif
    }
    var body: some View{
        let binding = skSheetManager.getPathBinding(forID: sheet.id)
        SKSheetView(pages: sheet.pages)
            .skSheetPathBinding(binding)
            .onChange(of: binding.wrappedValue) { _, newValue in
                skSheetManager.changesCount += 1
            }
            .environment(\.skIsCloseButtonHidden,sheet.options.first{ $0.id == 1}?.value1 as? Bool ?? false)
            .environment(\.skSheetInteractiveDismissDisabled, sheet.options.first{ $0.id == 2}?.value1 as? Bool ?? false)
            .environment(\.skSheetStyle, sheet.options.first{ $0.id == 3}?.value1 as? SKSheetStyle ?? .default)
            .environment(\.skSheetStyleDents, sheet.options.first{ $0.id == 4}?.value1 as? Set<PresentationDetent>)
            .environment(\.skSheetStyleDentsSelection, sheet.options.first{ $0.id == 4}?.value2 as? Binding<PresentationDetent>)
            .environment(\.skAccentColor, sheet.options.first{ $0.id == 5}?.value1 as? Color ?? color)
            .environment(\.skAlignment, sheet.options.first{ $0.id == 6}?.value1 as? HorizontalAlignment)
            .environment(\.skRowBackgroundColor, sheet.options.first{ $0.id == 7}?.value1 as? Color)
            .environment(\.skRowShape, sheet.options.first{ $0.id == 8}?.value1 as? CGFloat)
            .environment(\.skRowSpacing, sheet.options.first{ $0.id == 9}?.value1 as? CGFloat)
            .environment(\.skPrimaryColor, sheet.options.first{ $0.id == 10}?.value1 as? Color)
            .environment(\.skSecondaryColor, sheet.options.first{ $0.id == 11}?.value1 as? Color)
            .environment(\.skIsContinueButtonHidden, sheet.options.first{ $0.id == 12}?.value1 as? Bool ?? false)
            .environment(\.skIsUsingFullScreenCover, sheet.options.first{ $0.id == 13}?.value1 as? Bool ?? false)

    }
    
    init(sheet: Sheet) {
        self.sheet = sheet
    }
}
