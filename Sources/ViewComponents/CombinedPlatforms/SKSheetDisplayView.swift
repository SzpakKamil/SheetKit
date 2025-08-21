//
//  SKSheetDisplayView.swift
//  SavelyUI
//
//  Created by Kamil Szpak on 15.01.2025.
//

import SwiftUI

public struct SKSheetDisplayView: View {
    @State private var path: [Int] = []
    @Environment(\.skSheetManager) var sheetManager
    let index: Int

    public var body: some View {
        if let sheet = sheetManager.getOpenedSheet(forIndex: index), sheetManager.isValidOpened(index: index){
            Group{
                if index == 0 {
                    Text("")
                        .sheet(isPresented: sheet.isPresentedBinding){
                            sheetContent()
                        }
                }else{
                    sheetContent()
                }
            }
            .onAppear{
                for sheet in sheetManager.openedSheets{
                    sheet.isPresentedBinding.wrappedValue = true
                }
            }
            .onChange(of: sheetManager.openedSheetsCount) { newValue in
                for sheet in sheetManager.openedSheets{
                    sheet.isPresentedBinding.wrappedValue = true
                }
            }
        }
    }
    
    @ViewBuilder
    func sheetContent() -> some View{
        Group{
            if let sheet = sheetManager.getOpenedSheet(forIndex: index){
                if let sheet = sheet.sheet{
                    AnyView(sheet)
                }else if let customViewSheet = sheet.customViewSheet{
                    AnyView(customViewSheet)
                }else{
                    sheet.view
                }
            }
        }
        .sheet(isPresented: sheetManager.getOpenedSheet(forIndex: index + 1)?.isPresentedBinding ?? .constant(false)) {
            SKSheetDisplayView(index: index + 1)
        }
    }

    public init(index: Int = 0) {
        self.index = index
    }
}
