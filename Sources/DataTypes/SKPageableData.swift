//
//  SKPageableData.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import Foundation
import SwiftUI

public struct SKPageableData{
    var content: [any SKComponent]
    var alert: SKAlert?
    let toolbar: SKToolbar
    var backgroundStyle: SKPageBackgroundStyle?
    var pageStyle: SKPageStyle?
    
    init(@SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.content = content()
        self.backgroundStyle = nil
        self.toolbar = SKToolbar(items: toolbar)
        self.pageStyle = nil
        self.alert = nil
    }
    init(@SKPageBuilder content: () -> [any SKComponent], toolbarItems: [SKToolbarItem]) {
        self.content = content()
        self.backgroundStyle = nil
        self.toolbar = SKToolbar(items: toolbarItems)
        self.pageStyle = nil
        self.alert = nil
    }
    
    init(content: [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.content = content
        self.backgroundStyle = nil
        self.toolbar = SKToolbar(items: toolbar)
        self.pageStyle = nil
        self.alert = nil
    }
    init(content: [any SKComponent], toolbarItems: [SKToolbarItem]) {
        self.content = content
        self.backgroundStyle = nil
        self.toolbar = SKToolbar(items: toolbarItems)
        self.pageStyle = nil
        self.alert = nil
    }
}
    
