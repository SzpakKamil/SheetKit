//
//  ContentView.swift
//  AboutSheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI
import SheetKit

struct ContentView: View {
    @Environment(\.skSheetManager) var sheetManager

    var body: some View {
        Button("Show Example Sheet") {
            sheetManager.show(id: "ExampleSheet") {
                SKSheetView {
                    SKPage {
                        // Not Needed
                    }toolbar: {
                        SKToolbarItem(placement: .primary) { action in
                            SKButton("Button", systemImage: "pencil") {
                                action()
                            }
                        }
                    }
                    .skHideCloseButton()
                    .skHideContinueButton()
                }
            }
        }
    }
}
