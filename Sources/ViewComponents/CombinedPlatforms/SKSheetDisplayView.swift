//
//  SKSheetDisplayView.swift
//  SavelyUI
//
//  Created by Kamil Szpak on 15.01.2025.
//

import SwiftUI

struct SKSheetDisplayView: View {
    @State private var path: [Int] = []
    @Environment(\.skSheetManager) var sheetManager
    let index: Int

    var body: some View {
        if let sheet = sheetManager.getOpenedSheet(forIndex: index), sheetManager.isValidOpened(index: index){
            Group{
                if index == 0 {
                    Text("")
                        #if os(iOS) || os(tvOS)
                        .if{ content in
                            if sheet.sheet?.options.first{ $0.id == 13 }?.value1 as? Bool == true {
                                content
                                    .fullScreenCover(isPresented: sheet.isPresentedBinding){
                                        sheetContent()
                                    }
                            }else{
                                content
                                    .sheet(isPresented: sheet.isPresentedBinding){
                                        sheetContent()
                                    }
                            }
                        }
                        #else
                        .sheet(isPresented: sheet.isPresentedBinding){
                            sheetContent()
                        }
                        #endif

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
                    AnyView(customViewSheet.adjustedContent())
                }else{
                    sheet.view
                }
            }
        }
        #if os(iOS) || os(tvOS)
        .if{ content in
            if sheetManager.getOpenedSheet(forIndex: index + 1)?.sheet?.options.first{ $0.id == 13 }?.value1 as? Bool == true {
                content
                    .fullScreenCover(isPresented: sheetManager.getOpenedSheet(forIndex: index + 1)?.isPresentedBinding ?? .constant(false)) {
                        SKSheetDisplayView(index: index + 1)
                    }
            }else{
                content
                    .sheet(isPresented: sheetManager.getOpenedSheet(forIndex: index + 1)?.isPresentedBinding ?? .constant(false)) {
                        SKSheetDisplayView(index: index + 1)
                    }
            }
        }
        #else
        .sheet(isPresented: sheetManager.getOpenedSheet(forIndex: index + 1)?.isPresentedBinding ?? .constant(false)) {
            SKSheetDisplayView(index: index + 1)
        }
        #endif
    }

    init(index: Int = 0) {
        self.index = index
    }
}
