//
//  SKTitleModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 09/07/2025.
//

import SwiftUI
import Combine

public extension SKComponent{
    func skAccentColor(_ color: Color? = .accentColor) -> SKCustomView<some View>{
        return SKCustomView(type: self.type) {
            self.environment(\.skAccentColor, color)
        }
    }
    func skAlignment(_ alignment: HorizontalAlignment?) -> SKCustomView<some View>{
        return SKCustomView(type: self.type) {
            self.environment(\.skAlignment, alignment)
        }
    }
    func skRowBackground(_ color: Color? = nil) -> SKCustomView<some View>{
        return SKCustomView(type: self.type) {
            self.environment(\.skRowBackgroundColor, color)
        }
    }
    func skRowShape(cornerRadius: CGFloat? = nil) -> SKCustomView<some View>{
        return SKCustomView(type: self.type) {
            self.environment(\.skRowShape, cornerRadius)
        }
    }
    func skRowSpacing(_ spacing: CGFloat? = nil) -> SKCustomView<some View>{
        return SKCustomView(type: self.type) {
            self.environment(\.skRowSpacing, spacing)
        }
    }
    func skPrimaryTextColor(_ color: Color? = nil) -> SKCustomView<some View>{
        return SKCustomView(type: self.type) {
            self.environment(\.skPrimaryColor, color)
        }
    }
    func skSecondaryTextColor(_ color: Color? = nil) -> SKCustomView<some View>{
        return SKCustomView(type: self.type) {
            self.environment(\.skSecondaryColor, color)
        }
    }
    
    
    
    
    
    
    nonisolated func onAppear(perform action: @escaping () -> Void) -> SKCustomView<some View>{
        return self.customViewModifiers{
            $0.onAppear(perform: action)
        }
    }
    
    @available(iOS 17.0, *)
    nonisolated func onChange<V>(of value: V, initial: Bool = false, _ action: @escaping (V, V) -> Void) -> SKCustomView<some View> where V : Equatable{
        return self.customViewModifiers{
            $0.onChange(of: value) { action($0, $1)}
        }
    }
    
    nonisolated func onChange<V>(of value: V, initial: Bool = false, _ action: @escaping (V) -> Void) -> SKCustomView<some View> where V : Equatable{
        return self.customViewModifiers{
            $0.onChange(of: value) { action($0)}
        }
    }
    nonisolated func onChange<V>(of value: V, initial: Bool = false, _ action: @escaping () -> Void) -> SKCustomView<some View> where V : Equatable{
        return self.customViewModifiers{
            $0.onChange(of: value) { _ in action()}
        }
    }
    
    nonisolated func onReceive<P>(_ publisher: P, perform action: @escaping (P.Output) -> Void) -> SKCustomView<some View> where P : Publisher, P.Failure == Never{
        return self.customViewModifiers{
            $0.onReceive(publisher, perform: action)
        }
    }
    
    nonisolated func task(priority: TaskPriority = .userInitiated, _ action: @escaping () async -> Void) -> SKCustomView<some View>{
        return self.customViewModifiers{
            $0.task(priority: priority, action)
        }
    }
    nonisolated func customViewModifiers(@ViewBuilder content: @escaping (AnyView) -> some View) -> SKCustomView<some View>{
        return SKCustomView(type: self.type){
            content(self.erasedContent())
        }
    }
}

