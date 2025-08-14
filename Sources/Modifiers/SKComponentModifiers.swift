//
//  SKTitleModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 09/07/2025.
//

import SwiftUI
import Combine

public extension SKComponent{
    func skAccentColor(_ color: Color = .accentColor) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.environment(\.skAccentColor, color)
        }
    }
    func skAlignment(_ alignment: HorizontalAlignment?) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.environment(\.skAlignment, alignment)
        }
    }
    func skRowBackground(_ color: Color? = nil) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.environment(\.skRowBackgroundColor, color)
        }
    }
    func skRowShape(cornerRadius: CGFloat? = nil) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.environment(\.skRowShape, cornerRadius)
        }
    }
    func skRowSpacing(_ spacing: CGFloat? = nil) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.environment(\.skRowSpacing, spacing)
        }
    }
    func skPrimaryTextColor(_ color: Color? = nil) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.environment(\.skPrimaryColor, color)
        }
    }
    func skSecondaryTextColor(_ color: Color? = nil) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.environment(\.skSecondaryColor, color)
        }
    }
    
    
    
    
    
    
    
    
    
    nonisolated func onAppear(perform action: @escaping () -> Void) -> SKCustomView{
        return SKCustomView(type: self.type) {
            self.onAppear(perform: action)
        }
    }
    @available(iOS 17.0, *)
    nonisolated func onChange<V>(of value: V, initial: Bool = false, _ action: @escaping (V, V) -> Void) -> SKCustomView where V : Equatable{
        return SKCustomView(type: self.type){
            self.onChange(of: value) { action($0, $1)}
        }
    }
    
    nonisolated func onChange<V>(of value: V, initial: Bool = false, _ action: @escaping (V) -> Void) -> SKCustomView where V : Equatable{
        return SKCustomView(type: self.type){
            self.onChange(of: value) { action($0)}
        }
    }
    nonisolated func onChange<V>(of value: V, initial: Bool = false, _ action: @escaping () -> Void) -> SKCustomView where V : Equatable{
        return SKCustomView(type: self.type){
            self.onChange(of: value) { _ in action()}
        }
    }
    
    nonisolated func onReceive<P>(_ publisher: P, perform action: @escaping (P.Output) -> Void) -> SKCustomView where P : Publisher, P.Failure == Never{
        return SKCustomView(type: self.type){
            self.onReceive(publisher, perform: action)
        }
    }
    
    nonisolated func task(priority: TaskPriority = .userInitiated, _ action: @escaping () async -> Void) -> SKCustomView{
        return SKCustomView(type: self.type){
            self.task(priority: priority, action)
        }
    }
    nonisolated func customViewModifiers(@ViewBuilder content: @escaping (AnyView) -> some View) -> SKCustomView{
        return SKCustomView(type: self.type){
            content(self.erasedContent())
        }
    }
}


