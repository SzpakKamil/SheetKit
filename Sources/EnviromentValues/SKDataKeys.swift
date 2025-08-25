//
//  SKDataKeys.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI
import Foundation

private struct SKSheetManagerKey: EnvironmentKey {
    static let defaultValue: SKSheetManager = .init()
}

private struct SKSheetActivityTypeKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

extension EnvironmentValues {
    public var skSheetManager: SKSheetManager {
        get { self[SKSheetManagerKey.self] }
        set { self[SKSheetManagerKey.self] = newValue }
    }
    var skSheetActivityType: String? {
        get { self[SKSheetActivityTypeKey.self] }
        set { self[SKSheetActivityTypeKey.self] = newValue }
    }
}

public extension View {
    func skSheetManager(_ manager: SKSheetManager, handoffActivityType: String? = nil) -> some View {
        SKSheetManagerView(manager: manager){
            self
        }
        .environment(\.skSheetActivityType, handoffActivityType)
    }
}


struct SKSheetManagerView<Content: View>: View {
    @State var skSheetManager: SKSheetManager
    @Environment(\.skSheetActivityType) var skSheetActivityType
    var view: () -> Content
    var body: some View {
        ZStack{
            if let skSheetActivityType{
                ZStack{
                    SKSheetDisplayView(index: 0)
                    view()
                }
                .onContinueUserActivity(skSheetActivityType) { activity in
                    skSheetManager.handleContinuingHandoff(activity: activity)
                }
                Text("")
                    .userActivity(skSheetActivityType, isActive: !skSheetManager.handoffableSheets.isEmpty) { activity in
                    print("Triggered activity")
                    skSheetManager.startUserActivity(activity: activity)
                }
                .id(skSheetManager.changesCount)

            }else{
                ZStack{
                    SKSheetDisplayView(index: 0)
                    view()
                }
            }
        }
        .environment(\.skSheetManager, skSheetManager)
    }
    
    init(manager: SKSheetManager, @ViewBuilder view: @escaping () -> Content) {
        self._skSheetManager = State(initialValue: manager)
        self.view = view
    }
}

